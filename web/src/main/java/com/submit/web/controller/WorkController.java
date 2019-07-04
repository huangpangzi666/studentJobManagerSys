package com.submit.web.controller;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.submit.dto.PageResultDTO;
import com.submit.entity.THomework;
import com.submit.entity.TLogin;
import com.submit.entity.TStudent;
import com.submit.entity.TTeacher;
import com.submit.entity.TTeachingLession;
import com.submit.entity.TWork;
import com.submit.service.IWorkService;
import com.submit.service.admin.IStudentService;
import com.submit.service.admin.ITeachingService;
import com.submit.util.LoggerUtil;
import com.submit.util.MailUtil;
import com.submit.util.SessionManagerUtil;
import com.submit.util.Utils;
import com.submit.web.controller.base.BaseController;
import com.submit.web.controller.base.CommController;
import com.submit.web.task.WorkTimerTask;
import com.submit.web.task.runnable.WorkRunnable;

/**
 * 	作业管理模块控制
 * @author submitX
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("work")
public class WorkController extends BaseController {
	
	@Autowired
	private ITeachingService teachingService;
	@Autowired
	private IWorkService service;
	@Autowired
	private IStudentService studentService;
	
	/**
	 * 	前往教师发布作业
	 * 	携带数据: 当前教师正在授课的班级
	 * @return
	 */
	@RequestMapping(value="ui-publish", method=RequestMethod.GET)
	@RequiresPermissions("work:publish")
	public ModelAndView workPublishUI(HttpServletRequest request) {
		TLogin login = (TLogin) request.getSession().getAttribute("user");
		List<TTeachingLession> tLessions = teachingService.getOnlineTeachingByTeacherId(login.getUserId());
		return new ModelAndView("work/publish", "tLessions", tLessions);
	}
	
	 @InitBinder
	 public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}

	/**
	 * 	发布作业
	 * @param file
	 * @param work
	 * @return
	 */
	@RequestMapping(value="publish", method=RequestMethod.POST)
	@RequiresPermissions("work:publish")
	@ResponseBody
	public Map<String, Object> workPublish(HttpServletRequest request, MultipartFile file, TWork work) {
		try {
			work.setId(Utils.getUUID());
			if (null != file && file.getSize() > 0) {
				String filePath = upload(request, file, work.getId());
				if (filePath == null || filePath.equals("")) {
					throw new Exception("文件上传失败");
				}
				work.setAnnex(filePath);
			}
			work.setTeacherId(SessionManagerUtil.getPreviouSessionUser().getUserId());
			service.add(work);
			new WorkTimerTask().schedule(new WorkRunnable(work.getId()), work.getAcceptanceTime());
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
			LoggerUtil.error(WorkController.class, e.getMessage());
		}
		return resultMap;
	}
	
	/**
	 *  作业详情和修改页面
	 * @param id
	 * @param className
	 * @return
	 */
	@RequestMapping(value="republish/{id:[0-9a-zA-Z]{32}}", method=RequestMethod.GET)
	@RequiresPermissions("work:publish")
	public ModelAndView workRepublishUI(@PathVariable("id") String id, @RequestParam(value="cname", required=false)String className) {
		TWork work = service.getWorkById(id);
		resultMap.put("work", work);
		resultMap.put("clname", className);
		return new ModelAndView("work/republish", "datas", resultMap);
	}
	
	/**
	 * 	重新修改发布的作业
	 * @param request
	 * @param file
	 * @param work
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="republish", method=RequestMethod.POST)
	@RequiresPermissions("work:publish")
	public Map<String, Object> workRepublish(HttpServletRequest request, MultipartFile file, TWork work) {
		try {
			if (null != file && file.getSize() > 0) {
				String filePath = upload(request, file, work.getId());
				if (filePath == null || filePath.equals("")) {
					throw new Exception("文件上传失败");
				}
				work.setAnnex(filePath);
			}
			work.setGmtModified(new Date());
			service.update(work);
			if (work.getAcceptanceTime() != null) {
				new WorkTimerTask().resetDelay(new WorkRunnable(work.getId()), work.getAcceptanceTime());
			}
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	
	/**
	 * 	教师发布的作业列表
	 * @param pageNo 页码
	 * @param status 筛选条件=>0:发布时间; 1进行中并按发布时间排序; 2进行中并按倒计时; 3已完成
	 * @return
	 */
	@RequiresPermissions("work:recoders")
	@RequestMapping(value="ui-recoders", method=RequestMethod.GET)
	public ModelAndView workRecodersUI(@RequestParam(value="pageNo", defaultValue="0") int pageNo, @RequestParam(value="status", defaultValue="0") int status) {
		if (pageNo < 0) {
			pageNo = 0;
		}
		TLogin login = SessionManagerUtil.getPreviouSessionUser();
		Integer tid = login.getUserId();
		List<TWork> works = service.getListByConditional(pageNo, pageSize, status, tid, null);
		int count = service.countByConditional(status, tid, null);
		resultMap.put("works", works);
		resultMap.put("status", status);
		resultMap.put("pageNo", pageNo);
		return new PageResultDTO(pageNo, count, resultMap).getModelAndView("work/recoders");
	}
	
	/**
	 * 	班级作业列表明细
	 * @param id
	 * @return
	 */
	@RequiresPermissions("work:recoders")
	@RequestMapping(value="ui-clist/{id}", method=RequestMethod.GET)
	public ModelAndView workRecoderUI(@PathVariable("id") String id) {
		List<THomework> homeworks = service.getHomeworksByWorkId(id);
		TWork work = service.getWorkById(id);
		resultMap.put("homeworks", homeworks);
		boolean finished = false;
		if (service.isFinishedWork(id)) {
			// 教师的作业已经到时间,开始统计
			// TODO 
			
			finished = true;
		}
		resultMap.put("finished", finished);
		resultMap.put("status", work.getStatus());
		resultMap.put("workId", work.getId());
		return new ModelAndView("work/clist", "datas", resultMap);
	}
	/**
	 * 	作业验收评分
	 * @param id
	 * @return
	 */
	@RequiresPermissions("work:mark")
	@RequestMapping(value="mark", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> workMark(THomework homework) {
		try {
			service.markHomeWork(homework);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 	验收并结束作业
	 * @param id work的id
	 * @return
	 */
	@RequiresPermissions("work:publish")
	@RequestMapping(value="acceptance/{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> workAcceptance(@PathVariable("id") String workId) {
		TLogin login = SessionManagerUtil.getPreviouSessionUser();
		boolean b = service.isOwnWork(login.getUserId(), workId);
		if (b) {
			service.setWorkStatus(workId, Utils.WorkStatus.OVER.ordinal());
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} else {
			resultMap.put(resultKey, ResultValue.FAIL);
			resultMap.put("msg", "试图操作他人的作业");
		}
		return resultMap;
	}
	
	
	
	/**
	 * ====================================学生作业
	 */
	
	/**
	 * 	学生未完成作业列表
	 * @param pageNo
	 * @param status 条件:
	 * @return
	 */
	@RequestMapping(value="ui-unends", method=RequestMethod.GET)
	@RequiresPermissions("work:student")
	public ModelAndView homeworkUnendsUI(@RequestParam(value="pageNo", defaultValue="0") int pageNo, @RequestParam(value="status", defaultValue="1") int status) {
		if (pageNo < 0) {
			pageNo = 0;
		}
		TLogin login = SessionManagerUtil.getPreviouSessionUser();
		Integer sid = login.getUserId();
		List<TWork> works = service.getListByConditional(pageNo, pageSize, status, null, sid);
		int count = service.countByConditional(status, null, sid);
		resultMap.put("works", works);
		resultMap.put("status", status);
		resultMap.put("pageNo", pageNo);
		return new PageResultDTO(pageNo, count, resultMap).getModelAndView("work/unends");
	}
	
	/**
	 * 	已结束的 作业
	 * @param pageNo
	 * @return
	 */
	@RequiresPermissions("work:student")
	@RequestMapping(value="ui-overs", method=RequestMethod.GET)
	public ModelAndView homeworkFinishedUI(@RequestParam(value="pageNo", defaultValue="0") int pageNo) {
		ModelAndView mav = homeworkUnendsUI(pageNo, Utils.HomeworkStatus.OVER.ordinal() + 1);
		mav.setViewName("work/overs");
		return mav;
	}
	
	/**
	 *  学生提交作业页面
	 * @param id
	 * @return
	 */
	@RequiresPermissions("work:student")
	@RequestMapping(value="ui-submit/{id}", method=RequestMethod.GET)
	public ModelAndView homeworkSubmitUI(@PathVariable("id") String id) {
		TWork work = service.getWorkById(id);
		Integer sId = SessionManagerUtil.getPreviouSessionUser().getUserId();
		List<String> conditional = new ArrayList<>();
		conditional.add("score");
		conditional.add("comment");
		conditional.add("annex");
		conditional.add("status");
		THomework homework = service.getHomeworkByWork(id, sId, conditional );
		resultMap.put("homework", homework);
		resultMap.put("work", work);
		return new ModelAndView("work/submit", "datas", resultMap);
	}
	/**
	 * 	学生作业上传
	 * @param request
	 * @param file
	 * @param workId
	 * @return
	 */
	@RequiresPermissions("work:student")
	@RequestMapping(value="submit", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> homeworkSubmit(HttpServletRequest request, MultipartFile file, String workId) {
		try {
			List<String> conditional = new ArrayList<>();
			conditional.add("id");
			conditional.add("status");
			Integer sId = SessionManagerUtil.getPreviouSessionUser().getUserId();
			THomework homework  = service.getHomeworkByWork(workId, sId, conditional);
			Integer status = homework.getStatus();
			if (Utils.HomeworkStatus.OVER.ordinal() == status || Utils.HomeworkStatus.ACCEPTANCE.ordinal() == status) {
				// 已经禁止再对作业进行修改上传
				throw new Exception("禁止修改作业");
			}
			String filePath = upload(request, file, homework.getId());
			if (filePath == null || filePath.equals("")) {
				throw new Exception("文件上传失败");
			}
			homework.setAnnex(filePath);
			service.submitHomework(homework);
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			LoggerUtil.error(WorkController.class, "学生作业提交失败", e);
			resultMap.put(resultKey, ResultValue.FAIL);
			resultMap.put("msg", e.getMessage());
		}
		return resultMap;
	}
	
	/**
	 * 	通知学生作业
	 * @param homeworkId
	 * @return
	 */
	@RequestMapping(value="notic/{hw}", method=RequestMethod.GET)
	@RequiresPermissions("work:publish")
	@ResponseBody
	public Map<String, Object> homeworkNotic(HttpServletRequest request, HttpServletResponse response, @PathVariable("hw") String homeworkId) {
		try {
			THomework homework = service.getHomeworkById(homeworkId);
			Integer studentId = homework.getStudentId();
			TStudent student = studentService.getById(studentId);
			if (StringUtils.isEmpty(student.getEmail())) {
				throw new Exception("用户邮箱地址为空");
			}
			TWork work = service.getWorkById(homework.getWorkId());
			MailUtil.sendMail("作业通知", student.getEmail(), MailUtil.getNotic(work));
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put(resultKey, ResultValue.FAIL);
			resultMap.put("msg", e.getMessage());
		}
		return resultMap;
	}
}
