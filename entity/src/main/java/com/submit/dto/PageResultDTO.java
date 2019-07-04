package com.submit.dto;

import java.io.Serializable;

import org.springframework.web.servlet.ModelAndView;

/**
 * 	返回分页页面的数据
 * @author submitX
 *
 */
public class PageResultDTO implements Serializable{
	private int pageNo;
	private int count;
	private Object datas;
	
	public PageResultDTO(int pageNo, int count, Object datas) {
		this.pageNo = pageNo;
		this.count = count;
		this.datas = datas;
	}
	
	/**
	 * 	获取一个ModelAndView对象
	 * @param viewName 视图名
	 * @return
	 */
	public ModelAndView getModelAndView(String viewName) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		mv.addObject("pageNo", pageNo);
		mv.addObject("count", count);
		mv.addObject("datas", datas);
		return mv;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Object getDatas() {
		return datas;
	}
	public void setDatas(Object datas) {
		this.datas = datas;
	}
	@Override
	public String toString() {
		return "PageResultDTO [pageNo=" + pageNo + ", count=" + count + ", datas=" + datas + "]";
	}
	
}
