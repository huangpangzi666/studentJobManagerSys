package com.submit.mapper;

import com.submit.entity.TClass;
import com.submit.entity.TClassExample;
import com.submit.vo.ClassVO;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TClassMapper {
    int countByExample(TClassExample example);

    int deleteByExample(TClassExample example);

    int deleteByPrimaryKey(String id);

    int insert(TClass record);

    int insertSelective(TClass record);

    List<TClass> selectByExample(TClassExample example);

    TClass selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") TClass record, @Param("example") TClassExample example);

    int updateByExample(@Param("record") TClass record, @Param("example") TClassExample example);

    int updateByPrimaryKeySelective(TClass record);

    int updateByPrimaryKey(TClass record);

    /**
     * 	获取一页数据
     * @param pageNo
     * @param pageSize
     * @param fid
     * @param mid
     * @return
     */
	List<ClassVO> selectPage(@Param("pageNo") int pageNo, @Param("pageSize") int pageSize, @Param("fid") Integer fid, @Param("mid") Integer mid);

	/**
	 * 	根据条件获取记录数
	 * @param fid
	 * @param mid
	 * @return
	 */
	int count( @Param("fid") Integer fid, @Param("mid") Integer mid);

	/**
	 * 	根据id获取一个包装对象
	 * @param id
	 * @return
	 */
	List<ClassVO> getClassVOById(String id);

	/**
	 * 	根据major id获取class集合
	 * @param id
	 * @return
	 */
	List<TClass> getBaseInfoListByMajorId(Integer id);

	/**
	 * 	获取所有class的id和name，按照year排序
	 * @return
	 */
	List<TClass> getBaseInfoListOrderYear();

	/**
	 * 	根据name和age的组合获取class的id
	 * @param year
	 * @param name
	 * @return
	 */
	String selectIdByNameAndYear(@Param("year")int year, @Param("name")String name);
}