package com.submit.mapper;

import com.submit.entity.TStudent;
import com.submit.entity.TStudentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TStudentMapper {
    int countByExample(TStudentExample example);

    int deleteByExample(TStudentExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TStudent record);

    int insertSelective(TStudent record);

    List<TStudent> selectByExample(TStudentExample example);

    TStudent selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TStudent record, @Param("example") TStudentExample example);

    int updateByExample(@Param("record") TStudent record, @Param("example") TStudentExample example);

    int updateByPrimaryKeySelective(TStudent record);

    int updateByPrimaryKey(TStudent record);

    /**
     * 	条件分页查询
     * @param facultyId
     * @param majorId
     * @param classId
     * @param name 
     * @param pageNo
     * @param pageSize
     * @param c 
     * @return
     */
	List<TStudent> selectPageByConditional(@Param("fId")Integer facultyId, @Param("mId")Integer majorId, 
			@Param("cId")String classId, @Param("name")String name, @Param("pageNo")int pageNo, 
			@Param("pageSize")int pageSize, @Param("column") List<String> col);

	/**
	 * 	添加总记录数
	 * @param facultyId
	 * @param majorId
	 * @param classId
	 * @param name 
	 * @return
	 */
	int countByConditional(@Param("fId")Integer facultyId, @Param("mId")Integer majorId, @Param("cId")String classId, @Param("name")String name);

	/**
	 * 	校验邮箱是否被注册
	 * @param email
	 * @return 1为被注册,0为未注册
	 */
	int validEmailExist(String email);
	
	
}