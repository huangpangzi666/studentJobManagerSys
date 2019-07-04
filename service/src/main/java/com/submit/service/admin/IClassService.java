package com.submit.service.admin;

import java.util.List;

import com.submit.entity.TClass;
import com.submit.vo.ClassVO;

/**
 * 	班级class的业务层
 * @author submitX
 *
 */
public interface IClassService {

	/**
	 * 	获取一页数据
	 * @param pageNo
	 * @param pageSize
	 * @param fid
	 * @param mid
	 * @return
	 */
	List<ClassVO> list(int pageNo, int pageSize, Integer fid, Integer mid);

	/**
	 * 	根据条件获取记录数
	 * @param fid
	 * @param mid
	 * @return
	 */
	int count(Integer fid, Integer mid);

	/**
	 * 	根据年级+班级名称 判断是否可用
	 * @param name
	 * @param year
	 * @return
	 */
	TClass getByNameAndYear(String name, int year);

	/**
	 * 	添加一个cls
	 * @param cls
	 */
	void add(TClass cls);

	/**
	 * 	根据id获取一个class包装对象
	 * @param id
	 * @return
	 */
	ClassVO getClassVOById(String id);

	/**
	 * 	更新class
	 * @param cls
	 */
	void update(TClass cls);

	/**
	 * 	删除一个class
	 * @param id
	 */
	void deleteById(String id);

	/**
	 * 	根据major的id获取所有的class
	 * @param id
	 * @return
	 */
	List<TClass> getBaseInfoListByMajorId(Integer id);

	
	/**
	 * 	获取所有班级的id，name，根据year排序逆序
	 * @return
	 */
	List<TClass> getBaseInfoListOrderYear();

}
