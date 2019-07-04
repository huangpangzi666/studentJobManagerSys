package com.submit.web.controller.admin;

import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.submit.entity.TLogin;
import com.submit.service.admin.ILoginService;
import com.submit.web.controller.base.BaseController;

/**
 * 	登陆控制
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("/auth")
public class LoginController extends BaseController {

	@Autowired
	private ILoginService service;
	
	/**
	 * 	更新用户的状态
	 * @param login
	 * @return
	 */
	@RequiresPermissions({"teacher:update:status", "student:update:status"})
	@RequestMapping(value="/status", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> loginUpdate(TLogin login) {
		try {
			service.update(login);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
}
