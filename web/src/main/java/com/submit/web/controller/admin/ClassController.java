package com.submit.web.controller.admin;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
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
import com.submit.entity.TFaculty;
import com.submit.entity.TMajor;
import com.submit.entity.TClass;
import com.submit.service.admin.IClassService;
import com.submit.service.admin.IFacultyService;
import com.submit.service.admin.IMajorService;
import com.submit.vo.ClassVO;
import com.submit.web.controller.base.BaseController;

/**
 * 	班级管理class
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("admin")
@RequiresRoles("超级管理员")
public class ClassController extends BaseController {
	
	@Autowired
	private IClassService service;
	@Autowired
	private IFacultyService facultyService;
	@Autowired
	private IMajorService majorService;
	
	
	/**
	 * 	前往class页面，默认一页10条数据
	 * @return
	 */
	@RequiresPermissions("class:ui")
	@RequestMapping(value="ui-class", method=RequestMethod.GET)
	public ModelAndView classUI(@RequestParam(defaultValue="0") int pageNo, @RequestParam(required=false) Integer fid, @RequestParam(required=false) Integer mid) {
		pageNo = pageNo < 0 ? 0 : pageNo;
		List<ClassVO> voList = service.list(pageNo, pageSize, fid, mid);
		List<TFaculty> fList = facultyService.getBaseInfoList();
		List<TMajor> mList = null;
		if (fid != null) {
			mList = majorService.getBaseInfoListByFacultyId(fid);
			resultMap.put("majors", mList);
		}
		resultMap.put("vo", voList);
		resultMap.put("faculties", fList);
		resultMap.put("fid", fid);
		resultMap.put("mid", mid);
		int count = service.count(fid, mid);
		return new PageResultDTO(pageNo, count, resultMap).getModelAndView("admin/class");
	}
	
	@RequiresAuthentication
	@RequestMapping(value="class/api-isable", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> nameAndYearIsAble(@RequestParam("name") String name, @RequestParam("year") int year) {
		try {
			boolean able = false;
			TClass cls = service.getByNameAndYear(name, year);
			if (cls == null) {
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
	 * 	前往添加class页面
	 * @return
	 */
	@RequiresPermissions("class:ui")
	@RequestMapping(value="ui-class-add", method=RequestMethod.GET)
	public ModelAndView classAddUI() {
		List<TFaculty> fList = facultyService.getBaseInfoList();
		return new ModelAndView("admin/class_add", "faculties", fList) ;
	}
	
	/**
	 * 	添加一个class
	 * @return
	 */
	@RequiresPermissions("class:add")
	@RequestMapping(value="class", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> classAdd(TClass cls) {
		try {
			service.add(cls);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 	前往class更新页面
	 * @param id
	 * @return
	 */
	@RequiresPermissions("class:ui")
	@RequestMapping(value="ui-class-update/{id:[0-9a-zA-Z]{32}}", method=RequestMethod.GET)
	public ModelAndView classUpdateUI(@PathVariable("id") String id) {
		ClassVO vo = service.getClassVOById(id);
		List<TFaculty> fList = facultyService.getBaseInfoList();
		resultMap.put("vo", vo);
		resultMap.put("faculties", fList);
		return new ModelAndView("admin/class_update", "datas", resultMap);
	}
	
	/**
	 * 	更新class
	 * @param class
	 * @return
	 */
	@RequiresPermissions("class:update")
	@RequestMapping(value="class", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> classUpdate(TClass cls) {
		try {
			service.update(cls);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 	删除一个class根据id
	 * @param id
	 * @return
	 */
	@RequiresPermissions("class:delete")
	@RequestMapping(value="class/{id:[0-9a-zA-Z]{32}}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> classDelete(@PathVariable("id") String id) {
		try {
			service.deleteById(id);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 	根据major的id获取class
	 */
	@RequiresAuthentication
	@RequestMapping(value="/class/api-major/{id:\\d+}", method=RequestMethod.GET)
	@ResponseBody
	public List<TClass> getByMajorId(@PathVariable("id") Integer id) {
		return service.getBaseInfoListByMajorId(id);
	}
}
