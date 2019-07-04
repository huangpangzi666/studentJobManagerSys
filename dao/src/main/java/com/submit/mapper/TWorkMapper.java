package com.submit.mapper;

import com.submit.entity.TWork;
import com.submit.entity.TWorkExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TWorkMapper {
    int countByExample(TWorkExample example);

    int deleteByExample(TWorkExample example);

    int deleteByPrimaryKey(String id);

    int insert(TWork record);

    int insertSelective(TWork record);

    List<TWork> selectByExampleWithBLOBs(TWorkExample example);

    List<TWork> selectByExample(TWorkExample example);

    TWork selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") TWork record, @Param("example") TWorkExample example);

    int updateByExampleWithBLOBs(@Param("record") TWork record, @Param("example") TWorkExample example);

    int updateByExample(@Param("record") TWork record, @Param("example") TWorkExample example);

    int updateByPrimaryKeySelective(TWork record);

    int updateByPrimaryKeyWithBLOBs(TWork record);

    int updateByPrimaryKey(TWork record);

    /**
     * 	根据条件获取记录
     * @param i
     * @param pageSize
     * @param status 筛选条件=>0:发布时间; 1进行中并按发布时间排序; 2进行中并按倒计时; 3已完成未验收； 4已结束
     * @param tid 教师id
     * @param sid 学生id
     * @return
     */
	List<TWork> selectPageByConditional(@Param("pageNo")int pageNo, @Param("pageSize")int pageSize, @Param("status")int status,
			@Param("tid")Integer tid, @Param("sid")Integer sid);

	/**
	 *	根据条件获取总记录数 
	 * @param status 筛选条件=>0:发布时间; 1进行中并按发布时间排序; 2进行中并按倒计时; 3已完成未验收； 4已结束
	 * @param tid 教师id
     * @param sid 学生id
	 * @return
	 */
	int countByConditional(@Param("status")int status, @Param("tid")Integer tid, @Param("sid")Integer sid);

	/**
	 * 	判断作业是否已经到时间
	 * @param id
	 * @return
	 */
	int isFinishedWork(String id);

	/**
	 * 	判断当前用户是否有该作业
	 * @param userId
	 * @param workId
	 * @return
	 */
	int isOwnWork(@Param("userId")Integer userId, @Param("workId")String workId);

	/**
	 * 	根据homework来获取work
	 * @param homeworkId
	 * @return
	 */
	TWork selectByHomeworkId(String homeworkId);
}