package com.submit.service.admin.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.submit.entity.TFaculty;
import com.submit.entity.TFacultyExample;
import com.submit.entity.TMajor;
import com.submit.entity.TMajorExample;
import com.submit.mapper.TFacultyMapper;
import com.submit.mapper.TMajorMapper;
import com.submit.service.admin.IMajorService;
import com.submit.vo.MajorVO;

/**
 * 	major的业务层实现
 * @author submitX
 *
 */
@Service
@Transactional
public class MajorServiceImpl implements IMajorService {

	@Autowired
	private TMajorMapper mapper;
	@Autowired
	private TFacultyMapper facultyMapper;
	
	@Override
	public List<MajorVO> list(int pageNo, int pageSize, Integer fid) {
		List<TMajor> major = mapper.selectPage(pageNo * pageSize, pageSize, fid);
		List<MajorVO> voList = new ArrayList<>();
		for (TMajor tMajor : major) {
			String facultyName = facultyMapper.selectNameById(tMajor.getFacultyId());
			voList.add(new MajorVO(tMajor, facultyName));
		}
		return voList;
	}

	@Override
	public int count(Integer fid) {
		TMajorExample example = null;
		if (fid != null) {
			example = new TMajorExample();
			example.createCriteria().andFacultyIdEqualTo(fid);
		}
		return mapper.countByExample(example );
	}

	@Override
	public TMajor getByName(String name) {
		TMajorExample example = new TMajorExample();
		example.createCriteria().andNameEqualTo(name);
		List<TMajor> list = mapper.selectByExample(example);
		return list.size() == 0 ? null : list.get(0);
	}

	@Override
	public void add(TMajor major) {
		major.setGmtCreate(new Date());
		mapper.insert(major);
	}

	@Override
	public MajorVO getById(Integer id) {
		TMajor major = mapper.selectByPrimaryKey(id);
		String facultyName = facultyMapper.selectNameById(major.getFacultyId());
		return new MajorVO(major, facultyName);
	}

	@Override
	public void update(TMajor major) {
		major.setGmtModified(new Date());
		mapper.updateByPrimaryKeySelective(major);
	}

	@Override
	public void deleteById(Integer id) {
		mapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<TMajor> getBaseInfoListByFacultyId(Integer fid) {
		return mapper.getBaseInfoListByFacultyId(fid );
	}
	
}
