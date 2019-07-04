package com.submit.service.admin.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.submit.entity.TFaculty;
import com.submit.entity.TFacultyExample;
import com.submit.mapper.TFacultyMapper;
import com.submit.service.admin.IFacultyService;

@Service
@Transactional
public class FacultyServiceImpl implements IFacultyService {

	@Autowired
	private TFacultyMapper mapper;
	
	@Override
	public int count() {
		return mapper.countByExample(null);
	}

	@Override
	public List<TFaculty> list(int pageNo, int pageSize) {
		return  mapper.selectPage(pageNo * pageSize, pageSize);
	}

	@Override
	public void add(TFaculty faculty) {
		faculty.setGmtCreate(new Date());
		mapper.insert(faculty);
	}

	@Override
	public TFaculty getById(Integer id) {
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public void update(TFaculty faculty) {
		faculty.setGmtModified(new Date());
		mapper.updateByPrimaryKeySelective(faculty);
	}

	@Override
	public void deleteById(Integer id) {
		mapper.deleteByPrimaryKey(id);
	}

	@Override
	public TFaculty getByName(String name) {
		TFacultyExample example = new TFacultyExample();
		example.createCriteria().andNameEqualTo(name);
		List<TFaculty> list = mapper.selectByExample(example );
		return list.size() == 0 ? null : list.get(0);
	}

	@Override
	public List<TFaculty> getBaseInfoList() {
		return mapper.getBaseInfoList();
	}

}
