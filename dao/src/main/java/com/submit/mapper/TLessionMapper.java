package com.submit.mapper;

import com.submit.entity.TLession;
import com.submit.entity.TLessionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TLessionMapper {
    int countByExample(TLessionExample example);

    int deleteByExample(TLessionExample example);

    int deleteByPrimaryKey(String id);

    int insert(TLession record);

    int insertSelective(TLession record);

    List<TLession> selectByExample(TLessionExample example);

    TLession selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") TLession record, @Param("example") TLessionExample example);

    int updateByExample(@Param("record") TLession record, @Param("example") TLessionExample example);

    int updateByPrimaryKeySelective(TLession record);

    int updateByPrimaryKey(TLession record);
    
    /**
 	 *	一页数据
     * @param pageNo
     * @param pageSize
     * @return
     */
	List<TLession> selectPage(@Param("pageNo") int pageNo, @Param("pageSize") int pageSize);

	/**
	 * 	所有的lession的id和name
	 * @return
	 */
	List<TLession> getBaseInfoList();
}