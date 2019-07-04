package com.submit.mapper;

import com.submit.entity.SysRole;
import com.submit.entity.SysRoleExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SysRoleMapper {
    int countByExample(SysRoleExample example);

    int deleteByExample(SysRoleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    List<SysRole> selectByExample(SysRoleExample example);

    SysRole selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") SysRole record, @Param("example") SysRoleExample example);

    int updateByExample(@Param("record") SysRole record, @Param("example") SysRoleExample example);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);

    /**
     * 	一列role数据
     * @param pageNo
     * @param pageSize
     * @return
     */
	List<SysRole> selectPage(@Param("pageNo") int pageNo, @Param("pageSize") int pageSize);

	/**
	 * 	根据name获取role
	 * @param roleName
	 * @return
	 */
	SysRole getByEquerName(String roleName);
}