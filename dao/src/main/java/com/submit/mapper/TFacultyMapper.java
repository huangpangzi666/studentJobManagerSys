package com.submit.mapper;

import com.submit.entity.TFaculty;
import com.submit.entity.TFacultyExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TFacultyMapper {
    int countByExample(TFacultyExample example);

    int deleteByExample(TFacultyExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TFaculty record);

    int insertSelective(TFaculty record);

    List<TFaculty> selectByExample(TFacultyExample example);

    TFaculty selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TFaculty record, @Param("example") TFacultyExample example);

    int updateByExample(@Param("record") TFaculty record, @Param("example") TFacultyExample example);

    int updateByPrimaryKeySelective(TFaculty record);

    int updateByPrimaryKey(TFaculty record);

    /**
     * 	获取一页数据
     * @param pageNo
     * @param pageSize
     * @return
     */
	List<TFaculty> selectPage(@Param("pageNo") int pageNo, @Param("pageSize") int pageSize);

	/**
	 * 	根据id查询name字段
	 * @param facultyId
	 * @return
	 */
	String selectNameById(Integer facultyId);

	/**
	 * 	获取所有记录的name和id
	 * @return
	 */
	List<TFaculty> getBaseInfoList();
}