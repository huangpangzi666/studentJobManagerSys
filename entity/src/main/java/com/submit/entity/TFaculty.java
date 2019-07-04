package com.submit.entity;

import java.io.Serializable;
import java.util.Date;

public class TFaculty implements Serializable  {
    private Integer id;

    private String name;

    private String description;

    private Date gmtCreate;

    private Date gmtModified;

    
    public TFaculty() {
	}

	public TFaculty(Integer id, String name) {
		this.id = id;
		this.name = name;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
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
}