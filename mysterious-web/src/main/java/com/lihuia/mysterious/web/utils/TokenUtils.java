package com.lihuia.mysterious.web.utils;

import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;



public class TokenUtils {

    /**
     * 从请求里捞token字段；先查看header，如果没有的话，再查看参数
     * @param httpRequest
     * @return
     */
    public static String getToken(HttpServletRequest httpRequest) {
        String token = httpRequest.getHeader("token");
        if (StringUtils.isBlank(token)) {
            token = httpRequest.getParameter("token");
        }
        return token;
    }
}
