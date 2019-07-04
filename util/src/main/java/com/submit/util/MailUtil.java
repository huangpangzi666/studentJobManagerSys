package com.submit.util;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import com.submit.entity.TWork;

/**
 * 	邮件发送工具类
 * @author submitX
 *
 */
public class MailUtil {
	/**
	 * 	邮件类型
	 */
	public static final int TYPE_NOTIC = 0;
	public static final int TYPE_REPASSWORD = 1;
	public static final String EMAIL_KEY = "EMAIL_SESSION_KEY";

	/**
	 *  发送邮件
	 * @param title 邮件标题
	 * @param email 接收邮件人
	 * @param emailMsg 邮件内容
	 * @throws AddressException
	 * @throws MessagingException
	 * @throws IOException 
	 */
	public static void sendMail(String title, String email, String emailMsg)
			throws AddressException, MessagingException, IOException {
		// 1.创建一个程序与邮件服务器会话对象 Session
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", PropertiesUtil.getProperty("mail.transport.protocol"));
		props.setProperty("mail.host", PropertiesUtil.getProperty("mail.host"));
		props.setProperty("mail.smtp.auth", PropertiesUtil.getProperty("mail.smtp.auth"));// 指定验证为true

		// 创建验证器
		Authenticator auth = new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(PropertiesUtil.getProperty("mail.username"), 
						PropertiesUtil.getProperty("mail.password"));
			}
		};

		Session session = Session.getInstance(props, auth);

		// 2.创建一个Message，它相当于是邮件内容
		Message message = new MimeMessage(session);

		message.setFrom(new InternetAddress((PropertiesUtil.getProperty("mail.internetAddress")), 
				PropertiesUtil.getProperty("mial.personal"), "UTF-8")); // 设置发送者

		message.setRecipient(RecipientType.TO, new InternetAddress(email)); // 设置发送方式与接收者

		message.setSubject(title);
		
		message.setContent(emailMsg, "text/html;charset=utf-8");

        // 6. 设置显示的发件时间
        message.setSentDate(new Date());
		// 3.创建 Transport用于将邮件发送
		Transport.send(message);
     // 8. 将该邮件保存到本地
//        OutputStream out = new FileOutputStream("D:\\MyEmail.eml");
//        message.writeTo(out);
//        out.flush();
//        out.close();
	}
	
	/**
	 * 	用户激活内容
	 * @return
	 */
	public static String getRePasswordMsg(String code) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("<div style=\"font: 14px Helvetica Neue,Helvetica,PingFang SC,微软雅黑,Tahoma,Arial,sans-serif;\";>") 
				.append("<h2 style=\"text-align: center;\">用户更改密码</h2>") 
				.append("<h4 style=\"text-align:center;\">验证码:")
				.append("<label style=\"color: #FD482C;\">")
				.append(code)
				.append("</label>")
				.append("</h4>")
				.append(" </div>");
		return buffer.toString();
	}

	/**
	 * 	通知作业
	 * @param work
	 * @return
	 */
	public static String getNotic(TWork work) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("<div style=\"font: 14px Helvetica Neue,Helvetica,PingFang SC,微软雅黑,Tahoma,Arial,sans-serif;\";>") 
		.append("<h2 style=\"text-align: center;\">作业提醒通知</h2>")
		.append("<h4>作业名:")
		.append(work.getName())
		.append("</h4>")
		.append("<h4>作业期限:")
		.append(Utils.getFormatterDate(work.getAcceptanceTime()))
		.append("</h4>");
		return buffer.toString();
	}
}






















