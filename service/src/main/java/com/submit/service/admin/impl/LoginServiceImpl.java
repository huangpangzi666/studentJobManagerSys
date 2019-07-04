package com.submit.service.admin.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.submit.entity.TLogin;
import com.submit.entity.TLoginExample;
import com.submit.mapper.TLoginMapper;
import com.submit.service.admin.ILoginService;

/**
 * 登陆业务实现
 * @author submitX
 *
 */
@Service
@Transactional
public class LoginServiceImpl implements ILoginService {

	@Autowired
	private TLoginMapper mapper;
	
	@Override
	public void update(TLogin login) {
		mapper.updateByPrimaryKeySelective(login);
	}

	@Override
	public TLogin getByUserId(Integer id) {
		TLoginExample example = new TLoginExample();
		example.createCriteria().andUserIdEqualTo(id);
		List<TLogin> list = mapper.selectByExample(example );
		return list.size() == 0 ? null : list.get(0);
	}

	@Override
	public void recoderAccessTime(TLogin tLogin) {
		this.update(tLogin);
	}

}
