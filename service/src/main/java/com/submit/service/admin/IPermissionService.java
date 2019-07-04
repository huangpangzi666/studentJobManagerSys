package com.submit.service.admin;

import java.util.List;

import com.submit.entity.SysPermission;

/**
 * 	permission业务层接口
 * @author submitX
 *
 */
public interface IPermissionService {

	/**
	 * 	添加一个permission
	 * @param permission
	 */
	void add(SysPermission permission);

	/**
	 * 	获取一页permission
	 * @param pageNo 当前页
	 * @param pageSize 显示个数
	 * @return
	 */
	List<SysPermission> list(int pageNo, int pageSize);

	/**
	 * 	获取总permission数
	 * @return
	 */
	int count();

	/**
	 * 	根据id获取一个permission
	 * @param id
	 * @return
	 */
	SysPermission getById(Integer id);

	/**
	 * 	更新permission信息,并且清除缓存
	 * @param permission
	 */
	void update(SysPermission permission);

	/**
	 * 	根据id删除一个permission
	 * @param id
	 */
	void deleteById(Integer id);

	/**
	 * 	根据role的id获取permission
	 * @param id
	 * @return
	 */
	List<SysPermission> getPermissionByRoleId(Integer id);

	/**
	 * 	获取所有的permission基本信息, id和description
	 * @return
	 */
	 List<SysPermission> getAllPermissionBase();

	 /**
	  * 	根据url获取id
	  * @param url
	  * @return
	  */
	Integer getIdByUrl(String url);

}
