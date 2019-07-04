package com.submit.entity;

import java.io.Serializable;

public class SysRolePermission  implements Serializable {
    private Integer roleId;

    private Integer permissionId;

    
    
    public SysRolePermission() {
	}

	public SysRolePermission(Integer roleId, Integer permissionId) {
		this.roleId = roleId;
		this.permissionId = permissionId;
	}

	public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(Integer permissionId) {
        this.permissionId = permissionId;
    }
}