<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>压缩文件预览</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    </head>
    <body id="top_logo" style="padding: 10px;">
        <ul class="list-group">
            <c:forEach var="item" items="${files.catalog }">
			  <li class="list-group-item">
			    <a  target="_blank" href="${pageContext.request.contextPath }/comm/read/${files.zipPath}?item=${item}" class="pull-right">预览</a>
			    ${item }
			  </li>
            </c:forEach>
		</ul>
        <h3 style="text-align: right;">
            <a type="button" class="btn btn-danger" href="${pageContext.request.contextPath }/comm/download/${files.zipPath}">打包下载</a>
        </h3>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>

</html>