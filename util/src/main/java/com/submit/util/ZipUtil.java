package com.submit.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

public class ZipUtil {
	
	public static final int BUFFER_SIZE = 1024;
	private static final Charset CHARSET = Charset.forName("GBK");
	
	public static void main(String[] args) throws IOException {
		
	}
	
	
	/**
	 *  获取zip文件目录结构
	 * @param zipFile
	 * @return
	 */
	public static ArrayList<String> getZipFilesPath(String zipFile) {
		ArrayList<String> list = new ArrayList<>();
		try (ZipFile file = new ZipFile(new File(zipFile), CHARSET)) {
			Enumeration<? extends ZipEntry> entries = file.entries();
			while (entries.hasMoreElements()) {
				ZipEntry entry = entries.nextElement();
				if (entry.isDirectory()) {
				} else {
					list.add(entry.getName());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 	读取zip文件中某文件的内容
	 * @param zipFile
	 * @param fileItem
	 */
	public static String readZipFileItem(String zipFile, String fileItem) {
		String suffix = Utils.getSubfix(fileItem);
		try (ZipInputStream zin = new ZipInputStream(new BufferedInputStream(new FileInputStream(zipFile)), CHARSET)) {
			ZipFile zFile = new ZipFile(zipFile);
			ZipEntry entry = zFile.getEntry("fileItem");
			ZipEntry zipEntry = null;
			byte[] b = new byte[BUFFER_SIZE];
			int len = 0;
			while ((zipEntry = zin.getNextEntry()) != null) {
				if (zipEntry.getName().equals(fileItem)) {
					String catalog = Utils.getTempFilesSaveRootPath();
					if (!Files.exists(Paths.get(catalog))) {
						Files.createDirectory(Paths.get(catalog));
					}
					File file = new File(catalog + UUID.randomUUID() + suffix);
					try (FileOutputStream fos = new FileOutputStream(file)) {
						while ((len = zin.read(b, 0, BUFFER_SIZE)) != -1) {
							fos.write(b, 0, len);
						}
						return file.getPath();
					}
				}
			}
			zFile.close();
			entry.clone();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
