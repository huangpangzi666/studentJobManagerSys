package com.submit.web.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.google.code.kaptcha.Constants;
import com.submit.entity.TLogin;
import com.submit.service.admin.ILoginService;
import com.submit.web.controller.base.BaseController;

public class UserFormAuthenticationFilter extends FormAuthenticationFilter {

	@Autowired
	private ILoginService loginService;
	
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {

		// 从session获取正确验证码
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpSession session = httpServletRequest.getSession();
		// 取出session的验证码（正确的验证码）
		String validateCode = (String) session.getAttribute(Constants.KAPTCHA_SESSION_KEY);

		// 取出页面的验证码
		// 输入的验证和session中的验证进行对比
		String randomcode = httpServletRequest.getParameter("validateCode");
		if (randomcode != null && validateCode != null && !randomcode.toUpperCase().equals(validateCode)) {
			// 如果校验失败，将验证码错误失败信息，通过shiroLoginFailure设置到request中
			httpServletRequest.setAttribute("shiroLoginFailure", "validateCodeError");
			session.removeAttribute(Constants.KAPTCHA_SESSION_KEY);
			// 拒绝访问，不再校验账号和密码
			return true;
		}
		return super.onAccessDenied(request, response);
	}

	// 登录成功保存用户信息到session中
	@Override
	protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request,
			ServletResponse response) throws Exception {
		TLogin login = (TLogin) subject.getPrincipal();
		HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
		HttpServletResponse  httpServletResponse= WebUtils.toHttp(response);
		
		HttpSession session = httpServletRequest.getSession();
		session.setAttribute("user", login);
		// 记录登录时间
		TLogin tLogin = new TLogin();
		tLogin.setLastLoginTime(new Date());
		tLogin.setId(login.getId());
		loginService.recoderAccessTime(tLogin);
		
		SavedRequest savedRequest = WebUtils.getAndClearSavedRequest(request);
		boolean defaultUrl = Boolean.FALSE;
		if (savedRequest == null || savedRequest.getRequestURI() == null || savedRequest.getRequestURI().contains("login")) {
			defaultUrl = Boolean.TRUE;
		}
		String contextPath = httpServletRequest.getContextPath();
		if ("XMLHttpRequest".equalsIgnoreCase(httpServletRequest.getHeader("X-Requested-With"))) {
			// ajax请求
			Map<String, String> map = new HashMap<>();
			map.put("status", "SUCCESS");
			if (defaultUrl == Boolean.TRUE) {
				map.put("uri", "");
			} else {
				map.put("uri",  savedRequest.getRequestURI().replaceAll(contextPath, ""));
			}
			this.writeJson(httpServletResponse, map);
		 } else {
			 if (defaultUrl == Boolean.TRUE) {
				 WebUtils.issueRedirect(request, response, "", null, true);
			 } else {
				 WebUtils.issueRedirect(request, response,  savedRequest.getRequestURI().replaceAll(contextPath, ""), null, true);
			 }
		 }
		return false;
	}
	
	/**
	 * 当为ajax请求时进行回写 
	 * @param httpServletResponse
	 * @throws IOException 
	 */
	protected void writeJson(HttpServletResponse httpServletResponse, Map map) throws IOException {
		httpServletResponse.setCharacterEncoding("UTF-8");
		PrintWriter out = httpServletResponse.getWriter();
		String json = JSON.toJSONString(map);
		out.write(json);
		out.flush();
		out.close();
	}
}
