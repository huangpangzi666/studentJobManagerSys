package com.submit.mapper;

import com.submit.entity.SysPermission;
import com.submit.entity.SysPermissionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SysPermissionMapper {
    int countByExample(SysPermissionExample example);

    int deleteByExample(SysPermissionExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(SysPermission record);

    int insertSelective(SysPermission record);

    List<SysPermission> selectByExample(SysPermissionExample example);

    SysPermission selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") SysPermission record, @Param("example") SysPermissionExample example);

    int updateByExample(@Param("record") SysPermission record, @Param("example") SysPermissionExample example);

    int updateByPrimaryKeySelective(SysPermission record);

    int updateByPrimaryKey(SysPermission record);
    
    
    /**
    * 	获取一页permission数据
    * @param pageNo
    * @param pageSize
    * @return
    */
   	List<SysPermission> selectPage(@Param("pageNo") int pageNo, @Param("pageSize") int pageSize);

   	/**
   	 * 	根据role的id获取permission
   	 * @param id
   	 * @return
   	 */
	List<SysPermission> selectByRoleId(Integer id);


	/**
	 * 	根据url获取id
	 * @param url
	 * @return
	 */
	Integer getIdByUrl(String url);

	/**
	 * 	id删除一个permission
	 * @param id
	 */
	void deleteById(Integer id);

	/**
	 * 	根据role的id获取所有id和description
	 * @param roleId 
	 * @return
	 */
	List<SysPermission> selectIdAndDescriptionByRoleId(@Param("roleId")Integer roleId);
}