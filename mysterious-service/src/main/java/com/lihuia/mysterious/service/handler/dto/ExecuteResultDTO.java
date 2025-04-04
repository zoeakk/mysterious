package com.lihuia.mysterious.service.handler.dto;

import com.lihuia.mysterious.service.redis.RedisService;
import lombok.Data;
import lombok.EqualsAndHashCode;



@Data
@EqualsAndHashCode(callSuper = true)
public class ExecuteResultDTO extends ResultDTO {

    private RedisService redisService;
}
