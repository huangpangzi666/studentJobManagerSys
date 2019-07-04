package com.submit.entity;

import java.io.Serializable;
import java.util.Date;

public class TStudent  implements Serializable {
    private Integer id;

    private String name;

    private String phone;

    private Boolean sex;

    private String headshot;

    private String classId;

    private Date gmtCreate;

    private Date gmtModified;
    
    private String email;
    // 新增属性
    private String className;
    
    private TLogin login;

    public TLogin getLogin() {
		return login;
	}

	public void setLogin(TLogin login) {
		this.login = login;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public Boolean getSex() {
        return sex;
    }

    public void setSex(Boolean sex) {
        this.sex = sex;
    }

    public String getHeadshot() {
        return headshot;
    }

    public void setHeadshot(String headshot) {
        this.headshot = headshot == null ? null : headshot.trim();
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId == null ? null : classId.trim();
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    public Date getGmtModified() {
        return gmtModified;
    }

    public void setGmtModified(Date gmtModified) {
        this.gmtModified = gmtModified;
    }

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	@Override
	public String toString() {
		return "TStudent [id=" + id + ", name=" + name + ", phone=" + phone + ", sex=" + sex + ", headshot=" + headshot
				+ ", classId=" + classId + ", gmtCreate=" + gmtCreate + ", gmtModified=" + gmtModified + ", className="
				+ className + ", login=" + login + "]";
	}
    
}