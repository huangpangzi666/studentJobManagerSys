package com.submit.util;

import java.io.File;
import java.io.IOException;
import java.net.ConnectException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.StreamOpenOfficeDocumentConverter;

public class Office2PdfUtil {
	private static final String HOST = "127.0.0.1";
	private static final int PORT = 8100;
	/**
	 * 	将文件进行转换，获取新的文件格式为pdf
	 * @param itemPath
	 * @return
	 */
	public static File converter(String itemPath) {
		File fileIn = new File(itemPath);
		if (!fileIn.exists()) {
			return null;
		}
		String path = fileIn.getPath();
		String suffix = Utils.getSubfix(path);
		if (suffix.equals(".pdf")) {
			return fileIn;
		} else if (suffix.equals(".txt")) {
			suffix = ".odt";
		}
		String regex = "(\\.doc|\\.docx|\\.ppt|\\.pptx|\\.xlsx|\\.xls|\\.odt)";
		if (!suffix.matches(regex )) {
			LoggerUtil.debug(Office2PdfUtil.class, "无法转换文件" + itemPath, null);
			return new File(Utils.getFileByNameInFiles("declaration.pdf"));
		}
		int lastIndexOf = path.lastIndexOf(".");
		path = path.substring(0, lastIndexOf) + ".pdf";
		OpenOfficeConnection connection = new SocketOpenOfficeConnection(HOST, PORT);
		File fileOut = null;
    	try {
    		LoggerUtil.info(Office2PdfUtil.class, "openoffice connect()");
			connection.connect();
			LoggerUtil.info(Office2PdfUtil.class, "openoffice converter start");
			DocumentConverter converter = new StreamOpenOfficeDocumentConverter(
					connection);
			LoggerUtil.info(Office2PdfUtil.class, "openoffice converter end");
			fileOut = new File(path);
			converter.convert(fileIn, fileOut);
		} catch (ConnectException e) {
			LoggerUtil.error(Office2PdfUtil.class, "openoffice服务未启动");
			e.printStackTrace();
		} finally {
			if (connection.isConnected()) {
				connection.disconnect();
			}
			// 删除临时文件
			try {
				Files.delete(Paths.get(fileIn.getPath()));
			} catch (IOException e) {
				LoggerUtil.error(Office2PdfUtil.class, "office2PdfUtil - converter 删除原始文件失败");
				e.printStackTrace();
			}
		}
    	return fileOut;
	}
	
	/**
     * 	将pdf文件设置头信息回显客户端
     * @param file zip中的某项文件
     * @return
     * @throws IOException
     */
    public static ResponseEntity<byte[]> preview(File file) throws IOException {
        byte[] pdfFileBytes = FileUtils.readFileToByteArray(file);

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.valueOf("application/pdf"));
        httpHeaders.setContentLength(pdfFileBytes.length);
        httpHeaders.add(HttpHeaders.ACCEPT_RANGES, "bytes");

        return new ResponseEntity<byte[]>(pdfFileBytes, httpHeaders, HttpStatus.OK);
    }
}
