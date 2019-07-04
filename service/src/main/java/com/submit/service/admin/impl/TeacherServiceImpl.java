package com.submit.service.admin.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.submit.entity.TLogin;
import com.submit.entity.TLoginExample;
import com.submit.entity.TTeacher;
import com.submit.entity.TTeacherExample;
import com.submit.mapper.TLoginMapper;
import com.submit.mapper.TTeacherMapper;
import com.submit.service.admin.ITeacherService;

/**
 * 	教师管理业务实现
 * @author submitX
 *
 */
@Service
@Transactional
public class TeacherServiceImpl implements ITeacherService {

	@Autowired
	private TTeacherMapper mapper;
	@Autowired
	private TLoginMapper loginMapper;
	
	@Override
	public List<TTeacher> list(int pageNo, int pageSize) {
		return mapper.selectPageByLikeName(null, pageNo * pageSize, pageSize);
	}

	@Override
	public int count() {
		return mapper.countByExample(null);
	}

	@Override
	public List<TTeacher> listByLikeName(String name, int pageNo, int pageSize) {
		return mapper.selectPageByLikeName(name, pageNo * pageSize, pageSize);
	}

	@Override
	public int add(TTeacher teacher) {
		teacher.setGmtCreate(new Date());
		mapper.insert(teacher);
		
		Integer uid = teacher.getId();
		TLogin login = teacher.getLogin();
		login.setStatus(true);
		login.setUserId(uid);
		loginMapper.insert(login);
		
		return uid;
	}

	@Override
	public TTeacher getById(Integer id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public void update(TTeacher teacher) {
		teacher.setGmtModified(new Date());
		mapper.updateByPrimaryKeySelective(teacher);
	}

	@Override
	public void deleteById(Integer id) {
		mapper.deleteByPrimaryKey(id);
		TLoginExample example = new TLoginExample();
		example.createCriteria().andUserIdEqualTo(id);
		loginMapper.deleteByExample(example );
	}

	@Override
	public int countByLikeName(String name) {
		TTeacherExample example = new TTeacherExample();
		example.createCriteria().andNameLike(name);
		return mapper.countByExample(example);
	}

	@Override
	public List<TTeacher> getBaseInfoList() {
		return mapper.getBaseInfoList();
	}

	@Override
	public boolean validEmailExist(String email) {
		return mapper.validEmailExist(email) == 1 ? Boolean.TRUE : Boolean.FALSE;
	}

}
