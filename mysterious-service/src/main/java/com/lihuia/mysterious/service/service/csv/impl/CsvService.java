package com.lihuia.mysterious.service.service.csv.impl;

import com.alibaba.fastjson.JSON;
import com.lihuia.mysterious.common.convert.BeanConverter;
import com.lihuia.mysterious.common.exception.MysteriousException;
import com.lihuia.mysterious.common.io.MysteriousFileUtils;
import com.lihuia.mysterious.common.jmeter.JMeterUtil;
import com.lihuia.mysterious.common.response.ResponseCodeEnum;
import com.lihuia.mysterious.common.ssh.SSHUtils;
import com.lihuia.mysterious.core.entity.csv.CsvDO;
import com.lihuia.mysterious.core.mapper.csv.CsvMapper;
import com.lihuia.mysterious.core.vo.csv.CsvQuery;
import com.lihuia.mysterious.core.vo.csv.CsvVO;
import com.lihuia.mysterious.core.vo.jmx.JmxVO;
import com.lihuia.mysterious.core.vo.jmx.sample.csv.CsvDataVO;
import com.lihuia.mysterious.core.vo.jmx.sample.csv.CsvFileVO;
import com.lihuia.mysterious.core.vo.node.NodeVO;
import com.lihuia.mysterious.core.vo.page.PageVO;
import com.lihuia.mysterious.core.vo.testcase.TestCaseFullVO;
import com.lihuia.mysterious.core.vo.user.UserVO;
import com.lihuia.mysterious.service.crud.CRUDEntity;
import com.lihuia.mysterious.service.enums.JMeterScriptEnum;
import com.lihuia.mysterious.service.service.csv.ICsvService;
import com.lihuia.mysterious.service.service.jmx.sample.csv.ICsvDataService;
import com.lihuia.mysterious.service.service.node.INodeService;
import com.lihuia.mysterious.service.service.testcase.ITestCaseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lihuia.com
 * @date 2023/4/1 下午4:34
 */

@Slf4j
@Service
public class CsvService implements ICsvService {

    @Autowired
    private CRUDEntity<CsvDO> crudEntity;

    @Autowired
    private JMeterUtil jMeterUtil;

    @Autowired
    private MysteriousFileUtils fileUtils;

    @Autowired
    private CsvMapper csvMapper;

    @Autowired
    private ITestCaseService testCaseService;

    @Autowired
    private INodeService nodeService;

    @Autowired
    private ICsvDataService csvDataService;

    private void checkCsvParam(CsvVO csvVO) {
        if (ObjectUtils.isEmpty(csvVO)) {
            throw new MysteriousException(ResponseCodeEnum.PARAMS_EMPTY);
        }
        if (ObjectUtils.isEmpty(csvVO.getId())) {
            throw new MysteriousException(ResponseCodeEnum.PARAM_MISSING);
        }
        if (ObjectUtils.isEmpty(csvMapper.getById(csvVO.getId()))) {
            throw new MysteriousException(ResponseCodeEnum.CSV_NOT_EXIST);
        }
    }

    private void checkOnlineCsvFileExist(CsvDataVO csvDataVO, String csvFile) {
        /** 脚本编辑里为空,缺少csvFile模块 */
        if (ObjectUtils.isEmpty(csvDataVO)) {
            throw new MysteriousException("在线模式: 脚本编辑里CSV文件模块为空, 缺少该文件模块, " + csvFile);
        }
        /** 脚本编辑里csvFile模块和上传文件不匹配 */
        if (!csvDataVO.getCsvFileVOList().stream().map(CsvFileVO::getFilename).collect(Collectors.toList()).contains(csvFile)) {
            throw new MysteriousException("在线模式: 脚本编辑里CSV文件模块和上传文件不匹配, " + csvFile);
        }
    }

    @Transactional
    @Override
    public Boolean uploadCsv(Long testCaseId, MultipartFile csvFile, UserVO userVO) {
        TestCaseFullVO testCaseFullVO = testCaseService.getFullVO(testCaseId);
        /** 上传csv的时候，需要修改jmx脚本里csv的文件路径，因此必须先上传jmx，再上传csv */
        if (ObjectUtils.isEmpty(testCaseFullVO.getJmxVO())) {
            throw new MysteriousException(ResponseCodeEnum.JMX_NOT_EXIST);
        }
        String csvFileName = csvFile.getOriginalFilename();
        JmxVO jmxVO = testCaseFullVO.getJmxVO();
        /** 2024-10-12 如果是在线编辑的脚本,上传的时候需要校验此时上传的csvFile在jmx模块里是否添加了该csv文件模块 */
        if (JMeterScriptEnum.ONLINE_JMX.getCode().equals(jmxVO.getJmeterScriptType()) ) {
            /** 如果在线jmx里文件模块不存在,不让上传 */
            checkOnlineCsvFileExist(csvDataService.getByJmxId(jmxVO.getId()), csvFileName);
        }

        /** 定位到Master节点的jmx脚本，这个是重命名后的脚本全路径 */
        String jmxFilePath = jmxVO.getJmxDir() + jmxVO.getDstName();
        String debugJmxFilePath = jmxVO.getJmxDir() + "debug_" + jmxVO.getDstName();

        /** master节点保存csv文件的目录 */
        String csvDir = testCaseFullVO.getTestCaseDir() + "csv/";
        if (ObjectUtils.isEmpty(csvFileName)
                || !csvFileName.contains(".csv")
                || StringUtils.isBlank(csvFileName)
                || csvFileName.contains(" ")) {
            throw new MysteriousException(ResponseCodeEnum.CSV_NAME_ERROR);
        }
        String csvFilePath = csvDir + csvFileName;
        /** 脚本csv控件设置的name为上传的csv文件名 */
        if (JMeterScriptEnum.UPLOAD_JMX.getCode().equals(jmxVO.getJmeterScriptType())
                && !jMeterUtil.existCSVFileName(jmxFilePath, csvFileName)) {
            throw new MysteriousException(ResponseCodeEnum.CSV_NAME_ERROR);
        }
        /** 检验csv文件是否已经上传过了, name+path确定 */
        if (!CollectionUtils.isEmpty(csvMapper.getExistCsvList(testCaseId, csvFileName, csvDir))) {
            throw new MysteriousException(ResponseCodeEnum.CSV_IS_EXIST);
        }
        /** 更新csv表，新增记录 */
        CsvDO csvDO = new CsvDO();
        crudEntity.addT(csvDO, userVO);
        csvDO.setSrcName(csvFileName);
        csvDO.setDstName(csvFileName);
        csvDO.setDescription(testCaseFullVO.getName());
        csvDO.setTestCaseId(testCaseId);
        csvDO.setCsvDir(csvDir);
        log.info("新增CSV文件: {}", JSON.toJSONString(csvDO));
        csvMapper.add(csvDO);

        /** 上传csv文件到master节点 */
        log.info("上传CSV文件到master节点, csvFilePath: {}, csvFile: {}", csvFilePath, csvFile);
        fileUtils.uploadFile(csvFilePath, csvFile);

        /** 再将master节点上的csv文件同步到slave节点，所有节点csv文件路径一致
         * slave节点不管是否启用，都上传没有问题；在压测的时候，只执行enable的压力机 */
        List<NodeVO> enableNodeList = nodeService.getEnableNodeList();
        log.info("上传CSV文件，已启用的slave节点: {}", JSON.toJSONString(enableNodeList));
        if (!CollectionUtils.isEmpty(enableNodeList)) {
            for (NodeVO nodeVO : enableNodeList) {
                /** 所有启用的节点都必须同步csv文件 */
                SSHUtils ssh = new SSHUtils(nodeVO.getHost(), nodeVO.getPort(), nodeVO.getUsername(), nodeVO.getPassword());
                ssh.scpFile(csvFilePath, csvDir);
            }
        }
        /**
         * jmxFilePath：master节点要修改的脚本文件
         * csvFileName：jmx脚本里testname的值，也就是上传的csv文件文件名
         * csvFilePath：上传后，csv文件的全路径，也就是会修改的filename值
         */
        /**
         * 如果是上传的jmx，脚本里会有csv节点相关内容，只需要找name就可以定位到位置
         */
        if (JMeterScriptEnum.UPLOAD_JMX.getCode().equals(jmxVO.getJmeterScriptType())) {
            log.info("上传模式: 上传CSV文件后, 更新本地上传的JMX脚本, jmxFilePath: {}, csvFileName: {}, csvFilePath: {}", jmxFilePath, csvFileName, csvFilePath);
            jMeterUtil.updateJmxCsvFilePath(jmxFilePath, csvFileName, csvFilePath);
            jMeterUtil.updateJmxCsvFilePath(debugJmxFilePath, csvFileName, csvFilePath);
        } else if (JMeterScriptEnum.ONLINE_JMX.getCode().equals(jmxVO.getJmeterScriptType())) {
            log.info("在线模式: 上传CSV文件后, 更新在线编辑的JMX脚本, jmxFilePath: {}, csvFileName: {}, csvFilePath: {}", jmxFilePath, csvFileName, csvFilePath);
            jMeterUtil.updateJmxCsvFilePath(jmxFilePath, csvFileName, csvFilePath);
            jMeterUtil.updateJmxCsvFilePath(debugJmxFilePath, csvFileName, csvFilePath);
        } else {
            throw new MysteriousException(ResponseCodeEnum.SCRIPT_TYPE_ERROR);
        }
        return true;
    }

    @Transactional
    @Override
    public Boolean deleteCsv(Long id) {
        CsvDO csvDO = csvMapper.getById(id);
        if (ObjectUtils.isEmpty(csvDO)) {
            throw new MysteriousException(ResponseCodeEnum.FILE_NOT_EXIST);
        }
        /** Csv文件保存在master和slave节点上，删除记录，再删除文件；事务 */
        log.info("删除CSV文件: {}", id);
        csvMapper.delete(id);

        /** 平台的机器,master节点，删除 */
        log.info("删除master节点CSV文件: {}", JSON.toJSONString(csvDO));
        fileUtils.rmFile(csvDO.getCsvDir() + csvDO.getDstName());

        /** slave节点机器删除 */
        List<NodeVO> enableNodeList = nodeService.getEnableNodeList();
        log.info("删除CSV文件， 已启用的slave节点: {}", JSON.toJSONString(enableNodeList));
        if (!CollectionUtils.isEmpty(enableNodeList)) {
            for (NodeVO nodeVO : enableNodeList) {
                SSHUtils ssh = new SSHUtils(nodeVO.getHost(), nodeVO.getPort(), nodeVO.getUsername(), nodeVO.getPassword());
                ssh.execCommand("rm -rf " + csvDO.getCsvDir() + csvDO.getDstName());
            }
        }

        return true;
    }

    @Override
    public Boolean updateCsv(CsvVO csvVO, UserVO userVO) {
        checkCsvParam(csvVO);
        CsvDO csvDO = BeanConverter.doSingle(csvVO, CsvDO.class);
        csvDO.setId(csvVO.getId());
        crudEntity.updateT(csvDO, userVO);
        return csvMapper.update(csvDO) > 0;
    }

    @Override
    public PageVO<CsvVO> getCsvList(CsvQuery query) {
        PageVO<CsvVO> pageVO = new PageVO<>();
        Integer offset = pageVO.getOffset(query.getPage(), query.getSize());
        Integer total = csvMapper.getCsvCount(query.getSrcName(), query.getTestCaseId());
        if (total.compareTo(0) > 0) {
            pageVO.setTotal(total);
            List<CsvDO> csvDOList =
                    csvMapper.getCsvList(query.getSrcName(), query.getTestCaseId(), offset, query.getSize());
            if (!CollectionUtils.isEmpty(csvDOList)) {
                pageVO.setList(csvDOList.stream().map(csvDO -> {
                    CsvVO csvVO = BeanConverter.doSingle(csvDO, CsvVO.class);
                    csvVO.setId(csvDO.getId());
                    return csvVO;
                }).collect(Collectors.toList()));
            }
        }
        return pageVO;
    }

    @Override
    public List<CsvVO> getByTestCaseId(Long testCaseId) {
        List<CsvDO> csvDOList = csvMapper.getByTestCaseId(testCaseId);
        if (CollectionUtils.isEmpty(csvDOList)) {
            return Collections.emptyList();
        }
        return csvDOList.stream().map(csvDO -> {
            CsvVO csvVO = BeanConverter.doSingle(csvDO, CsvVO.class);
            csvVO.setId(csvDO.getId());
            return csvVO;
        }).collect(Collectors.toList());
    }

    @Override
    public List<CsvDO> getCsvDOList(Long testCaseId) {
        return csvMapper.getByTestCaseId(testCaseId);
    }

    @Override
    public CsvVO getCsvVO(Long id) {
        CsvDO csvDO = csvMapper.getById(id);
        if (ObjectUtils.isEmpty(csvDO)) {
            throw new MysteriousException(ResponseCodeEnum.FILE_NOT_EXIST);
        }
        CsvVO csvVO = BeanConverter.doSingle(csvDO, CsvVO.class);
        csvVO.setId(id);
        return csvVO;
    }
}
