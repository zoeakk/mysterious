package com.lihuia.mysterious.web.utils;

import com.lihuia.mysterious.core.vo.user.UserVO;
import org.springframework.core.NamedThreadLocal;



public class UserUtils {

    private final static NamedThreadLocal<UserVO> namedThreadLocal = new NamedThreadLocal<>("user");

    public static UserVO getCurrent() {
        return namedThreadLocal.get();
    }

    public static void setCurrent(UserVO userVO) {
        namedThreadLocal.set(userVO);
    }

    public static void removeCurrent() {
        namedThreadLocal.remove();
    }
}
