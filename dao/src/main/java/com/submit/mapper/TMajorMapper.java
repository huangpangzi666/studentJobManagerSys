package com.submit.mapper;

import com.submit.entity.TMajor;
import com.submit.entity.TMajorExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TMajorMapper {
    int countByExample(TMajorExample example);

    int deleteByExample(TMajorExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TMajor record);

    int insertSelective(TMajor record);

    List<TMajor> selectByExample(TMajorExample example);

    TMajor selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TMajor record, @Param("example") TMajorExample example);

    int updateByExample(@Param("record") TMajor record, @Param("example") TMajorExample example);

    int updateByPrimaryKeySelective(TMajor record);

    int updateByPrimaryKey(TMajor record);
    
    /**
     * 	获取一页数据
     * @param pageNo
     * @param pageSize
     * @param fid 
     * @return
     */
	List<TMajor> selectPage(@Param("pageNo") int pageNo, @Param("pageSize") int pageSize, @Param("fid") Integer fid);

	/**
	 * 	根据faculty获取数据
	 * @param fid
	 * @return
	 */
	List<TMajor> getBaseInfoListByFacultyId(Integer fid);
}