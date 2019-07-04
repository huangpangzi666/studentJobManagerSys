package com.submit.web.controller.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Role;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.submit.dto.PageResultDTO;
import com.submit.entity.TFaculty;
import com.submit.service.admin.IFacultyService;
import com.submit.web.controller.base.BaseController;

/**
 * 	院系管理faculty
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("admin")
@RequiresRoles("超级管理员")
public class FacultyController extends BaseController {
	
	@Autowired
	private IFacultyService service;
	
	/**
	 * 	前往faculty页面，默认一页10条数据
	 * @return
	 */
	@RequiresPermissions("faculty:ui")
	@RequestMapping(value="ui-faculty", method=RequestMethod.GET)
	public ModelAndView facultyUI(@RequestParam(defaultValue="0") int pageNo) {
		pageNo = pageNo < 0 ? 0 : pageNo;
		List<TFaculty> facultys = service.list(pageNo, pageSize);
		int count = service.count();
		return new PageResultDTO(pageNo, count, facultys).getModelAndView("admin/faculty");
	}
	
	@RequiresAuthentication
	@RequestMapping(value="faculty/api-isable", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> nameIsAble(@RequestParam("name") String name) {
		try {
			boolean able = false;
			TFaculty faculty = service.getByName(name);
			if (faculty == null) {
				able = true;
			}
			if (able) {
				resultMap.put(resultKey, ResultValue.SUCCESS);
			} else {
				resultMap.put(resultKey, ResultValue.FAIL);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.ERROR);
		}
		return resultMap;
	}
	/**
	 * 	前往添加faculty页面
	 * @return
	 */
	@RequiresPermissions("faculty:ui")
	@RequestMapping(value="ui-faculty-add", method=RequestMethod.GET)
	public String facultyAddUI() {
		return "admin/faculty_add";
	}
	
	/**
	 * 	添加一个faculty
	 * @return
	 */
	@RequiresPermissions("faculty:add")
	@RequestMapping(value="faculty", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> facultyAdd(TFaculty faculty) {
		try {
			service.add(faculty);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 	前往faculty更新页面
	 * @param id
	 * @return
	 */
	@RequiresPermissions("faculty:ui")
	@RequestMapping(value="ui-faculty-update/{id:\\d+}", method=RequestMethod.GET)
	public ModelAndView facultyUpdateUI(@PathVariable("id") Integer id) {
		TFaculty faculty = service.getById(id);
		return new ModelAndView("admin/faculty_update", "faculty", faculty);
	}
	
	/**
	 * 	更新faculty
	 * @param faculty
	 * @return
	 */
	@RequiresPermissions("faculty:update")
	@RequestMapping(value="faculty", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> facultyUpdate(TFaculty faculty) {
		try {
			service.update(faculty);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@RequiresAuthentication
	@RequestMapping(value="faculty/{id:\\d+}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> facultyDelete(@PathVariable("id") Integer id) {
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
