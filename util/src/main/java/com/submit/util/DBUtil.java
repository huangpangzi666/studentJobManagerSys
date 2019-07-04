package com.submit.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.SQLException;

import org.springframework.jdbc.datasource.DataSourceUtils;

import com.alibaba.druid.pool.DruidDataSource;

/**
 * 	数据库工具
 * @author submitX
 *
 */
public class DBUtil {
	
	/**
     * @param filepath 数据库备份的脚本路径
     * @param ip IP地址
     * @param database 数据库名称
     * @param userName 用户名
     * @param password 密码
     * @return
     
    public static boolean recover(String filepath,String ip,String database, String userName,String password) {
    	// mysql -uroot -p  dbname ＜ backup.sql
    	StringBuffer buffer = new StringBuffer();
    	buffer.append("mysql").append(" -h").append(ip).append(" -p").append(3306)
    		.append(" -u").append(userName).append(" -p")
    		.append(password).append(" ").append(database);
    	Runtime runtime = Runtime.getRuntime();
    	try {
			Process process = runtime.exec(buffer.toString());
			OutputStream out = process.getOutputStream();//控制台的输入信息作为输出流      
			OutputStream outputStream = process.getOutputStream();
	        BufferedReader br = new BufferedReader(new InputStreamReader(
	                new FileInputStream(filepath)));
	        String str = null;
	        StringBuffer sb = new StringBuffer();
	        while ((str = br.readLine()) != null) {
	            sb.append(str + "\r\n");
	        }
	        str = sb.toString();
	        OutputStreamWriter writer = new OutputStreamWriter(outputStream,
	                "utf-8");
	        writer.write(str);
	        writer.flush();
	        outputStream.close();
	        br.close();
	        writer.close();
		} catch (IOException e) {
			e.printStackTrace();
			LoggerUtil.error(DBUtil.class, "数据库备份失败");
			return false;
		}
        return true;
    }
	*/
	
	
	/**
	 * 	获取数据库连接
	 * @return
	 */
	public Connection getConnection() {
		DruidDataSource source = (DruidDataSource) ApplicationContextHelper.getBean("dataSource");
		Connection connection = DataSourceUtils.getConnection(source);
		return connection;
	}
	
	/**
	 * 	或滚事物
	 * @param conn
	 */
	public void rollback(Connection conn) {
		if (conn != null) {
			try {
				if (!conn.getAutoCommit()) {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 	关闭连接
	 * @param connection
	 */
	public void closeConnection(Connection connection) {
		try {
			if (connection != null && !connection.isClosed()) {
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
