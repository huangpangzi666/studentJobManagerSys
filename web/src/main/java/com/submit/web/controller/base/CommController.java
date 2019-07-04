package com.submit.web.controller.base;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.submit.util.LoggerUtil;
import com.submit.util.MailUtil;
import com.submit.util.Office2PdfUtil;
import com.submit.util.Utils;
import com.submit.util.ZipUtil;

/**
 * 	公共的请求action
 * @author submitX
 * 
 */
@Controller
@Scope("prototype")
@RequestMapping("comm")
public class CommController extends BaseController {
	
	/**
	 *	 验证码对象
	 */
	private Producer captchaProducer = null;  
    @Autowired  
    public void setCaptchaProducer(Producer captchaProducer) {  
        this.captchaProducer = captchaProducer;  
    }
    /**
     * 	获取验证码图形化，验证码放在session名为KAPTCHA_SESSION_KEY中
     * @param request
     * @param response
     * @return null，write验证码的图片到response中
     * @throws Exception
     */
	@RequestMapping(value="/captcha-image", method=RequestMethod.GET)
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {  
        response.setDateHeader("Expires", 0);// 禁止服务器端缓存  
        // 设置标准的 HTTP/1.1 no-cache headers.  
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");  
        // 设置IE扩展 HTTP/1.1 no-cache headers (use addHeader).  
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
        response.setHeader("Pragma", "no-cache");// 设置标准 HTTP/1.0 不缓存图片  
        response.setContentType("image/jpeg");// 返回一个 jpeg 图片，默认是text/html(输出文档的MIMI类型)  
        String capText = captchaProducer.createText();// 为图片创建文本  
        capText = capText.toUpperCase();
        // 将文本保存在session中，这里就使用包中的静态变量吧  
        request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);  
          
        BufferedImage bi = captchaProducer.createImage(capText); // 创建带有文本的图片  
        ServletOutputStream out = response.getOutputStream();  
        // 图片数据输出  
        ImageIO.write(bi, "jpg", out);  
        try {  
            out.flush();  
        } finally {  
            out.close();  
        }  
  
        System.out.println("Session 验证码是：" + request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY));  
        return null;  
    }
	
	/**
	 * 	邮件发送
	 * @param request
	 * @param emailId
	 * @return 操作码
	 */
	@ResponseBody
	@RequestMapping(value="email", method=RequestMethod.GET)
	public Map<String, Object> emailActivationCode(HttpServletResponse response, HttpServletRequest request, 
			@RequestParam("email")String emailAddress, @RequestParam("type")int type) {
		String code = UUID.randomUUID().toString();
		// session的键值 存活30分钟
		request.getSession().setMaxInactiveInterval(60 * 30);
		request.getSession().setAttribute(MailUtil.EMAIL_KEY, code);
		try {
			if (type == MailUtil.TYPE_REPASSWORD) {
				MailUtil.sendMail("学生管理系统: 更新密码", emailAddress, MailUtil.getRePasswordMsg(code));
			} 
			resultMap.put(resultKey, ResultValue.SUCCESS);
		} catch (Exception e) {
			LoggerUtil.error(CommController.class, "邮件发送失败");
			resultMap.put(resultKey, ResultValue.FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 	文件下载，某个角色的id用户所对应的文件 
	 * 	/download/student/100000/score.docx
	 * @param request
	 * @param name
	 * @param sub
	 * @return
	 * @throws IOException
	 */
	@RequiresAuthentication
    @RequestMapping(value= {"/download//{roleName:student}/{userId:[1-9][0-9]{9}}/{fielName}.{sub}", 
    		"/download//{roleName:teacher}/{userId:[1-9][0-9]{3}}/{fielName}.{sub}", "/download/{fielName}.{sub}"}, method=RequestMethod.GET)  
    public ResponseEntity<byte[]> download(HttpServletRequest request, @PathVariable(value="roleName", required=false)String roleName,
    		@PathVariable(value="userId", required=false)Integer userId, @PathVariable("fielName")String name, @PathVariable("sub")String sub) throws IOException { 
    	if (roleName != null) {
    		return export(roleName, userId, name, sub);
    	} else {
    		return export(null, null, name, sub);
    	}
    } 
    /**
     *	文件下载逻辑
     * @param request
     * @param directory
     * @param fileName
     * @return
     * @throws IOException
     */
    public ResponseEntity<byte[]> export(String roleName, Integer userId, String fileName, String fileSuffix) throws IOException {  
    	StringBuffer url = new StringBuffer(); 
    	if (userId == null || roleName == null) {
    		// 基础文件下载
    		url.append(Utils.getFileByNameInFiles(fileName + "." + fileSuffix));
    	} else {
    		url.append(Utils.getFilesSaveRootPath()).append(roleName).append("/").append(userId).append("/")
    			.append(fileName).append(".").append(fileSuffix);
    	}
    	HttpHeaders headers = new HttpHeaders();    
    	File file = new File(url.toString());
    	try {
    		fileName = fileName + "." + fileSuffix;
    		fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
    	} catch (UnsupportedEncodingException e) {
    		e.printStackTrace();
    	}
    	headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);    
    	headers.setContentDispositionFormData("attachment", fileName);    
    	
    	return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
    			headers, HttpStatus.CREATED);    
    } 
    
    
    /**
     * 	显示zip里面的文件列表
     * @param filePath
     * @return
     */
    @RequiresAuthentication
    @RequestMapping(value= {"/show/{roleName:student}/{userId:[1-9][0-9]{9}}/{fielName}.{sub}", 
    		"/show/{roleName:teacher}/{userId:[1-9][0-9]{3}}/{fielName}.{sub}"}, method=RequestMethod.GET)
    public ModelAndView showZip(HttpServletRequest request,  @PathVariable(value="roleName")String roleName,
    		@PathVariable(value="userId")Integer userId, @PathVariable("fielName")String name, @PathVariable("sub")String sub) {
    	StringBuffer url = new StringBuffer(); 
    	if (userId == null || roleName == null) {
    		// 基础文件
    		url.append(Utils.getFileByNameInFiles(name + "." + sub));
    	} else {
    		url.append("/").append(roleName).append("/").append(userId).append("/")
    			.append(name).append(".").append(sub);
    	}
		ArrayList<String> list = ZipUtil.getZipFilesPath(Utils.getFilesSaveRootPath() + url.toString());
    	resultMap.put("zipPath", url.toString());
    	resultMap.put("catalog", list);
    	return new ModelAndView("work/show", "files", resultMap);
    }
    
    /**
     * 	阅读zip文件中的某个文件
     * @param request
     * @param roleName
     * @param userId
     * @param name
     * @param sub
     */
    @RequiresAuthentication
    @RequestMapping(value= {"/read//{roleName:student}/{userId:[1-9][0-9]{9}}/{fielName}.{sub}", 
    		"/read//{roleName:teacher}/{userId:[1-9][0-9]{3}}/{fielName}.{sub}"}, method=RequestMethod.GET)
    public ResponseEntity<byte[]> readZipItem(HttpServletRequest request,  @PathVariable(value="roleName")String roleName, @RequestParam("item")String item,
    		@PathVariable(value="userId")Integer userId, @PathVariable("fielName")String name, @PathVariable("sub")String sub) {
    	String path = Utils.getFilesSaveRootPath();
    	StringBuffer url = new StringBuffer();
    	url.append(Utils.getFilesSaveRootPath()).append(roleName).append("/").append(userId).append("/")
			.append(name).append(".").append(sub);
    	String itemFile = ZipUtil.readZipFileItem(url.toString(), item);
    	ResponseEntity<byte[]> entity = null;
    	try {
			File file = Office2PdfUtil.converter(itemFile);
    		if (file != null) {
    			entity = Office2PdfUtil.preview(file);
    		}
		} catch (IOException e) {
			LoggerUtil.error(CommController.class, "读取pdf失败", e);
			e.printStackTrace();
		}
    	return entity;
    }
    
    @RequestMapping(value= {"/view//{roleName:student}/{userId:[1-9][0-9]{9}}/{fielName}.{sub}", 
			"/view//{roleName:teacher}/{userId:[1-9][0-9]{3}}/{fielName}.{sub}"}, method=RequestMethod.GET)
    public ModelAndView viewPDF(HttpServletRequest request,  @PathVariable(value="roleName")String roleName, @RequestParam("item")String item,
    		@PathVariable(value="userId")Integer userId, @PathVariable("fielName")String name, @PathVariable("sub")String sub) {
    	StringBuffer url = new StringBuffer();
    	url.append("/").append(roleName).append("/").append(userId).append("/")
			.append(name).append(".").append(sub);
    	resultMap.put("file", url.toString());
    	resultMap.put("item", item);
    	return new ModelAndView("/page/pdfjs/web/view.html", resultMap);
    }
    
}
