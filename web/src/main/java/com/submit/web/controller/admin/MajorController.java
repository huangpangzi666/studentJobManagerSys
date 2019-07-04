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
import com.submit.service.admin.IFacultyService;
import com.submit.service.admin.IMajorService;
import com.submit.vo.MajorVO;
import com.submit.web.controller.base.BaseController;

/**
 * 	院系管理major
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("admin")
@RequiresRoles("超级管理员")
public class MajorController extends BaseController {
	
	@Autowired
	private IFacultyService facultyService;
	@Autowired
	private IMajorService service;
	
	/**
	 * 	前往major页面，默认一页10条数据
	 * @return
	 */
	@RequiresPermissions("major:ui")
	@RequestMapping(value="ui-major", method=RequestMethod.GET)
	public ModelAndView majorUI(@RequestParam(defaultValue="0") int pageNo, @RequestParam(required=false) Integer fid) {
		pageNo = pageNo < 0 ? 0 : pageNo;
		List<MajorVO> voList = service.list(pageNo, pageSize, fid);
		List<TFaculty> fList = facultyService.getBaseInfoList();
		resultMap.put("vo", voList);
		resultMap.put("faculties", fList);
		resultMap.put("fid", fid);
		int count = service.count(fid);
		return new PageResultDTO(pageNo, count, resultMap).getModelAndView("admin/major");
	}
	
	@RequiresAuthentication
	@RequestMapping(value="major/api-isable", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> nameIsAble(@RequestParam("name") String name) {
		try {
			boolean able = false;
			TMajor major = service.getByName(name);
			if (major == null) {
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
	 * 	前往添加major页面
	 * @return
	 */
	@RequiresPermissions("major:ui")
	@RequestMapping(value="ui-major-add", method=RequestMethod.GET)
	public ModelAndView majorAddUI() {
		List<TFaculty> fList = facultyService.getBaseInfoList();
		return new ModelAndView("admin/major_add", "faculties", fList) ;
	}
	
	/**
	 * 	添加一个major
	 * @return
	 */
	@RequiresPermissions("major:add")
	@RequestMapping(value="major", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> majorAdd(TMajor major) {
		try {
			service.add(major);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 	前往major更新页面
	 * @param id
	 * @return
	 */
	@RequiresPermissions("major:ui")
	@RequestMapping(value="ui-major-update/{id:\\d+}", method=RequestMethod.GET)
	public ModelAndView majorUpdateUI(@PathVariable("id") Integer id) {
		MajorVO major = service.getById(id);
		List<TFaculty> fList = facultyService.getBaseInfoList();
		resultMap.put("vo", major);
		resultMap.put("faculties", fList);
		return new ModelAndView("admin/major_update", "datas", resultMap);
	}
	
	/**
	 * 	更新major
	 * @param major
	 * @return
	 */
	@RequiresPermissions("major:update")
	@RequestMapping(value="major", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> majorUpdate(TMajor major) {
		try {
			service.update(major);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 	根据id删除一个major
	 * @param id
	 * @return
	 */
	@RequiresPermissions("major:delete")
	@RequestMapping(value="major/{id:\\d+}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> majorDelete(@PathVariable("id") Integer id) {
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
	 * 	根据faculty的id获取majors
	 */
	@RequiresAuthentication
	@RequestMapping(value="/major/api-faculty/{id:\\d+}", method=RequestMethod.GET)
	@ResponseBody
	public List<TMajor> getByFacultyId(@PathVariable("id") Integer id) {
		return service.getBaseInfoListByFacultyId(id);
	}
}
