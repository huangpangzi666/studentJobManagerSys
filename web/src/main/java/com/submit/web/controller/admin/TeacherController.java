package com.submit.web.controller.admin;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.submit.dto.PageResultDTO;
import com.submit.entity.SysRole;
import com.submit.entity.TLogin;
import com.submit.entity.TTeacher;
import com.submit.service.admin.IRoleService;
import com.submit.service.admin.ITeacherService;
import com.submit.util.MD5Util;
import com.submit.web.controller.base.BaseController;

/**
 * 	教师管理
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("admin")
@RequiresRoles("超级管理员")
public class TeacherController extends BaseController {
	private static final String ROLE_NAME = "教师";
	
	@Autowired
	private ITeacherService service;
	@Autowired
	private IRoleService roleService;
	
	/**
	 * 	根据条件获取十条数据
	 * @param pageNo
	 * @param name
	 * @return
	 */
	@RequiresPermissions("teacher:ui")
	@RequestMapping(value= {"ui-teacher"}, method=RequestMethod.GET)
	public ModelAndView teacherUI(@RequestParam(defaultValue="0") int pageNo, @RequestParam(value="name", required=false) String name) {
		pageNo = pageNo < 0 ? 0 : pageNo;
		List<TTeacher> teachers = null;
		int count = 0;
		if (name != null) {
			teachers = service.listByLikeName(name, pageNo, pageSize);
			count = service.countByLikeName(name);
		} else {
			teachers = service.list(pageNo, pageSize);
			count = service.count();
		}
		resultMap.put("name", name);
		resultMap.put("vo", teachers);
		return new PageResultDTO(pageNo, count, resultMap).getModelAndView("admin/teacher");
	}
	
	/**
	 * 	前往添加teacher页面
	 * @return
	 */
	@RequiresPermissions("teacher:ui")
	@RequestMapping(value="ui-teacher-add", method=RequestMethod.GET)
	public ModelAndView teacherAddUI() {
		SysRole role = roleService.getByEquerName(ROLE_NAME);
		return new ModelAndView("admin/teacher_add", "role", role);
	}
	
	/**
	 * 	添加一个teacher
	 * @return
	 */
	@RequiresPermissions("teacher:add")
	@RequestMapping(value="teacher", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> teacherAdd(TTeacher teacher) {
		try {
			String password = teacher.getLogin().getPassword();
			password = MD5Util.md5Salt(password);
			teacher.getLogin().setPassword(password);
			int uid = service.add(teacher);
			resultMap.put(resultKey, ResultValue.SUCCESS);
			resultMap.put("uid", uid);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 	根据id删除一个teacher
	 * @param id
	 * @return
	 */
	@RequiresPermissions("teacher:delete")
	@RequestMapping(value="teacher/{id:\\d+}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> teacherDelete(@PathVariable("id") Integer id) {
		try {
			service.deleteById(id);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
			e.printStackTrace();
		}
		return resultMap;
	}
}
