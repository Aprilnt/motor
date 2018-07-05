package com.yidu.motor.util;

import java.util.UUID;

/**
 * 工具类
 * @author crank
 *
 */
public class IDGenerator {
	
	/**
	 * 获取16位随机ID
	 * @return String 字符串
	 */
	public static String getID(){
		return  UUID.randomUUID() //获得32位的UUID
				.toString() //转换为字符串
				.replace("-", "") //去掉中间的-
				.toUpperCase() //转换为大写
				.substring(0, 16);	//取前面16位	 
	}
}
