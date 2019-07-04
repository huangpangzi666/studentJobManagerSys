package com.submit.service.admin.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.submit.entity.SysRole;
import com.submit.entity.TLogin;
import com.submit.entity.TLoginExample;
import com.submit.entity.TStudent;
import com.submit.mapper.SysRoleMapper;
import com.submit.mapper.TClassMapper;
import com.submit.mapper.TLoginMapper;
import com.submit.mapper.TStudentMapper;
import com.submit.service.admin.IRoleService;
import com.submit.service.admin.IStudentService;
import com.submit.util.MD5Util;

/**
 *  学生业务实现
 * @author submitX
 *
 */
@Service
@Transactional
public class StudentServiceImpl implements IStudentService {
	private final String DEFAULT_PASSWORD = "123456";
	private static final String ROLE_NAME = "学生";

	@Autowired
	private TStudentMapper mapper;
	@Autowired
	private TLoginMapper loginMapper;
	@Autowired
	private IRoleService roleService;
	@Autowired
	private TClassMapper classMapper;
	
	@Override
	public List<TStudent> listByConditional(Integer facultyId, Integer majorId, String classId, String name,int pageNo,
			int pageSize) {
		return mapper.selectPageByConditional(facultyId, majorId, classId, name, pageNo * pageSize, pageSize, null);
	}

	@Override
	public List<TStudent> listByConditional(Integer facultyId, Integer majorId, String classId, String name, int pageNo,
			int pageSize, List<String> col) {
		 return mapper.selectPageByConditional(facultyId, majorId, classId, name, pageNo * pageSize, pageSize, col);
	}
	
	@Override
	public int countByConditional(Integer facultyId, Integer teacherId, String classId, String name) {
		return mapper.countByConditional(facultyId, teacherId, classId, name);
	}

	@Override
	public void add(TStudent student) {
		// 设置默认属性 男，密123456
		student.setSex(true);
		student.setGmtCreate(new Date());
		mapper.insert(student);
		
		Integer userId = student.getId();
		TLogin login = student.getLogin();
		login.setPassword(MD5Util.md5Salt(DEFAULT_PASSWORD));
		login.setStatus(true);
		login.setUserId(userId );
		loginMapper.insert(login);
	}

	@Override
	public TStudent getById(Integer id) {
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public void update(TStudent student) {
		student.setGmtModified(new Date());
		mapper.updateByPrimaryKeySelective(student);
	}

	@Override
	public void deleteById(Integer id) {
		mapper.deleteByPrimaryKey(id);
		TLoginExample example = new TLoginExample();
		example.createCriteria().andUserIdEqualTo(id);
		loginMapper.deleteByExample(example );
	}

	@Override
	public Map<String, Object> add(List<TStudent> students) {
		int successSize = 0;
		int failSize = 0;
		int count = students.size();
		Map<String, Object> map = new HashMap<>();
		
		int year = 0;
		String name = "";
		String classId = "";
		String className = "";
		String failDatas = "";
		TStudent s = null;
		int roleId = roleService.getByEquerName(ROLE_NAME).getId();
		for (int i=0; i<students.size(); ++i) {
			s = students.get(i);
			className = s.getClassName();
			try {
				year = Integer.parseInt(className.substring(0, 4));
				name = className.substring(4);
				classId = classMapper.selectIdByNameAndYear(year, name);
				if (classId == null || "".equals(classId)) {
					throw new NullPointerException("没有这个班级");
				}
				s.setGmtCreate(new Date());
				s.setClassId(classId);
				mapper.insert(s);
				
				Integer userId = s.getId();
				TLogin login = new TLogin();
				login.setPassword(MD5Util.md5(DEFAULT_PASSWORD));
				login.setStatus(true);
				login.setUserId(userId );
				login.setRoleId(roleId);
				loginMapper.insert(login);
				
				successSize++;
			} catch (Exception e) {
				//e.printStackTrace();
				failDatas = failDatas + (i + 1) + ",";
				failSize++;
			}
		}
		
		map.put("successSize", successSize);
		map.put("failSize", failSize);
		map.put("count", count);
		if (!"".equals(failDatas)) {
			failDatas = failDatas.substring(0, failDatas.length() - 1);
			map.put("failDatas", failDatas);
		}
		return map;
	}

	@Override
	public boolean validEmailExist(String email) {
		return mapper.validEmailExist(email) == 1 ? Boolean.TRUE : Boolean.FALSE;
	}


}
