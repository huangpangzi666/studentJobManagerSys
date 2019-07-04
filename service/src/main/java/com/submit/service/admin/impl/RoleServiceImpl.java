package com.submit.service.admin.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.submit.dto.RolePermissionDTO;
import com.submit.entity.SysPermission;
import com.submit.entity.SysRole;
import com.submit.entity.SysRolePermission;
import com.submit.entity.SysRolePermissionExample;
import com.submit.mapper.SysPermissionMapper;
import com.submit.mapper.SysRoleMapper;
import com.submit.mapper.SysRolePermissionMapper;
import com.submit.service.admin.IRoleService;

@Service
@Transactional
public class RoleServiceImpl implements IRoleService {

	@Autowired
	private SysRoleMapper mapper;
	@Autowired
	private SysPermissionMapper permissionMapper;
	@Autowired
	private SysRolePermissionMapper rolePermissionMapper;
	
	@Override
	public List<SysRole> list(int pageNo, int pageSize) {
		List<SysRole> list = mapper.selectPage(pageNo * pageSize, pageSize);
		for (SysRole sysRole : list) {
			List<SysPermission> permissions = permissionMapper.selectByRoleId(sysRole.getId());
			sysRole.setPermissions(permissions);
		}
		return list;
	}

	@Override
	public int count() {
		return mapper.countByExample(null);
	}

	@CacheEvict(value="shiroAuthorizationCache", allEntries=true)
	@Override
	public void add(RolePermissionDTO dto) {
		SysRole role = dto.getRole();
		role.setGmtCreate(new Date());
		mapper.insertSelective(role);
		for (int permissionId : dto.getPermissionids()) {
			rolePermissionMapper.insert(new SysRolePermission(role.getId(), permissionId));
		}
	}

	@Override
	public SysRole getById(Integer id) {
		SysRole role = mapper.selectByPrimaryKey(id);
		List<SysPermission> list = permissionMapper.selectIdAndDescriptionByRoleId(id);
		role.setPermissions(list);
		return role;
	}

	/**
	 * 	根据role的id删除所对应的所有权限
	 * @param id
	 */
	@CacheEvict(value="shiroAuthorizationCache", allEntries=true)
	public void deletePermissionByRoleId(Integer id) {
		SysRolePermissionExample example = new SysRolePermissionExample();
		example.createCriteria().andRoleIdEqualTo(id);
		rolePermissionMapper.deleteByExample(example);
	}
	
	@Override
	@CacheEvict(value="shiroAuthorizationCache", allEntries=true)
	public void update(RolePermissionDTO dto) {
		SysRole role = dto.getRole();
		role.setGmtModified(new Date());
		mapper.updateByPrimaryKeySelective(role);
		// 删除role对应的所有权限并添加新的权限
		this.deletePermissionByRoleId(role.getId());
		for (int permissionId : dto.getPermissionids()) {
			rolePermissionMapper.insert(new SysRolePermission(role.getId(), permissionId));
		}
	}

	@CacheEvict(value="shiroAuthorizationCache", allEntries=true)
	@Override
	public void deleteById(Integer id) {
		this.deletePermissionByRoleId(id);
		mapper.deleteByPrimaryKey(id);
	}

	@Override
	public SysRole getByEquerName(String roleName) {
		return mapper.getByEquerName(roleName);
	}
	
}
