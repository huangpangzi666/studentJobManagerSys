package com.submit.service.account;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.submit.entity.SysPermission;
import com.submit.entity.SysRole;
import com.submit.entity.TLogin;
import com.submit.service.admin.ILoginService;
import com.submit.service.admin.IPermissionService;
import com.submit.service.admin.IRoleService;
import com.submit.service.admin.impl.LoginServiceImpl;
import com.submit.service.admin.impl.RoleServiceImpl;

/**
 * 	基本的权限数据realm
 * @author submitX
 *
 */
/* (non-Javadoc)
 * @see org.apache.shiro.realm.CachingRealm#getName()
 */
public class ShiroDataBaseRealm extends AuthorizingRealm {

	@Autowired
	private ILoginService loginService;
	@Autowired
	private IRoleService roleService ;
	@Autowired
	private IPermissionService permissionService;
	
	@Override
	public String getName() {
		return "shiroDataBaseRealm";
	}
	
	// 支持什么类型的token
	@Override
	public boolean supports(AuthenticationToken token) {
		return token instanceof UsernamePasswordToken;
	}

	// 授权
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		TLogin login = (TLogin) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		SysRole role = roleService.getById(login.getRoleId());
		info.addRole(role.getName());
		permissionService.getPermissionByRoleId(login.getRoleId())
				.stream()
				.forEach(e -> info.addStringPermission(e.getUrl()));
		return info;
	}

	// 认证
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String username = (String) token.getPrincipal();
		Integer uid = Integer.parseInt(username);
		TLogin login = null;
		try {
			login = loginService.getByUserId(uid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (login == null) {
			return null;
		}
		// 判断帐号是否锁定
        if (Boolean.FALSE.equals(login.getStatus())) {
            // 抛出 帐号锁定异常
            throw new LockedAccountException();
        }
		String password = login.getPassword();
		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(login, password, ByteSource.Util.bytes("xianz.vip"), getName());
		return info;
	}

	/**
	 * 	清除缓存
	 */
	public void clearShiroCache() {
		PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
		super.clearCache(principals);
	}
}
