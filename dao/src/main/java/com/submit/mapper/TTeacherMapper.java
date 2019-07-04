package com.submit.mapper;

import com.submit.entity.TTeacher;
import com.submit.entity.TTeacherExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TTeacherMapper {
    int countByExample(TTeacherExample example);

    int deleteByExample(TTeacherExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TTeacher record);

    int insertSelective(TTeacher record);

    List<TTeacher> selectByExample(TTeacherExample example);

    TTeacher selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TTeacher record, @Param("example") TTeacherExample example);

    int updateByExample(@Param("record") TTeacher record, @Param("example") TTeacherExample example);

    int updateByPrimaryKeySelective(TTeacher record);

    int updateByPrimaryKey(TTeacher record);

	
	/**
	 * 	模糊name查询一页数据，name为null则不根据条件
	 * @param name
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<TTeacher> selectPageByLikeName(@Param("name") String name, @Param("pageNo") int pageNo, @Param("pageSize") int pageSize);

	/**
	 * 	所有教师的id和name
	 * @return
	 */
	List<TTeacher> getBaseInfoList();

	/**
	 * 	校验邮箱是否存在
	 * @param email
	 * @return 1为存在
	 */
	int validEmailExist(String email);
}