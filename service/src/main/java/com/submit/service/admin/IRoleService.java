package com.submit.service.admin;

import java.util.List;

import com.submit.dto.RolePermissionDTO;
import com.submit.entity.SysRole;

/**
 * 	角色业务层接口
 * @author submitX
 *
 */
public interface IRoleService {

	/**
	 * 	获取一页role数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<SysRole> list(int pageNo, int pageSize);

	/**
	 * 	获取总的role记录数
	 * @return
	 */
	int count();

	/**
	 * 	添加一个role,并授权
	 * @param dto
	 */
	void add(RolePermissionDTO dto);

	/**
	 * 	根据id获取role
	 * @param id
	 * @return
	 */
	SysRole getById(Integer id);

	/**
	 * 	更新role的权限数据
	 * @param role
	 */
	void update(RolePermissionDTO dto);

	/**
	 * 	根据id删除一个role
	 * @param id
	 */
	void deleteById(Integer id);

	/**
	 * 	根据name精确获取id值
	 * @param roleName
	 * @return
	 */
	SysRole getByEquerName(String roleName);

	

}
