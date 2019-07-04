package com.submit.service.admin;

import java.util.List;

import com.submit.entity.TMajor;
import com.submit.vo.MajorVO;

/**
 * 	major专业的业务层
 * @author submitX
 *
 */
public interface IMajorService {

	/**
	 * 	获取一页majorVO对象
	 * @param pageNo
	 * @param pageSize
	 * @param fid 
	 * @return
	 */
	List<MajorVO> list(int pageNo, int pageSize, Integer fid);

	/**
	 * 	所有major总数
	 * @param fid 院系，约束条件
	 * @return
	 */
	int count(Integer fid);

	/**
	 * 	根据name获取major
	 * @param name
	 * @return
	 */
	TMajor getByName(String name);

	/**
	 * 	添加一个major
	 * @param major
	 */
	void add(TMajor major);

	/**
	 * 	根据id获取一个major包装对象
	 * @param id
	 * @return
	 */
	MajorVO getById(Integer id);

	/**
	 * 	更新一个major
	 * @param major
	 */
	void update(TMajor major);

	/**
	 * 	根据id删除一个major
	 * @param id
	 */
	void deleteById(Integer id);

	/**
	 * 	根据faculty下的所有major
	 * @param fid
	 * @return
	 */
	List<TMajor> getBaseInfoListByFacultyId(Integer fid);


}
