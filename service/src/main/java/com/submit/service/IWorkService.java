package com.submit.service;

import java.util.List;

import com.submit.entity.THomework;
import com.submit.entity.TWork;

/**
 * 	作业业务层
 * @author submitX
 *
 */
public interface IWorkService {

	/**
	 * 	添加一个作业任务
	 * @param work
	 */
	void add(TWork work);

	/**
	 * 	根据条件获取作业
	 * @param pageNo
	 * @param pageSize
	 * @param status
	 * @param tid 教师id
     * @param sid 学生id
	 * @return
	 */
	List<TWork> getListByConditional(int pageNo, int pageSize, int status, Integer tid, Integer sid);

	/**
	 * 	根据条件获取总记录数
	 * @param status
	 * @param tid 教师id
     * @param sid 学生id
	 * @return
	 */
	int countByConditional(int status, Integer tid, Integer sid);

	/**
	 * 	根据作业的id获取班级所有学生的homework
	 * @param id
	 * @return
	 */
	List<THomework> getHomeworksByWorkId(String id);

	/**
	 * 	判断是否已经到时间
	 * @param id
	 * @return
	 */
	boolean isFinishedWork(String id);

	/**
	 * 	评分作业
	 * @param homework
	 */
	void markHomeWork(THomework homework);

	/**
	 * 	根据id获取一个work
	 * @param id
	 * @return
	 */
	TWork getWorkById(String id);

	/**
	 * 	根据work的id获取homework
	 * @param id 作业workid
	 * @param sId  学生id
	 * @param conditional 返回字段
	 * @return
	 */
	THomework getHomeworkByWork(String id, Integer sId, List<String> conditional);

	/**
	 * 	学生提交作业
	 * @param homework
	 */
	void submitHomework(THomework homework);

	/**
	 * 	更新work
	 * @param work
	 */
	void update(TWork work);

	/**
	 * 	设置工作状态
	 * @param id
	 * @param status
	 */
	void setWorkStatus(String id, int status);

	/**
	 * 	判断一个work是否是当前用户所拥有的
	 * @param userId
	 * @param workId
	 * @return
	 */
	boolean isOwnWork(Integer userId, String workId);

	/**
	 * 	根据homework获取work
	 * @param homeworkId
	 * @return
	 */
	TWork getWorkByHomeworkId(String homeworkId);

	/**
	 * 	根据homeworkid获取homework
	 * @param homeworkId
	 * @return
	 */
	THomework getHomeworkById(String homeworkId);

}
