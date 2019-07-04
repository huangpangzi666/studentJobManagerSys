package com.submit.web.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.Base64Utils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.submit.entity.TLogin;
import com.submit.entity.TStudent;
import com.submit.entity.TTeacher;
import com.submit.service.admin.ILoginService;
import com.submit.service.admin.IStudentService;
import com.submit.service.admin.ITeacherService;
import com.submit.util.MD5Util;
import com.submit.util.MailUtil;
import com.submit.util.SessionManagerUtil;
import com.submit.util.Utils;
import com.submit.web.controller.base.BaseController;
import com.submit.web.exception.UserException;

/**
 * 	用户的控制层
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
public class UserController extends BaseController {

	@Autowired
	private IStudentService studentService;
	@Autowired
	private ITeacherService teacherService;
	@Autowired
	private ILoginService loginService;
	
	/**
	 * 	前往login页面
	 * @return
	 */
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginUI() {
		return  URL_LOGIN;
	}
	/**
	 * 	前往没有权限页面
	 * @return
	 */
	@RequestMapping(value="/unauthorized", method=RequestMethod.GET)
	public String unauthorizedUI() {
		return URL_UNAUTHORIZED;
	}
	/**
	 * 	前往404页面
	 * @return
	 */
	@RequestMapping(value="/404", method=RequestMethod.GET)
	public String noPageUI() {
		return URL_404;
	}
	
	/**
	 * 	前往首页面
	 * @return
	 */
	@RequiresUser
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String indexUI() {
		return "index";
	}
	 
	 /**
	  * 前往忘记密码页面
	  * @return
	  */
	 @RequestMapping(value="/forget", method=RequestMethod.GET)
	 public String forgetUI() {
		 return "open/forget";
	 }
	 
	 /**
	  * 	登录失败处理返回信息，登录操作由shiro操作，若成功将自动前往上一个页面
	  * @param request
	  * @return
	  * @throws UserException 
	  * @throws Exception 
	  */
	 @RequestMapping(value="/login", method=RequestMethod.POST)
	 @ResponseBody
	 public Map<String, Object> login(HttpServletRequest request) throws UserException, Exception {
		//如果登陆失败从request中获取认证异常信息，shiroLoginFailure就是shiro异常类的全限定名
		String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
		//根据shiro返回的异常类路径判断
		if(exceptionClassName != null) {
			resultMap.put(resultKey, ResultValue.FAIL);
			if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
				resultMap.put("msg", "账号不存在");
			} else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
				resultMap.put("msg", "密码错误");
			} else if("validateCodeError".equals(exceptionClassName)){
				resultMap.put("msg", "验证码错误");
			} else if (LockedAccountException.class.getName().equals(exceptionClassName)){
				resultMap.put("msg", "您已被禁止登录");
			} else {
				resultMap.put("msg", "未知错误");
			}
		} else {
			resultMap.put(resultKey, ResultValue.SUCCESS);
		}
		return resultMap;
	 }
	 
	 /**
	  * 	校验用户的email是否已经被注册
	  * @param email
	  * @param isStudent
	  * @return valid为true表示可以被注册
	  */
	 @RequiresAuthentication
	 @RequestMapping(value="/api-email-able", method=RequestMethod.GET)
	 @ResponseBody
	 public Map<String, Object> apiEmailIsExist(@RequestParam("email") String email, @RequestParam("flag") boolean isStudent) {
		 boolean exist = false;
		 if (isStudent == Boolean.TRUE) {
			 exist = studentService.validEmailExist(email);
		 } else {
			 exist = teacherService.validEmailExist(email);
		 }
		 resultMap.put("valid", !exist);
		 return resultMap;
	 }
	 
	 /**
	  * 	忘记密码,重设新的默认密码
	  * @param vaild
	  * @return
	  */
	 @RequestMapping(value="/newpass", method=RequestMethod.PUT)
	 @ResponseBody
	 public Map<String, Object> resetNewDefaultPassword(HttpServletRequest request, @RequestParam("userId") Integer userId, @RequestParam("vaild") String vaild,
			 @RequestParam("email") String email) {
		 String key = (String) request.getSession().getAttribute(MailUtil.EMAIL_KEY);
		 try {
			 if (key == null) {
				 throw new Exception("验证码过期");
			 }
			 if (vaild == null || vaild.trim().equals("") || !vaild.equals(key)) {
				 throw new Exception("验证码错误");
			 }
			 // 验证码正确
			 TLogin login = loginService.getByUserId(userId);
			 if (login == null) {
				 throw new Exception("用户不存在");
			 }
			 // 校验邮箱与用户邮箱是否匹配
			 if (userId > 9999) {
				 TStudent student = studentService.getById(userId);
				 if (StringUtils.isEmpty(student.getEmail())) {
					 throw new Exception("用户未设置邮箱，请联系管理员");
				 }
				 if (!student.getEmail().equals(StringUtils.trim(email))) {
					 throw new Exception("用户邮箱与输入的邮箱不匹配");
				 }
			 } else {
				 TTeacher teacher = teacherService.getById(userId);
				 if (StringUtils.isEmpty(teacher.getEmail())) {
					 throw new Exception("用户未设置邮箱，请联系管理员");
				 }
				 if (!teacher.getEmail().equals(StringUtils.trim(email))) {
					 throw new Exception("用户邮箱与输入的邮箱不匹配");
				 }
			 }
			 // 更新密码
			 TLogin newLogin = new TLogin();
			 newLogin.setId(login.getId());
			 String newPassword = Utils.getUUID();
			 newPassword = newPassword.substring(0, 24);
			 newLogin.setPassword(MD5Util.md5Salt(newPassword));
			 loginService.update(newLogin);
			 
			 // 更新用户修改时间
			 if (userId > 9999) {
				 TStudent student = new TStudent();
				 student.setId(userId);
				// 学生
				 studentService.update(student );
			 } else {
				 TTeacher teacher = new TTeacher();
				 teacher.setId(userId);
				 teacherService.update(teacher);
			 }
			 resultMap.put(resultKey, ResultValue.SUCCESS);
			 resultMap.put("msg", newPassword);
			 request.getSession().removeAttribute(MailUtil.EMAIL_KEY);
		 } catch (Exception e) {
			 resultMap.put(resultKey, ResultValue.FAIL);
			 resultMap.put("msg", e.getMessage());
		 }
		 return resultMap;
	 }

	 /**
	  * 用户个人信息页面
	  * @param request
	  * @return
	  */
	 @RequiresPermissions("user:ui")
	 @RequestMapping(value="/user/ui-info", method=RequestMethod.GET)
	 public ModelAndView infoUI(HttpServletRequest request) {
		 TLogin login = (TLogin) request.getSession().getAttribute("user");
		 return new ModelAndView("account/info", "login", login);
	 }
	 
	 /**
	  * 	更新用户
	  * @param login
	  * @return
	  */
	 @RequestMapping(value="/user/info", method=RequestMethod.PUT)
	 @RequiresPermissions("user:update:info")
	 @ResponseBody
	 public Map<String, Object> userUpdate(HttpServletRequest request, @RequestParam(value="sex", required=false) Boolean sex, 
			 @RequestParam(value="phone", required=false) String phone, @RequestParam(value="email", required=false) String email,
			 @RequestParam(value="id", required=true) Integer id) {
		 try {
			 if(id > 9999) {
				 TLogin login = (TLogin) request.getSession().getAttribute("user");
				 TStudent s = login.getStudent();
				 TStudent student = new TStudent();
				 student.setId(id);
				 if (sex != null && s.getSex() != sex) {
					 student.setSex(sex);
				 }
				 if (phone != null && s.getPhone() != phone) {
					 student.setPhone(phone.trim());
				 }
				 if (email != null && s.getEmail() != email) {
					 student.setEmail(email.trim());
				 }
				 studentService.update(student);
				 s = studentService.getById(student.getId());
				 login.setStudent(s);
			 } else {
				 TLogin login = (TLogin) request.getSession().getAttribute("user");
				 TTeacher t = login.getTeacher();
				 TTeacher teacher = new TTeacher();
				 teacher.setId(id);
				 if (sex != null && t.getSex() != sex) {
					 teacher.setSex(sex);
				 }
				 if (phone != null && t.getPhone() != phone) {
					 teacher.setPhone(phone.trim());
				 }
				 if (phone != null && t.getEmail() != email) {
					 teacher.setEmail(email.trim());
				 }
				 teacherService.update(teacher);
				 t = teacherService.getById(teacher.getId());
				 login.setTeacher(t);
			 }
			 resultMap.put(resultKey, ResultValue.SUCCESS);
		 } catch (Exception e) {
			 e.printStackTrace();
			 resultMap.put(resultKey, ResultValue.FAIL);
		}
		 return resultMap;
	 }
	 
	 /**
	  * 用户修改密码页面
	  * @param request
	  * @return
	  */
	 @RequiresPermissions("user:ui")
	 @RequestMapping(value="/user/ui-passwd", method=RequestMethod.GET)
	 public String repasswdUI() {
		 return "account/passwd";
	 }
	 
	 /**
	  * 	修改用户的密码
	  * @param request
	  * @param oldPasswd
	  * @param newPasswd
	  * @return
	  */
	 @RequiresPermissions("user:update:passwd")
	 @RequestMapping(value="/user/passwd",method=RequestMethod.PUT)
	 @ResponseBody
	 public Map<String, Object> userUpdatePassword(HttpServletRequest request, @RequestParam("oldPasswd") String oldPasswd,
			 @RequestParam("newPasswd") String newPasswd) {
		try {
			TLogin login = (TLogin) request.getSession().getAttribute("user");
			if (oldPasswd == null || newPasswd == null || oldPasswd.equals("") || newPasswd.equals("")) {
				 resultMap.put(resultKey, ResultValue.FAIL);
				 return resultMap;
			}
			if (login.getPassword().equals(MD5Util.md5Salt(oldPasswd))) {
				TLogin tLogin = new TLogin();
				tLogin.setId(login.getId());
				String pass = MD5Util.md5Salt(newPasswd);
				tLogin.setPassword(pass);
				loginService.update(tLogin);
				resultMap.put(resultKey, ResultValue.SUCCESS);
			} else {
				resultMap.put(resultKey, ResultValue.FAIL);
			}
		 } catch (Exception e) {
			 e.printStackTrace();
			 resultMap.put(resultKey, ResultValue.FAIL);
		}
		// 重新登录
		Subject subject = SecurityUtils.getSubject();
		SecurityUtils.getSecurityManager().logout(subject );
		return resultMap;
	 }
	 
	 /**
	  * 	修改头像页面
	  * @return
	  */
	 @RequiresAuthentication
	 @RequestMapping(value="user/avatar", method=RequestMethod.GET)
	 public String userAvatarUI() {
		 return "account/avatar";
	 }
	 
	 /**
	  * 	修改头像
	  * @return
	  */
	 @RequiresAuthentication
	 @RequestMapping(value="user/avatar", method=RequestMethod.POST)
	 @ResponseBody
	 public Map<String, Object> userAvatar(@RequestParam("base64") String base64) {
		String dataPrix = "";
		String data = "";
		String path = "";
		TLogin login = SessionManagerUtil.getPreviouSessionUser();
		try {
			if (base64 == null || "".equals(base64)) {
				throw new Exception("上传失败，上传图片数据为空");
			} else {
				String[] d = base64.split("base64,");
				if (d != null && d.length == 2) {
					dataPrix = d[0];
					data = d[1];
				} else {
					throw new Exception("上传失败，数据不合法");
				}
			}
			String suffix = ".jpg";
			if (!"data:image/jpeg;".equalsIgnoreCase(dataPrix)) {// data:image/jpeg;base64,base64编码的jpeg图片数据
				throw new Exception("上传图片格式不是image/jpeg 格式");
			}
			String filename = login.getUserId() + suffix;
			String rootPath = Utils.getAvatarAbsuloteFilesSaveRootPath();
			String rootDirectory = Utils.getFilesRoot();
			if (!Files.exists(Paths.get(rootDirectory))) {
				Files.createDirectories(Paths.get(rootDirectory));
			}
			path = rootPath + filename;
			// 因为BASE64Decoder的jar问题，此处使用spring框架提供的工具包
			byte[] bs = Base64Utils.decodeFromString(data);
			FileUtils.writeByteArrayToFile(new File(rootDirectory + path), bs);
			
			if (SessionManagerUtil.getUserRoleName().equals(Utils.RoleName.STUDENT.toString())) {
				TStudent s =  new TStudent();
				s.setId(login.getUserId());
				s.setHeadshot(path);
				studentService.update(s);
				TStudent student = login.getStudent();
				student.setHeadshot(path);
				login.setStudent(student);
			} else if (SessionManagerUtil.getUserRoleName().equals(Utils.RoleName.TEACHER.toString())) {
				TTeacher t = new TTeacher();
				t.setId(login.getUserId());
				t.setHeadshot(path);
				teacherService.update(t);
				TTeacher teacher = login.getTeacher();
				teacher.setHeadshot(path);
				login.setTeacher(teacher);
			} else {
				throw new Exception("超级管理员默认头像， 无需设置");
			}
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
			if (Files.exists(Paths.get(path))) {
				try {
					Files.delete(Paths.get(path));
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
			resultMap.put(resultKey, ResultValue.FAIL);
			resultMap.put("msg", e.getMessage());
		}		
		return resultMap;
	 }
}
