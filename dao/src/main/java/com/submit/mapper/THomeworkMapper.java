package com.submit.mapper;

import com.submit.entity.THomework;
import com.submit.entity.THomeworkExample;
import com.submit.util.Utils.HomeworkStatus;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface THomeworkMapper {
    int countByExample(THomeworkExample example);

    int deleteByExample(THomeworkExample example);

    int deleteByPrimaryKey(String id);

    int insert(THomework record);

    int insertSelective(THomework record);

    List<THomework> selectByExample(THomeworkExample example);

    THomework selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") THomework record, @Param("example") THomeworkExample example);

    int updateByExample(@Param("record") THomework record, @Param("example") THomeworkExample example);

    int updateByPrimaryKeySelective(THomework record);

    int updateByPrimaryKey(THomework record);

    /**
     *  根据id返回homework的conditional字段
     * @param id workid
     * @param sId 学生id
     * @return
     */
	THomework selectConditionalByWorkId(@Param("workId")String id, @Param("sId") Integer sId, @Param("conditional")List<String> conditional);

	/**
	 * 	根据work的id设置homework的状态
	 * @param id
	 * @param over
	 */
	void updateStatusByWorkId(@Param("workId")String id, @Param("status")int over);
}