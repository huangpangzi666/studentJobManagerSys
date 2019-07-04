package com.submit.service.admin.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.submit.entity.TTeachingLession;
import com.submit.mapper.TTeachingLessionMapper;
import com.submit.service.admin.ITeachingService;
import com.submit.util.Utils;

/**
 * 	授课关系业务实现
 * @author submitX
 *
 */
@Service
@Transactional
public class TeachingServiceImpl implements ITeachingService {

	@Autowired
	private TTeachingLessionMapper mapper;
	
	@Override
	public List<TTeachingLession> listByConditional(Boolean status, Integer teacherId, String classId, Integer pageNo,
			Integer pageSize) {
		return mapper.selectPageByConditional(status, teacherId, classId, pageNo * pageSize,pageSize);
	}

	@Override
	public int countByConditional(Boolean status, Integer teacherId, String classId) {
		// TODO Auto-generated method stub
		return mapper.countByConditional(status, teacherId, classId);
	}

	@Override
	public void add(TTeachingLession teaching) {
		teaching.setId(Utils.getUUID());
		teaching.setGmtCreate(new Date());
		teaching.setStatus(true);
		mapper.insert(teaching);
	}

	@Override
	public TTeachingLession getById(String id) {
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public void update(TTeachingLession teaching) {
		teaching.setGmtModified(new Date());
		mapper.updateByPrimaryKeySelective(teaching);
	}

	@Override
	public void deleteById(String id) {
		mapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<TTeachingLession> getOnlineTeachingByTeacherId(Integer userId) {
		return mapper.selectPageByConditional(true, userId, null, null, null);
	}

}
