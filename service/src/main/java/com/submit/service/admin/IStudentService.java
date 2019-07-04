package com.submit.service.admin;

import java.util.List;
import java.util.Map;

import com.submit.entity.TStudent;

/**
 * 	学生业务层
 * @author submitX
 *
 */
public interface IStudentService {

	/**
	 * 	根据条件分页查询
	 * @param facultyId
	 * @param majorId
	 * @param classId
	 * @param name 
	 * @param pageNo
	 * @param pageSize 当为0时表示查询所有
	 * @return
	 */
	List<TStudent> listByConditional(Integer facultyId, Integer majorId, String classId, String name, int pageNo, int pageSize);

	/**
	 * 	根据条件分页查询
	 * @param facultyId
	 * @param majorId
	 * @param classId
	 * @param name 
	 * @param pageNo
	 * @param pageSize 当为0时表示查询所有
	 * @param col要返回的字段
	 * @return
	 */
	List<TStudent> listByConditional(Integer facultyId, Integer majorId, String classId, String name, int pageNo, int pageSize,
			List<String> col);
	
	/**
	 * 	根据添加查询总记录数
	 * @param facultyId
	 * @param majorId
	 * @param classId
	 * @param classId2 
	 * @return
	 */
	int countByConditional(Integer facultyId, Integer majorId, String classId, String classId2);

	/**
	 * 	添加一个学生
	 * @param student
	 */
	void add(TStudent student);

	/**
	 * 	id获取一个学生
	 * @param id
	 * @return
	 */
	TStudent getById(Integer id);

	/**
	 * 	更新学生数据
	 * @param student
	 */
	void update(TStudent student);

	/**
	 * id删除一个学生
	 * @param id
	 */
	void deleteById(Integer id);

	/**
	 * 	添加学生集合，
	 * @param students
	 * @return 成功数和失败数
	 */
	Map<String, Object> add(List<TStudent> students);

	/**
	 * 	校验是否被注册
	 * @param email 
	 * @return true为存在,否为不存在
	 */
	boolean validEmailExist(String email);


}
