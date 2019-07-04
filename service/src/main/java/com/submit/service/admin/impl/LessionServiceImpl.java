package com.submit.service.admin.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.submit.entity.TLession;
import com.submit.entity.TLessionExample;
import com.submit.mapper.TLessionMapper;
import com.submit.service.admin.ILessionService;
import com.submit.util.Utils;

/**
 * 	lession业务层实现
 * @author submitX
 *
 */
@Service
@Transactional
public class LessionServiceImpl implements ILessionService {

	@Autowired
	private TLessionMapper mapper;
	
	@Override
	public List<TLession> list(int pageNo, int pageSize) {
		return mapper.selectPage(pageNo * pageSize, pageSize);
	}

	@Override
	public int count() {
		return mapper.countByExample(null);
	}

	@Override
	public TLession getByName(String name) {
		TLessionExample example = new TLessionExample();
		example.createCriteria().andNameEqualTo(name);
		List<TLession> list = mapper.selectByExample(example );
		return list.size() == 0 ? null : list.get(0);
	}

	@Override
	public void add(TLession lession) {
		lession.setId(Utils.getUUID());
		lession.setGmtCreate(new Date());
		mapper.insert(lession);
	}

	@Override
	public TLession getById(String id) {
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public void update(TLession lession) {
		lession.setGmtModified(new Date());
		mapper.updateByPrimaryKeySelective(lession);
	}

	@Override
	public void deleteById(String id) {
		mapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<TLession> getBaseInfoList() {
		return mapper.getBaseInfoList();
	}

}
