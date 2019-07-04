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
import com.submit.entity.TLession;
import com.submit.service.admin.ILessionService;
import com.submit.web.controller.base.BaseController;

/**
 * 	课程管理lession
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("admin")
@RequiresRoles("超级管理员")
public class LessionController extends BaseController {
	
	@Autowired
	private ILessionService service;
	
	/**
	 * 	前往lession页面，默认一页10条数据
	 * @return
	 */
	@RequiresPermissions("lession:ui")
	@RequestMapping(value="ui-lession", method=RequestMethod.GET)
	public ModelAndView lessionUI(@RequestParam(defaultValue="0") int pageNo) {
		pageNo = pageNo < 0 ? 0 : pageNo;
		List<TLession> lessions = service.list(pageNo, pageSize);
		int count = service.count();
		return new PageResultDTO(pageNo, count, lessions).getModelAndView("admin/lession");
	}
	
	@RequiresAuthentication
	@RequestMapping(value="lession/api-isable", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> nameIsAble(@RequestParam("name") String name) {
		try {
			boolean able = false;
			TLession lession = service.getByName(name);
			if (lession == null) {
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
	 * 	前往添加lession页面
	 * @return
	 */
	@RequiresPermissions("lession:ui")
	@RequestMapping(value="ui-lession-add", method=RequestMethod.GET)
	public String lessionAddUI() {
		return "admin/lession_add";
	}
	
	/**
	 * 	添加一个lession
	 * @return
	 */
	@RequiresPermissions("lession:add")
	@RequestMapping(value="lession", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> lessionAdd(TLession lession) {
		try {
			service.add(lession);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 	前往lession更新页面
	 * @param id
	 * @return
	 */
	@RequiresPermissions("lession:ui")
	@RequestMapping(value="ui-lession-update/{id:[0-9a-zA-Z]{32}}", method=RequestMethod.GET)
	public ModelAndView lessionUpdateUI(@PathVariable("id") String id) {
		TLession lession = service.getById(id);
		return new ModelAndView("admin/lession_update", "lession", lession);
	}
	
	/**
	 * 	更新lession
	 * @param lession
	 * @return
	 */
	@RequiresPermissions("lession:update")
	@RequestMapping(value="lession", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> lessionUpdate(TLession lession) {
		try {
			service.update(lession);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@RequiresPermissions("lession:delete")
	@RequestMapping(value="lession/{id:[0-9a-zA-Z]{32}}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> lessionDelete(@PathVariable("id") String id) {
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
