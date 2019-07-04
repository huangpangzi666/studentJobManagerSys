package com.submit.dto;

import java.io.Serializable;

import com.submit.entity.SysRole;

/**
 * 	接收role和permission的id集合
 * @author submitX
 *
 */
public class RolePermissionDTO implements Serializable{

	private SysRole role;
	private int[] permissionids;
	public SysRole getRole() {
		return role;
	}
	public void setRole(SysRole role) {
		this.role = role;
	}
	public int[] getPermissionids() {
		return permissionids;
	}
	public void setPermissionids(int[] permissionids) {
		this.permissionids = permissionids;
	}
	
	
}
