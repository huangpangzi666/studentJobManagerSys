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
import com.submit.entity.TClass;
import com.submit.entity.TFaculty;
import com.submit.entity.TLession;
import com.submit.entity.TTeacher;
import com.submit.entity.TTeachingLession;
import com.submit.service.admin.IClassService;
import com.submit.service.admin.IFacultyService;
import com.submit.service.admin.ILessionService;
import com.submit.service.admin.ITeacherService;
import com.submit.service.admin.ITeachingService;
import com.submit.web.controller.base.BaseController;

/**
 * 	授课管理
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("admin")
@RequiresRoles("超级管理员")
public class TeachingController extends BaseController {
	
	@Autowired
	private ITeachingService service;
	@Autowired
	private IFacultyService facultyService;
	@Autowired
	private ILessionService lessionService;
	@Autowired
	private ITeacherService teacherService;
	@Autowired
	private IClassService classService;
	
	/**
	 * 	前往授课页面，默认一页10条数据
	 * @return
	 */
	@RequiresPermissions("teaching:ui")
	@RequestMapping(value="ui-teaching", method=RequestMethod.GET)
	public ModelAndView teachingUI(@RequestParam(defaultValue="0") int pageNo, @RequestParam(value="status", defaultValue="true") Boolean status,
			@RequestParam(value="teacherId", required=false) Integer teacherId, @RequestParam(value="classId", required=false) String classId) {
		pageNo = pageNo < 0 ? 0 : pageNo;
		if (classId == null || classId.equals("")) {
			classId = null;
		}
		List<TTeachingLession> teachings = service.listByConditional(status, teacherId, classId, pageNo, pageSize);
		int count = service.countByConditional(status, teacherId, classId);
		resultMap.put("count", count);
		resultMap.put("pageNo", pageNo);
		resultMap.put("teacherId", teacherId);
		resultMap.put("status", status);
		resultMap.put("classId", classId);
		resultMap.put("teachings", teachings);
		
		List<TClass> classes = classService.getBaseInfoListOrderYear();
		List<TTeacher> teachers = teacherService.getBaseInfoList();
		resultMap.put("classes", classes);
		resultMap.put("teachers", teachers);
		
		return new PageResultDTO(pageNo, count, resultMap).getModelAndView("admin/teaching");
	}
	
	/**
	 * 	前往添加授课页面
	 * @return
	 */
	@RequiresPermissions("teaching:ui")
	@RequestMapping(value="ui-teaching-add", method=RequestMethod.GET)
	public ModelAndView teachingAddUI() {
		List<TFaculty> faculties = facultyService.getBaseInfoList();
		List<TLession> lessions = lessionService.getBaseInfoList();
		List<TTeacher> teachers = teacherService.getBaseInfoList();
		resultMap.put("faculties", faculties);
		resultMap.put("lessions", lessions);
		resultMap.put("teachers", teachers);
		return new ModelAndView("admin/teaching_add", "datas", resultMap);
	}
	
	/**
	 * 	添加一个teaching
	 * @return
	 */
	@RequiresPermissions("teaching:add")
	@RequestMapping(value="teaching", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> teachingAdd(TTeachingLession teaching) {
		try {
			service.add(teaching);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 	前往teaching更新页面
	 * @param id
	 * @return
	 */
	@RequiresPermissions("teaching:ui")
	@RequestMapping(value="ui-teaching-update/{id:[0-9a-zA-Z]{32}}", method=RequestMethod.GET)
	public ModelAndView teachingUpdateUI(@PathVariable("id") String id) {
		TTeachingLession teaching = service.getById(id);
		List<TTeacher> teachers = teacherService.getBaseInfoList();
		resultMap.put("teachers", teachers);
		resultMap.put("teaching", teaching);
		return new ModelAndView("admin/teaching_update", "datas", resultMap);
	}
	
	/**
	 * 	更新teaching
	 * @param teaching
	 * @return
	 */
	@RequiresPermissions("teaching:update")
	@RequestMapping(value="teaching", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> teachingUpdate(TTeachingLession teaching) {
		try {
			service.update(teaching);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 	设置授课状态
	 * @param teaching
	 * @return
	 */
	@RequiresPermissions("teaching:update")
	@RequestMapping(value="teaching-status", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> teachingStatus(TTeachingLession teaching) {
		teaching.setStatus(Boolean.FALSE);
		Map<String, Object> map = this.teachingUpdate(teaching);
		return map;
	}
	
	/**
	 * 	根据id删除一个授课关系
	 * @param id
	 * @return
	 */
	@RequiresPermissions("teaching:delete")
	@RequestMapping(value="teaching/{id:[0-9a-zA-Z]{32}}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> teachingDelete(@PathVariable("id") String id) {
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

