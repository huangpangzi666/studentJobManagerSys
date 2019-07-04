package com.submit.service.admin;

import java.util.List;

import com.submit.entity.TTeachingLession;

/**
 * 	授权业务
 * @author submitX
 *
 */
public interface ITeachingService {

	/**
	 * 	pageNo,和pageSize进行分页查询,无则全部查询
	 * @param status
	 * @param teacherId
	 * @param classId
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<TTeachingLession> listByConditional(Boolean status, Integer teacherId, String classId, Integer pageNo,
			Integer pageSize);

	/**
	 * 	总记录数
	 * @param status
	 * @param teacherId
	 * @param classId
	 * @return
	 */
	int countByConditional(Boolean status, Integer teacherId, String classId);

	/**
	 * 	添加一个授课关系
	 * @param teaching
	 */
	void add(TTeachingLession teaching);

	/**
	 * 	根据id 获取一个授课关系
	 * @param id
	 * @return
	 */
	TTeachingLession getById(String id);

	/**
	 * 	更新授课关系
	 * @param teaching
	 */
	void update(TTeachingLession teaching);

	/**
	 * 	根据id删除一个授课关系
	 * @param id
	 */
	void deleteById(String id);

	/**
	 * 	获取当前教师正在任课的所有课程
	 * @param userId
	 * @return
	 */
	List<TTeachingLession> getOnlineTeachingByTeacherId(Integer userId);

}
