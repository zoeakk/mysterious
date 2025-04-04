package com.lihuia.mysterious.common.convert;

import com.lihuia.mysterious.common.exception.MysteriousException;
import com.lihuia.mysterious.common.response.ResponseCodeEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;



@Slf4j
public class BeanConverter {

    /**
     * 将给定对象转换为另一个类的实例
     * 此方法用于实现对象到对象的复制，其中源对象和目标对象具有相似的属性结构
     * 它利用反射创建目标类的实例，并使用BeanUtils复制源对象的属性到目标对象
     *
     * @param object 要转换的源对象
     * @param classZz 目标类的Class对象，用于创建目标对象
     * @param <T> 泛型参数，表示目标类的类型
     * @return 返回转换后的目标类实例如果源对象为null，则返回null
     * @throws MysteriousException 如果在转换过程中发生异常，抛出自定义异常
     */
    public static <T> T doSingle(Object object, Class<T> classZz) {
        if (object == null) {
            return null;
        }
        try {
            // 通过反射创建目标类的实例
            T t = classZz.getDeclaredConstructor().newInstance();
            // 使用BeanUtils工具类复制属性
            BeanUtils.copyProperties(object, t);
            return t;
        } catch (Exception e) {
            // 捕获并处理转换过程中可能发生的任何异常
            throw new MysteriousException(ResponseCodeEnum.SYSTEM_ERROR);
        }
    }

    /**
     * 将给定的对象列表转换为指定类型的列表
     * 该方法使用Java的反射机制来转换对象类型，因此可以处理各种不同类型的对象
     *
     * @param objects 待转换的对象列表，类型为任意
     * @param classZz 目标列表元素的类类型，用于指定转换后的列表元素类型
     * @param <T> 泛型参数，表示目标列表元素的类型
     * @return 转换后的指定类型列表如果输入列表为空或null，则返回空列表
     * @throws MysteriousException 当转换过程中发生异常时，抛出此自定义异常
     */
    public static <T> List<T> doList(List<?> objects, Class<T> classZz) {
        // 检查输入列表是否为空或null，如果是，则直接返回空列表
        if (objects == null || objects.isEmpty()) {
            return Collections.emptyList();
        }
        try {
            // 使用流处理来转换列表中的每个对象到指定类型
            return objects.stream()
                    .map(obj -> doSingle(obj, classZz))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            // 当转换过程中遇到异常时，抛出自定义异常
            throw new MysteriousException(ResponseCodeEnum.SYSTEM_ERROR);
        }
    }
}
