package com.submit.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.shiro.crypto.hash.Md5Hash;

/**
 * 	md5加密算法工具
 * @author submitX
 *
 */
public class MD5Util {
	private final static String salt = "xianz.vip";
	private static int hashIterations = 9;
	/**
	 * 使用md5的盐值算法进行加密
	 * 
	 */
	public static String md5Salt(String text) {
		Md5Hash hash = new Md5Hash(text, salt, hashIterations );
		return hash.toString();
	}
	
	public static String md5(String plainText) {
		byte[] secretBytes = null;
		try {
			secretBytes = MessageDigest.getInstance("md5").digest(
					plainText.getBytes());
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("没有md5这个算法！");
		}
		String md5code = new BigInteger(1, secretBytes).toString(16);// 16进制数字
		// 如果生成数字未满32位，需要前面补0
		for (int i = 0; i < 32 - md5code.length(); i++) {
			md5code = "0" + md5code;
		}
		return md5code;
	}
	public static void main(String[] args) {
	}
}