package com.lihuia.mysterious.core.mapper.csv;

import com.lihuia.mysterious.core.entity.csv.CsvDO;
import com.lihuia.mysterious.core.mapper.base.BaseMapper;

import java.util.List;

/**
 * @author lihuia.com
 * @date 2022/4/1 下午3:31
 */
public interface CsvMapper extends BaseMapper<CsvDO> {

    Integer getCsvCount(String srcName, Long testCaseId, Long creatorId);

    List<CsvDO> getCsvList(String srcName, Long testCaseId, Long creatorId, Integer offset, Integer limit);

    List<CsvDO> getByTestCaseId(Long testCaseId);

    List<CsvDO> getExistCsvList(Long testCaseId, String srcName, String testCaseCsvDir);
}
