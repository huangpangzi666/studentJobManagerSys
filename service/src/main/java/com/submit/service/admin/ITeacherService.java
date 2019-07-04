package com.submit.service.admin;

import java.util.List;
import com.submit.entity.TTeacher;

/**
 * 	教师管理业务层
 * @author submitX
 *
 */
public interface ITeacherService {

	/**
	 * 	一页数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<TTeacher> list(int pageNo, int pageSize);

	/**
	 * 	总记录数
	 * @return
	 */
	int count();

	/**
	 * 	根据name模糊查询
	 * @param name
	 * @param pageSize 
	 * @param pageNo 
	 * @return
	 */
	List<TTeacher> listByLikeName(String name, int pageNo, int pageSize);

	/**
	 * 	添加一个老师
	 * @param teacher
	 * @return 老师的工号
	 */
	int add(TTeacher teacher);

	/**
	 * 	根据id获取一个老师
	 * @param id
	 * @return
	 */
	TTeacher getById(Integer id);

	/**
	 * 	更新老师数据
	 * @param teacher
	 */
	void update(TTeacher teacher);

	/**
	 * 	根据id删除一个老师
	 * @param id
	 */
	void deleteById(Integer id);

	/**
	 * 	根据name
	 * @param name
	 * @return
	 */
	int countByLikeName(String name);

	/**
	 * 	获取所有的教师的id和name
	 * @return
	 */
	List<TTeacher> getBaseInfoList();

	/**
	 * 	校验是否被注册
	 * @param email 
	 * @return true为存在,否为不存在
	 */
	boolean validEmailExist(String email);

}
