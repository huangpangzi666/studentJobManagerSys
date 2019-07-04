package com.submit.vo;

import java.io.Serializable;

import com.submit.entity.TClass;
import com.submit.entity.TFaculty;

/**
 * 	class班级的包装类pojo
 */
public class ClassVO implements Serializable{
	/**
	 * 	class的id，映射到这里，class中就无id，为了解决自动封装无主键时仅class不同时只显示一个
	 */
	private String cid;
	
	private TClass cls;
	/**
	 * 	所属专业名称
	 */
	private String mName;
	/**
	 * 	所属院系id
	 */
	private Integer fid;
	/**
	 * 	所属院系name
	 */
	private String fName;
	
	public ClassVO() {
	}
	public ClassVO(TClass cls, String mName, TFaculty faculty) {
		this.cls = cls;
		this.mName = mName;
		this.fid = faculty.getId();
		this.fName = faculty.getName();
	}
	public TClass getCls() {
		return cls;
	}
	
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public void setCls(TClass cls) {
		this.cls = cls;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public Integer getFid() {
		return fid;
	}
	public void setFid(Integer fid) {
		this.fid = fid;
	}
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
	
}
