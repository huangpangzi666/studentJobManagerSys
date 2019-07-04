package com.submit.web.task.runnable;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.concurrent.Callable;
import com.submit.util.DBUtil;
import com.submit.util.LoggerUtil;
import com.submit.util.Utils.HomeworkStatus;

/**
 * 	任务计时, 使用手动获取数据源和sql的执行
 * @author submitX
 *
 */
public class WorkRunnable implements Callable<Boolean> {
	
	private final String id;
	
	public WorkRunnable(String id) {
		this.id = id;
	}

	@Override
	public Boolean call() throws Exception {
		Connection connection = null;
		DBUtil db = new DBUtil();
		try {
			LoggerUtil.info(WorkRunnable.class, "set work status ....");
			connection = db.getConnection();
			connection.setAutoCommit(Boolean.FALSE);
			String sql = "update t_work set status = 1 where id = ?";
			PreparedStatement pre = connection.prepareStatement(sql );
			pre.setString(1, this.getId());
			pre.execute();
			/*
			sql = "update t_homework set status = ? where work_id = ?";
			pre = connection.prepareStatement(sql);
			pre.setInt(1, HomeworkStatus.OVER.ordinal());
			pre.setString(2, this.getId());
			pre.execute();
			*/
			connection.commit();
			LoggerUtil.info(WorkRunnable.class, "set work status sucessful");
		} catch (Exception e) {
			e.printStackTrace();
			db.rollback(connection);
			LoggerUtil.error(WorkRunnable.class, "作业状态设置出错", e);
			return Boolean.FALSE;
		} finally {
			db.closeConnection(connection);
		}
		return Boolean.TRUE;
	}

	
	
	public synchronized String getId() {
		return this.id;
	}
	
	@Override
	public String toString() {
		
		return "[ " + this.id + " -- " + super.toString() + " ]";
	}
}