package com.submit.service.admin.impl;

import java.time.Instant;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.submit.entity.SysPermission;
import com.submit.entity.SysPermissionExample;
import com.submit.mapper.SysPermissionMapper;
import com.submit.service.admin.IPermissionService;

/**
 * 	permission业务层的实现类
 * @author submitX
 *
 */
@Service
@Transactional
public class PermissionServiceImpl implements IPermissionService {

	@Autowired
	private SysPermissionMapper mapper;
	
	@Override
	@CacheEvict(value="shiroAuthorizationCache", allEntries=true)
	public void add(SysPermission permission) {
		permission.setGmtCreate(new Date());
		mapper.insertSelective(permission);
	}

	@Override
	public List<SysPermission> list(int pageNo, int pageSize) {
		return mapper.selectPage(pageNo * pageSize, pageSize);
	}

	@Override
	public int count() {
		return mapper.countByExample(null);
	}

	@Override
	public SysPermission getById(Integer id) {
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	@CacheEvict(value="shiroAuthorizationCache", allEntries=true)
	public void update(SysPermission permission) {
		permission.setGmtModified(new Date());
		mapper.updateByPrimaryKeySelective(permission);
	}

	@Override
	@CacheEvict(value="shiroAuthorizationCache", allEntries=true)
	public void deleteById(Integer id) {
		mapper.deleteById(id);
	}

	@Override
	public List<SysPermission> getPermissionByRoleId(Integer id) {
		return mapper.selectByRoleId(id);
	}

	@Override
	public List<SysPermission> getAllPermissionBase() {
		return mapper.selectIdAndDescriptionByRoleId(null);
	}

	@Override
	public Integer getIdByUrl(String url) {
		return mapper.getIdByUrl(url);
	}

}
