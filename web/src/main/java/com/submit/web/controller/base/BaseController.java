package com.submit.web.controller.base;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.submit.entity.TLogin;
import com.submit.util.LoggerUtil;
import com.submit.util.SessionManagerUtil;
import com.submit.util.Utils;

/**
 * 	基本的功能性代码
 * @author submitX
 *
 */
public class BaseController {
	/**
	 *	操作结构值
	 */
	protected static enum ResultValue {SUCCESS, FAIL, ERROR};
	
	public static final String URL_404 = "open/404";
	public static final String URL_UNAUTHORIZED = "open/unauthorized";
	public static final String URL_LOGIN = "open/login";
	protected Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
	protected final String resultKey = "status";
	/**
	 * 	默认分页都是显示十条数据
	 */
	protected final int pageSize = 10;
	
	
	/**
	 * 	将file文件存储在指定位置，相对目录
	 * @param request
	 * @param file 文件数据
	 * @param name 文件名
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	public String upload(HttpServletRequest request, MultipartFile file, String name) throws IllegalStateException, IOException {
		LoggerUtil.info(BaseController.class, "upload homework id = " + name);
		TLogin login = SessionManagerUtil.getPreviouSessionUser();
		String roleName = SessionManagerUtil.getUserRoleName();
		if (roleName == null) {
			return null;
		}
		StringBuffer url = new StringBuffer();
		if (roleName.equals(Utils.RoleName.ADMIN.toString())) {
			url.append(Utils.getFileByNameInFiles(""));
		} else {
			url.append(Utils.getFilesSaveRootPath()).append(roleName).append("/")
				.append(login.getUserId());
		}
		if (!Files.exists(Paths.get(url.toString()))) {
			Files.createDirectories(Paths.get(url.toString()));
		} 
		String subfix = Utils.getSubfix(file.getOriginalFilename());
		url.append("/").append(name).append(subfix);
		String filePath = url.toString();
		Files.deleteIfExists(Paths.get(filePath));
		File f = new File(filePath);
		file.transferTo(f);
		filePath = roleName.equals(Utils.RoleName.ADMIN.toString()) ? filePath.replace(Utils.getFileByNameInFiles(""), "/") : filePath.replace(Utils.getFilesSaveRootPath(), "/");
		return filePath;
	}
	
}
