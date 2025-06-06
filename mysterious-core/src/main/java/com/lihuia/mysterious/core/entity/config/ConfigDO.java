package com.lihuia.mysterious.core.entity.config;

import com.lihuia.mysterious.core.entity.base.BaseDO;
import lombok.Data;
import lombok.EqualsAndHashCode;



@Data
@EqualsAndHashCode(callSuper = true)
public class ConfigDO extends BaseDO<Long> {

    /** 配置字段 */
    private String configKey;

    /** 字段值 */
    private String configValue;

    /** 字段描述 */
    private String description;
}
