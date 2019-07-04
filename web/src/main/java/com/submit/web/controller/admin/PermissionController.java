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
import com.submit.entity.SysPermission;
import com.submit.service.admin.IPermissionService;
import com.submit.web.controller.base.BaseController;

/**
 * 	权限控制
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("admin")
@RequiresRoles("超级管理员")
public class PermissionController extends BaseController {
	
	@Autowired
	private IPermissionService service;
	
	/**
	 * 	前往permission首页，默认第一页十条permission数据
	 * @return
	 */
	@RequiresPermissions("permission:ui")
	@RequestMapping(value="ui-permission", method= {RequestMethod.GET})
	public ModelAndView permissionUI(@RequestParam(defaultValue="0") int pageNo) {
		pageNo = pageNo < 0 ? 0 : pageNo;
		List<SysPermission> permissions = service.list(pageNo, pageSize);
		int count = service.count();
		return new PageResultDTO(pageNo, count, permissions).getModelAndView("admin/permission");
	}
	
	/**
	 * 	前往添加permission页面
	 * @return
	 */
	@RequiresPermissions("permission:ui")
	@RequestMapping(value="ui-permission-add", method= {RequestMethod.GET})
	public String permissionAddUI() {
		return "admin/permission_add";
	}
	
	/**
	 * 	添加permission
	 * @return 结果
	 */
	@RequiresPermissions("permission:add")
	@RequestMapping(value="permission", method= {RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> permissionAdd(SysPermission permission) {
		try {
			Integer id = service.getIdByUrl(permission.getUrl());
			if (id == null || id == 0) {
				service.add(permission);
				resultMap.put(resultKey, ResultValue.SUCCESS);
			} else {
				resultMap.put(resultKey, ResultValue.FAIL);
			}
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.ERROR);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 	前往更新页面，并携带permission数据
	 * @param id
	 * @return
	 */
	@RequiresPermissions("permission:ui")
	@RequestMapping(value="ui-permission-update/{id:\\d+}", method= {RequestMethod.GET})
	public ModelAndView permissionUpdateUI(@PathVariable("id")Integer id) {
		SysPermission permission = service.getById(id);
		return new ModelAndView("admin/permission_update", "permission", permission);
	}
	
	/**
	 * 	更新permission数据
	 * @param permission
	 * @return
	 */
	@RequiresPermissions("permission:update")
	@RequestMapping(value="permission", method= {RequestMethod.PUT})
	@ResponseBody
	public Map<String, Object> permissionUpdate(SysPermission permission) {
		try {
			Integer id = service.getIdByUrl(permission.getUrl());
			if (id == null || id == 0) {
				service.update(permission);
				resultMap.put(resultKey, ResultValue.SUCCESS);
			} else {
				resultMap.put(resultKey, ResultValue.FAIL);
			}
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.ERROR);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 	根据id删除一个权限
	 * @param id
	 * @return
	 */
	@RequiresPermissions("permission:delete")
	@RequestMapping(value="permission/{id:\\d+}", method= {RequestMethod.DELETE})
	@ResponseBody
	public Map<String, Object> permissionDelete(@PathVariable("id") Integer id) {
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
