package com.submit.service.admin;

import java.util.List;

import com.submit.entity.TFaculty;

/**
 *  faculty业务层接口
 * @author submitX
 *
 */
public interface IFacultyService {

	/**
	 * 	获取所有faculty的总记录数
	 * @return
	 */
	int count();

	/**
	 * 	获取一页数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<TFaculty> list(int pageNo, int pageSize);

	/**
	 * 	添加一个院系
	 * @param faculty
	 */
	void add(TFaculty faculty);

	/**
	 * 	根据id获取一个院系
	 * @param id
	 * @return
	 */
	TFaculty getById(Integer id);

	/**
	 * 	更新faculty
	 * @param faculty
	 */
	void update(TFaculty faculty);

	/**
	 * 	根据id删除一个faculty
	 * @param id
	 */
	void deleteById(Integer id);

	/**
	 * 	根据name获取一个faculty
	 * @param name
	 * @return
	 */
	TFaculty getByName(String name);

	/**
	 * 	获取所有院系的基本数据 name 和 id
	 * @return
	 */
	List<TFaculty> getBaseInfoList();

}
