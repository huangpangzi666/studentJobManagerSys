package com.submit.web.exception;

/**
 * 	用户操作异常
 * @author submitX
 *
 */
public class UserException extends Exception {

	private String msg;
	
	public UserException(String msg) {
		this.msg = msg;
	}

	public String getMsg() {
		return msg;
	}
	
}
