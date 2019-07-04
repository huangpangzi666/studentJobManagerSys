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
import com.submit.dto.RolePermissionDTO;
import com.submit.entity.SysPermission;
import com.submit.entity.SysRole;
import com.submit.service.admin.IPermissionService;
import com.submit.service.admin.IRoleService;
import com.submit.web.controller.base.BaseController;

/**
 * 	角色权限管理：负责角色和 角色与资源的权限授权控制
 * @author submitX
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("admin")
@RequiresRoles("超级管理员")
public class RoleAuthorizationController extends BaseController{

	@Autowired
	private IRoleService service;
	@Autowired
	private IPermissionService permissionService;
	
	/**
	 * 	前往role首页，默认第一页十条role数据
	 * @return
	 */
	@RequiresPermissions("role:ui")
	@RequestMapping(value="ui-role", method= {RequestMethod.GET})
	public ModelAndView roleUI(@RequestParam(defaultValue="0") int pageNo) {
		pageNo = pageNo < 0 ? 0 : pageNo;
		List<SysRole> roles = service.list(pageNo, pageSize);
		int count = service.count();
		return new PageResultDTO(pageNo, count, roles).getModelAndView("admin/role");
	}
	
	/**
	 * 	前往添加role页面
	 * @return
	 */
	@RequiresPermissions("role:ui")
	@RequestMapping(value="ui-role-add", method= {RequestMethod.GET})
	public ModelAndView roleAddUI() {
		ModelAndView mv = new ModelAndView("admin/role_add");
		List<SysPermission> permissions = permissionService.getAllPermissionBase();
		mv.addObject("permissions", permissions );
		return mv;
	}
	
	/**
	 * 	添加role
	 * @return 结果
	 */
	@RequiresPermissions("role:add")
	@RequestMapping(value="role", method= {RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> roleAdd(RolePermissionDTO dto) {
		try {
			SysRole role = service.getByEquerName(dto.getRole().getName());
			if (role == null) {
				service.add(dto);
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
	 * 	前往更新页面，并携带role数据
	 * @param id
	 * @return
	 */
	@RequiresPermissions("role:ui")
	@RequestMapping(value="ui-role-update/{id:\\d+}", method= {RequestMethod.GET})
	public ModelAndView roleUpdateUI(@PathVariable("id")Integer id) {
		SysRole role = service.getById(id);
		List<SysPermission> permissionList = permissionService.getAllPermissionBase();
		ModelAndView modelAndView = new ModelAndView("admin/role_update");
		modelAndView.addObject("role", role);
		modelAndView.addObject("permissions", permissionList);
		return modelAndView; 
	}
	
	/**
	 * 	更新role数据
	 * @param role
	 * @return
	 */
	@RequiresPermissions("role:update")
	@RequestMapping(value="role", method= {RequestMethod.PUT})
	@ResponseBody
	public Map<String, Object> roleUpdate(RolePermissionDTO dto) {
		try {
			SysRole role = service.getByEquerName(dto.getRole().getName());
			if (role == null) {
				service.update(dto);
				resultMap.put(resultKey, ResultValue.SUCCESS);
			} else {
				resultMap.put(resultKey, ResultValue.FAIL);
			}
		} catch (Exception e) {
			resultMap.put(resultKey, ResultValue.FAIL);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 	根据id删除角色
	 * @param id
	 * @return
	 */
	@RequiresPermissions("role:delete")
	@RequestMapping(value="role/{id:\\d+}", method= {RequestMethod.DELETE})
	@ResponseBody
	public Map<String, Object> roleDelete(@PathVariable("id") Integer id) {
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
