package com.lihuia.mysterious.common.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;



@Data
@Builder
public class Response<T> {

    private Integer code;
    private String message;
    private Boolean success;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime currentTime;
    private T data;
}
