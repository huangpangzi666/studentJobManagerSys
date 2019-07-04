package com.submit.mapper;

import com.submit.entity.TTeachingLession;
import com.submit.entity.TTeachingLessionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TTeachingLessionMapper {
    int countByExample(TTeachingLessionExample example);

    int deleteByExample(TTeachingLessionExample example);

    int deleteByPrimaryKey(String id);

    int insert(TTeachingLession record);

    int insertSelective(TTeachingLession record);

    List<TTeachingLession> selectByExample(TTeachingLessionExample example);

    TTeachingLession selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") TTeachingLession record, @Param("example") TTeachingLessionExample example);

    int updateByExample(@Param("record") TTeachingLession record, @Param("example") TTeachingLessionExample example);

    int updateByPrimaryKeySelective(TTeachingLession record);

    int updateByPrimaryKey(TTeachingLession record);

    /**
     * 	查询,当没有pageNo和pageSize时为全部查询
     * @param status
     * @param teacherId
     * @param classId
     * @param pageNo
     * @param pageSize
     * @return
     */
	List<TTeachingLession> selectPageByConditional(@Param("status")Boolean status, @Param("teacherId")Integer teacherId, 
			@Param("classId")String classId, @Param("pageNo") Integer pageNo, @Param("pageSize")Integer pageSize);

	/**
	 * 	分页记录数
	 * @param status
	 * @param teacherId
	 * @param classId
	 * @return
	 */
	int countByConditional(@Param("status")Boolean status, @Param("teacherId")Integer teacherId, @Param("classId")String classId);

	/**
	 * 	id获取class的id
	 * @param teachingLessionId
	 * @return
	 */
	String getClassIdById(String teachingLessionId);

	
}