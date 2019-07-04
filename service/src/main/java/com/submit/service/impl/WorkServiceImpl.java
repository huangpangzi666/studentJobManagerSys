package com.submit.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.submit.entity.THomework;
import com.submit.entity.THomeworkExample;
import com.submit.entity.TStudent;
import com.submit.entity.TWork;
import com.submit.entity.TWorkExample;
import com.submit.mapper.TClassMapper;
import com.submit.mapper.THomeworkMapper;
import com.submit.mapper.TStudentMapper;
import com.submit.mapper.TTeachingLessionMapper;
import com.submit.mapper.TWorkMapper;
import com.submit.service.IWorkService;
import com.submit.service.admin.IClassService;
import com.submit.service.admin.IStudentService;
import com.submit.util.Utils;
import com.submit.util.Utils.HomeworkStatus;

/**
 *  作业业务层
 * @author submitX
 *
 */
@Service
@Transactional
public class WorkServiceImpl implements IWorkService {

	@Autowired
	private TWorkMapper mapper;
	@Autowired
	private IStudentService studentService;
	@Autowired
	private TTeachingLessionMapper teachingMapper;
	@Autowired
	private THomeworkMapper homeWorkMapper;
	
	@Override
	public void add(TWork work) {
		work.setGmtCreate(new Date());
		work.setStatus(Utils.WorkStatus.ONLINE.ordinal());
		mapper.insert(work);
		// 为每一个听课的学生添加此作业
		String classId = teachingMapper.getClassIdById(work.getTeachingLessionId());
		List<String> col = new ArrayList<>();
		col.add("id");
		List<TStudent> studentList = studentService.listByConditional(null, null, classId, null, 0, 0, col);
		THomework homeWork = null;
		for (TStudent student : studentList) {
			homeWork = new THomework();
			homeWork.setStatus(0);
			homeWork.setId(Utils.getUUID());
			homeWork.setStudentId(student.getId());
			homeWork.setWorkId(work.getId());
			homeWorkMapper.insert(homeWork);
		}
	}

	@Override
	public List<TWork> getListByConditional(int pageNo, int pageSize, int status, Integer tid, Integer sid) {
		return mapper.selectPageByConditional(pageNo * pageSize, pageSize, status, tid, sid);
	}

	@Override
	public int countByConditional(int status, Integer tid, Integer sid) {
		return mapper.countByConditional(status, tid, sid);
	}

	@Override
	public List<THomework> getHomeworksByWorkId(String id) {
		THomeworkExample example = new THomeworkExample();
		example.createCriteria().andWorkIdEqualTo(id);
		example.setOrderByClause("status asc");
		return homeWorkMapper.selectByExample(example );
	}

	@Override
	public boolean isFinishedWork(String id) {
		int status = mapper.isFinishedWork(id);
		return status == Utils.WorkStatus.OVER.ordinal() ? Boolean.TRUE : Boolean.FALSE;
	}

	@Override
	public void markHomeWork(THomework homework) {
		homework.setStatus(Utils.HomeworkStatus.ACCEPTANCE.ordinal());
		homeWorkMapper.updateByPrimaryKeySelective(homework);
	}

	@Override
	public TWork getWorkById(String id) {
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public THomework getHomeworkByWork(String id, Integer sId, List<String> conditional) {
		return homeWorkMapper.selectConditionalByWorkId(id, sId, conditional);
	}

	@Override
	public void submitHomework(THomework homework) {
		homework.setGmtModified(new Date());
		homework.setStatus(Utils.HomeworkStatus.SUBMIT.ordinal());
		homeWorkMapper.updateByPrimaryKeySelective(homework);
	}

	@Override
	public void update(TWork work) {
		mapper.updateByPrimaryKeySelective(work);
	}

	@Override
	public void setWorkStatus(String id, int status) {
		TWork work = new TWork();
		work.setId(id);
		work.setStatus(status);
		mapper.updateByPrimaryKeySelective(work );
		if (status == Utils.WorkStatus.OVER.ordinal()) {
			// 设置work结束，则将其下所有学生的homework设置为结束，禁止操作
			homeWorkMapper.updateStatusByWorkId(id, HomeworkStatus.OVER.ordinal());
		}
	}

	@Override
	public boolean isOwnWork(Integer userId, String workId) {
		int rows = mapper.isOwnWork(userId, workId);
		return rows > 0 ? Boolean.TRUE : Boolean.FALSE;
	}

	@Override
	public TWork getWorkByHomeworkId(String homeworkId) {
		return mapper.selectByHomeworkId(homeworkId);
	}

	@Override
	public THomework getHomeworkById(String homeworkId) {
		return homeWorkMapper.selectByPrimaryKey(homeworkId);
	}
}
