package com.submit.service.admin;

import java.util.List;

import com.submit.entity.TLession;

/**
 * 	课程lession业务层
 * @author submitX
 *
 */
public interface ILessionService {

	/**
	 * 	一页数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<TLession> list(int pageNo, int pageSize);

	/**
	 * 	总记录数
	 * @return
	 */
	int count();

	/**
	 * 	根据name获取lession
	 * @param name
	 * @return
	 */
	TLession getByName(String name);

	/**
	 * 	添加lession
	 * @param lession
	 */
	void add(TLession lession);

	/**
	 * 	根据id获取lession
	 * @param id
	 * @return
	 */
	TLession getById(String id);

	/**
	 * 	修改lession
	 * @param lession
	 */
	void update(TLession lession);

	/**
	 * 	根据id删除一个lession
	 * @param id
	 */
	void deleteById(String id);

	/**
	 * 	获取所有的lession的id和name
	 * @return
	 */
	List<TLession> getBaseInfoList();

}
