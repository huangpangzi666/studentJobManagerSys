package com.submit.web.controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.core.config.plugins.validation.constraints.Required;
import org.apache.poi.ss.usermodel.Workbook;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.submit.dto.PageResultDTO;
import com.submit.entity.SysRole;
import com.submit.entity.TClass;
import com.submit.entity.TFaculty;
import com.submit.entity.TLession;
import com.submit.entity.TStudent;
import com.submit.entity.TTeacher;
import com.submit.service.admin.IClassService;
import com.submit.service.admin.IFacultyService;
import com.submit.service.admin.ILessionService;
import com.submit.service.admin.IRoleService;
import com.submit.service.admin.IStudentService;
import com.submit.service.admin.ITeacherService;
import com.submit.util.ReadExcel;
import com.submit.web.controller.base.BaseController;

/**
 * 	学生管理
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("admin")
public class StudentController extends BaseController {
	private static final String ROLE_NAME = "学生";
	
	@Autowired
	private IStudentService service;
	@Autowired
	private IFacultyService facultyService;
	@Autowired
	private IRoleService roleService;

	/**
	 * 	前往学生页面
	 * @return
	 */
	@RequiresPermissions("student:ui")
	@RequestMapping(value="ui-student", method=RequestMethod.GET)
	public ModelAndView studentUI() {
		List<TFaculty> faculties = facultyService.getBaseInfoList();
		resultMap.put("faculties", faculties);
		return new ModelAndView("admin/student", "datas", faculties);
	}
	
	/**
	 * 	ajax获取分页数据
	 * @param pageNo
	 * @param facultyId
	 * @param teacherId
	 * @param classId
	 * @param name
	 * @return
	 */
	@RequiresPermissions("student:ui")
	@RequestMapping(value="api-student-list", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> apiList(@RequestParam(defaultValue="0") int pageNo, @RequestParam(value="fId", required=false) Integer facultyId,
			@RequestParam(value="mId", required=false) Integer majorId, @RequestParam(value="cId", required=false) String classId,
			@RequestParam(value="name", required=false) String name) {
		pageNo = pageNo < 0 ? 0 : pageNo;
		name = name == null || name.equals("") ? null: name.trim();
		if (classId == null || classId.equals("")) {
			classId = null;
		}
		List<TStudent> students = null;
		int count = 0;
		// 为了避免直接url拼接分页过滤条件导致xml中sql紊乱
		if (classId != null) {
			students = service.listByConditional(null, null, classId, name, pageNo, pageSize);
			count = service.countByConditional(null, null, classId, name);
		} else if (majorId != null) {
			students = service.listByConditional(null, majorId, null, name, pageNo, pageSize);
			count = service.countByConditional(null, majorId, null, name);
		} else if (facultyId != null) {
			students = service.listByConditional(facultyId, null, null, name, pageNo, pageSize);
			count = service.countByConditional(facultyId, null, null, name);
		} else {
			students = service.listByConditional(null, null, null, name, pageNo, pageSize);
			count = service.countByConditional(null, null, null, name);
		}
		resultMap.put("cId", classId);
		resultMap.put("mId", majorId);
		resultMap.put("fId", facultyId);
		resultMap.put("count", count);
		resultMap.put("pageNo", pageNo);
		resultMap.put("name", name);
		resultMap.put("students", students);
		
		return resultMap;
	}
	/**
	 * 	前往添加学生页面
	 * @return
	 */
	@RequiresPermissions("student:ui")
	@RequestMapping(value="ui-student-add", method=RequestMethod.GET)
	public ModelAndView studentAddUI() {
		List<TFaculty> faculties = facultyService.getBaseInfoList();
		SysRole role = roleService.getByEquerName(ROLE_NAME);
		resultMap.put("faculties", faculties);
		resultMap.put("role", role);
		return new ModelAndView("admin/student_add", "datas", resultMap);
	}
	
	/**
	 * 	添加一个student
	 * @return
	 */
	@RequiresPermissions("student:add")
	@RequestMapping(value="student", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> studentAdd(TStudent student) {
		try {
			
			service.add(student);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 	前往Excel导入学生数据页面
	 * @param id
	 * @return
	 */
	@RequiresPermissions("student:ui")
	@RequestMapping(value="ui-student-import", method=RequestMethod.GET)
	public String studentExcelImportUI() {
		return "admin/student_import";
	}
	
	/**
	 * 	将Excel文件中的数据进行封装存储至数据库
	 * @param file
	 * @return
	 */
	@RequiresPermissions("student:import")
	@RequestMapping(value="student/import", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> studentImport(@RequestParam("file")MultipartFile file) {
		if(file == null) {
			resultMap.put("msg", "文件不存在");
			resultMap.put(resultKey, ResultValue.ERROR);
			return resultMap;
		}
		long size = file.getSize();
        if(size == 0){
        	resultMap.put("msg", "文件没有数据");
			resultMap.put(resultKey, ResultValue.ERROR);
			return resultMap;
        }
        // 获取Excel
        ReadExcel readExcel=new ReadExcel();
		List<TStudent> students = null;;
		try {
			students = readExcel.getExcelInfo(file);
		} catch (IOException e) {
			e.printStackTrace();
			resultMap.put("msg", "文件内容格式错误，请下载学生模板填写");
			resultMap.put(resultKey, ResultValue.ERROR);
			return resultMap;
		}
		for (TStudent tStudent : students) {
			System.out.println(tStudent);
		}
        Map<String, Object> result = service.add(students);
        resultMap.put(resultKey, ResultValue.SUCCESS);
        resultMap.put("msg", result);
		return resultMap;
	}
	
	/**
	 * 	前往更新学生更新页面
	 * @return
	 */
	@RequiresPermissions("student:ui")
	@RequestMapping(value="ui-student-update/{id:\\d+}", method=RequestMethod.GET)
	public ModelAndView studentUpdateUI(@PathVariable("id") Integer id, @RequestParam("name") String name, @RequestParam("classId") String classId) {
		List<TFaculty> faculties = facultyService.getBaseInfoList();
		SysRole role = roleService.getByEquerName(ROLE_NAME);
		resultMap.put("faculties", faculties);
		resultMap.put("role", role);
		resultMap.put("id", id);
		resultMap.put("name", name);
		resultMap.put("classId", classId);
		return new ModelAndView("admin/student_update", "datas", resultMap);
	}
	/**
	 * 	更新student所属班级
	 * @param student
	 * @return
	 */
	@RequiresPermissions("student:update:class")
	@RequestMapping(value="student", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> studentUpdate(TStudent student) {
		try {
			service.update(student);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 	根据id删除一个学生关系
	 * @param id
	 * @return
	 */
	@RequiresPermissions("student:delete")
	@RequestMapping(value="student/{id:\\d+}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> studentDelete(@PathVariable("id") Integer id) {
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

