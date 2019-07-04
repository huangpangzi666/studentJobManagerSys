package com.submit.service.admin.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.submit.entity.TClass;
import com.submit.entity.TClassExample;
import com.submit.mapper.TClassMapper;
import com.submit.service.admin.IClassService;
import com.submit.util.Utils;
import com.submit.vo.ClassVO;

/**
 * 	class班级的业务层实现
 * @author submitX
 *
 */
@Service
@Transactional
public class ClassServiceImpl implements IClassService {

	@Autowired
	private TClassMapper mapper;
	
	@Override
	public List<ClassVO> list(int pageNo, int pageSize, Integer fid, Integer mid) {
		return mapper.selectPage(pageNo * pageSize, pageSize, fid, mid);
	}

	@Override
	public int count(Integer fid, Integer mid) {
		return mapper.count(fid, mid);
	}

	@Override
	public TClass getByNameAndYear(String name, int year) {
		TClassExample example = new TClassExample();
		example.createCriteria().andNameEqualTo(name).andYearEqualTo(year);
		List<TClass> list = mapper.selectByExample(example );
		return list.size() == 0 ? null : list.get(0);
	}

	@Override
	public void add(TClass cls) {
		cls.setGmtCreate(new Date());
		cls.setId(Utils.getUUID());
		mapper.insert(cls);
	}

	@Override
	public ClassVO getClassVOById(String id) {
		List<ClassVO> list = mapper.getClassVOById(id);
		return list.size() == 0 ? null : list.get(0);
	}

	@Override
	public void update(TClass cls) {
		cls.setGmtModified(new Date());
		mapper.updateByPrimaryKeySelective(cls);
	}

	@Override
	public void deleteById(String id) {
		mapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<TClass> getBaseInfoListByMajorId(Integer id) {
		return mapper.getBaseInfoListByMajorId(id );
	}

	@Override
	public List<TClass> getBaseInfoListOrderYear() {
		return mapper.getBaseInfoListOrderYear();
	}

}
