package com.submit.web.task;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import com.submit.util.LoggerUtil;
import com.submit.web.task.runnable.WorkRunnable;

public class WorkTimerTask {
	private static final int SIZE = 5;
	private static ScheduledExecutorService pool = Executors.newScheduledThreadPool(SIZE);
	private static final Map<String, ScheduledFuture<Boolean>> map = new HashMap<>();
	
	/**
	 * 	开启一个任务
	 * @param runnable
	 * @param date
	 * @throws ExecutionException 
	 * @throws InterruptedException 
	 */
	public void schedule(WorkRunnable runnable, Date date) throws InterruptedException, ExecutionException {
		LoggerUtil.info(WorkTimerTask.class, "开启一个任务: " + runnable );
		long delay = getMinutes(date);
		ScheduledFuture<Boolean> schedule = pool.schedule(runnable, delay , TimeUnit.MINUTES);
		String id = runnable.getId();
		map.put(id, schedule);
	}
	
	/**
	 *  获取剩余的分钟数
	 * @param date
	 * @return
	 */
	public long getMinutes(Date date) {
		LocalDateTime midnight = LocalDateTime.ofInstant(date.toInstant(), ZoneId.systemDefault());
        LocalDateTime currentDateTime = LocalDateTime.now();
        long minutes = ChronoUnit.MINUTES.between(currentDateTime, midnight);
        return minutes < 0 ? 0 : minutes;
	}
	
	/**
	 * 	取消一个任务
	 * @param id
	 * @throws InterruptedException
	 * @throws ExecutionException
	 */
	public void cancel(String id) throws InterruptedException, ExecutionException {
		LoggerUtil.info(WorkTimerTask.class, "取消一个任务: " + id );
		ScheduledFuture<?> future = map.remove(id);
		if (future != null && !future.isDone()) {
			future.cancel(Boolean.TRUE);
		}
	}
	
	/**
	 * 	重新设置任务时间
	 * @param id
	 * @param date
	 * @throws InterruptedException
	 * @throws ExecutionException
	 */
	public void resetDelay(WorkRunnable runnable, Date date) throws InterruptedException, ExecutionException {
		LoggerUtil.info(WorkTimerTask.class, "更改一个任务: " + runnable.getId() );
		this.cancel(runnable.getId());
		this.schedule(runnable, date);
	}

}
