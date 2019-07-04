<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <title>权限不足</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    </head>
    <body>
     <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
     <div class="main">
        <div class="content-center">
            <div class="demo">
                <p>
                    <span>unauthorized</span>
                </p>
                <p>
                    止步于此,权限不足(´･ω･`) <a href="${pageContext.request.contextPath }/index">返回首页</a>
                </p>
            </div>
        </div>
    </div>
    </body>
    <script src="${pageContext.request.contextPath }/bwx/js/jquery-3.3.1.min.js" type="text/javascript"
    charset="utf-8"></script>
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
</html>
