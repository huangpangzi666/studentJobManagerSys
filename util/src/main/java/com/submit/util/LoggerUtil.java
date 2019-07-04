package com.submit.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 	日志工具类
 * @author submitX
 *
 */
public class LoggerUtil {

	private final static boolean isDebug = LoggerFactory.getLogger(LoggerUtil.class).isDebugEnabled();
	
	/**
	 * 	info输出
	 * @param clz
	 * @param msg
	 */
	public static void info(Class<? extends Object> clz, String msg) {
		if (!isDebug) {
			return;
		}
		Logger logger = LoggerFactory.getLogger(clz);
		logger.info(msg);
	}
	
	/**
	 * 	debug输出
	 * @param clz
	 * @param msg
	 * @param e
	 */
	public static void debug(Class<? extends Object> clz, String msg, Exception e) {
		if (!isDebug) {
			return;
		}
		Logger logger = LoggerFactory.getLogger(clz);
		logger.debug(msg, e);
	}
	
	/**
	 * 	error输出
	 * @param clz
	 * @param msg
	 * @param e
	 */
	public static void error(Class<? extends Object> clz, String msg, Exception e) {
		Logger logger = LoggerFactory.getLogger(clz);
		if (null == e) {
			logger.error(msg);
		} else {
			logger.error(msg, e);
		}
	}
	
	public static void error(Class<? extends Object> clz, String msg) {
		error(clz, msg, null);
	}
}
 