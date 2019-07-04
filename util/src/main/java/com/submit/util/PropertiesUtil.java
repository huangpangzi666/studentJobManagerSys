package com.submit.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.StringUtils;

/**
 * 	配置文件properties的工具类
 * 	@author wuxian
 *
 */

public class PropertiesUtil {
	
	private static Properties properties = new Properties();
	static {
		ClassPathResource cpr = new ClassPathResource("overall-config.properties");
		InputStream in = null;
		try {
			in = cpr.getInputStream();
		} catch (IOException e1) {
			LoggerUtil.error(PropertiesUtil.class, "overall-config.properties 配置文件没有找到", e1);
		}
		try {
			properties.load(new InputStreamReader(in, "UTF-8"));
		} catch (IOException e) {
			LoggerUtil.error(PropertiesUtil.class, "overall-config.properties配置文件的inputStream出现问题,不存在流", e);
			e.printStackTrace();
		}
	}
	
	/**
	 * 	获取一个key的value值
	 * @param key 键
	 * @return key的值
	 * @throws IOException
	 */
	public static String getProperty(String key) {
		return properties.getProperty(key);
	}
	
	/**
	 * 	设置配置文件的属性,如果不存在则添加
	 * @param key 键
	 * @param value 值
	 */
	public static synchronized void setProperty(String key, String value) {
		if (StringUtils.isEmpty(properties.getProperty(key))) {
			properties.put(key, value);
		} else {
			properties.setProperty(key, value);
		}
	}
	
}
