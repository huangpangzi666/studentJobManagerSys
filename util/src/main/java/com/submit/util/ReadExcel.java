package com.submit.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import com.submit.entity.TStudent;

public class ReadExcel {
	// 总行数
	private int totalRows = 0;
	// 总条数
	private int totalCells = 0;

	// 构造方法
	public ReadExcel() {
	}

	// 获取总行数
	public int getTotalRows() {
		return totalRows;
	}

	// 获取总列数
	public int getTotalCells() {
		return totalCells;
	}

	/**
	 * 读EXCEL文件，获取学生信息集合
	 * 
	 * @param fielName
	 * @param classId  学生隶属班级的id
	 * @return
	 * @throws IOException 
	 */
	public List<TStudent> getExcelInfo(MultipartFile mFile) throws IOException {
		// 将上传的数据保存到一个file中，然后再读取，目的是为了 使用file对象，因为使用mFile.getInputStream()获取的流会全部加载内存
		// 把spring文件上传的MultipartFile转换成CommonsMultipartFile类型
		CommonsMultipartFile cf = (CommonsMultipartFile) mFile;
		// 获取本地存储路径
		String filepath = Utils.getTempFilesSaveRootPath() + "temp.xlsx";
		// 新建一个文件
		File file1 = new File(filepath);
		// 将上传的文件写入新建的文件中
		try {
			cf.getFileItem().write(file1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 初始化客户信息的集合
		List<TStudent> studentList = new ArrayList<TStudent>();
		// 初始化输入流
		FileInputStream is = null;
		Workbook wb = null;
		try {
			// 根据新建的文件实例化输入流
			is = new FileInputStream(file1);
			// 根据excel里面的内容读取客户信息

			// 当excel是2003时
			//wb = new HSSFWorkbook(is);
			// 当excel是2007时
			 wb = new XSSFWorkbook(is);

			// 读取Excel里面客户的信息
			studentList = readExcelValue(wb);
			is.close();
		} finally {
			if (is != null) {
				try {
					is.close();
					Files.delete(Paths.get(filepath));
				} catch (IOException e) {
					is = null;
					e.printStackTrace();
				}
			}
		}
		return studentList;
	}

	/**
	 * 读取Excel里面客户的信息
	 * 
	 * @param wb
	 * @return
	 */
	private List<TStudent> readExcelValue(Workbook wb) {
		// 得到第一个shell
		Sheet sheet = wb.getSheetAt(0);

		// 得到Excel的行数
		this.totalRows = sheet.getPhysicalNumberOfRows();

		// 得到Excel的列数(前提是有行数)
		if (totalRows >= 2 && sheet.getRow(0) != null) {// 判断行数大于一，并且第一行必须有标题（这里有bug若文件第一行没值就完了）
			this.totalCells = sheet.getRow(0).getPhysicalNumberOfCells();
		} else {
			return null;
		}

		List<TStudent> students = new ArrayList<TStudent>();// 声明一个对象集合
		TStudent student;// 声明一个对象

		// 循环Excel行数,从第三行开始。标题不入库
		for (int r = 2; r < totalRows; r++) {
			Row row = sheet.getRow(r);
			if (row == null)
				continue;
			student = new TStudent();

			// 循环Excel的列
			for (int c = 0; c < this.totalCells; c++) {
				Cell cell = row.getCell(c);
				if (null != cell) {
					if (c == 0) {
						student.setName(getValue(cell));
					} else if (c == 1) {
						if (getValue(cell).equals("女")) {
							student.setSex(false);
						} else {
							student.setSex(true);
						}
					} else if (c == 2) {
						student.setPhone(getValue(cell));
					} else if (c == 3) {
						student.setEmail(getValue(cell));
					} else if (c == 4) {
						student.setClassName(getValue(cell));
					}
				}
			}
			// 添加对象到集合中
			students.add(student);
		}
		return students;
	}

	/**
	 * 得到Excel表中的值
	 *
	 * @param cell Excel中的每一个格子
	 * @return Excel中每一个格子中的值
	 */
	private String getValue(Cell cell) {
		if (cell.getCellType() == CellType.BOOLEAN) {
			// 返回布尔类型的值
			return String.valueOf(cell.getBooleanCellValue());
		} else if (cell.getCellType() == CellType.NUMERIC) {
			// 返回数值类型的值
			DecimalFormat df = new DecimalFormat("0"); 
			return String.valueOf(df.format(cell.getNumericCellValue()));
		} else {
			// 返回字符串类型的值
			return String.valueOf(cell.getStringCellValue());
		}
	}

}
