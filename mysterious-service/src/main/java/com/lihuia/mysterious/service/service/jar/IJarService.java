package com.lihuia.mysterious.service.service.jar;

import com.lihuia.mysterious.core.vo.jar.JarQuery;
import com.lihuia.mysterious.core.vo.jar.JarVO;
import com.lihuia.mysterious.core.vo.page.PageVO;
import com.lihuia.mysterious.core.vo.user.UserVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author lihuia.com
 * @date 2022/4/1 下午4:35
 */

public interface IJarService {

    /**
     * 上传用例脚本依赖的JAR包
     * @param testCaseId
     * @param jarFile
     * @param userVO
     * @return
     */
    Boolean uploadJar(Long testCaseId, MultipartFile jarFile, UserVO userVO);

    /**
     * 更新JAR包
     * @param jarVO
     * @param userVO
     * @return
     */
    Boolean updateJar(JarVO jarVO, UserVO userVO);

    /**
     * 删除JAR包
     * @param id
     */
    Boolean deleteJar(Long id);

    /**
     * 分页查询JAR列表
     * @param jarQuery
     * @return
     */
    PageVO<JarVO> getJarList(JarQuery jarQuery);

    /**
     * 查询用例关联的所有JAR
     * @param testCaseId
     * @return
     */
    List<JarVO> getByTestCaseId(Long testCaseId);
}
