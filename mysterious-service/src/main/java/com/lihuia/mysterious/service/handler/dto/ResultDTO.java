package com.lihuia.mysterious.service.handler.dto;

import com.lihuia.mysterious.core.entity.report.ReportDO;
import com.lihuia.mysterious.core.entity.testcase.TestCaseDO;
import com.lihuia.mysterious.core.mapper.report.ReportMapper;
import com.lihuia.mysterious.core.mapper.testcase.TestCaseMapper;
import com.lihuia.mysterious.service.redis.RedisService;
import lombok.Data;

import java.io.ByteArrayOutputStream;

/**
 * @author lihuia.com
 * @date 2023/4/14 9:01 PM
 */

@Data
public class ResultDTO {

    /**
     * 用于存储输出结果的字节数组输出流
     */
    private ByteArrayOutputStream outputStream;

    /**
     * 用于存储错误信息的字节数组输出流
     */
    private ByteArrayOutputStream errorStream;

    /**
     * 测试用例数据对象，用于与数据库交互测试用例信息
     */
    private TestCaseDO testCaseDO;

    /**
     * 报告数据对象，用于与数据库交互测试报告信息
     */
    private ReportDO reportDO;

    /**
     * 测试用例映射器，用于执行测试用例相关的数据库操作
     */
    private TestCaseMapper testCaseMapper;

    /**
     * 报告映射器，用于执行测试报告相关的数据库操作
     */
    private ReportMapper reportMapper;

    /**
     * Redis服务，用于与Redis数据库交互，可以用于缓存、消息订阅等
     */
    private RedisService redisService;
}
