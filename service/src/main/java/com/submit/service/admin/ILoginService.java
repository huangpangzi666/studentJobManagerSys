package com.submit.service.admin;

import com.submit.entity.TLogin;

/**
 * 登陆业务
 * @author submitX
 *
 */
public interface ILoginService {

	/**
	 * 	修改登陆信息
	 * @param login
	 */
	void update(TLogin login);
	
	/**
	 * 	iser_id 获取一个login
	 * @param id
	 * @return
	 */
	TLogin getByUserId(Integer uid);

	/**
	 * 	设置访问时间
	 * @param tLogin
	 */
	void recoderAccessTime(TLogin tLogin);

}
