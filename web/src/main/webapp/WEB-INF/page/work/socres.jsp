<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <title>成绩列表</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    </head>
    <body>
        <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
     <article class="show">
        <header>
            <h2>
              <a  href="score.html">
                  高数第二节求微积分
              </a>
            </h2>
            <time><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
 2018-10-10</time>
        </header>
        <section class="abstract article-body">
          基于Okhttp网络请求框架的封装
        </section>
        <footer class="tags">
            <span class="glyphicon glyphicon-user"> 已验收</span>
            <span class="glyphicon glyphicon-thumbs-up tag "> 70分</span>
            <a rel="nofollow" >
                <img class="avatar" src="https://thirdqq.qlogo.cn/g?b=sdk&amp;k=SJMrOq4DBnYOXnkMKMj5kg&amp;s=100&amp;t=1483337289">
            </a>
        </footer>
    </article>
    <nav aria-label="...">
      <ul class="pager">
        <li><a href="#">上一页</a></li>
        <li class="disabled"><a>下一页</a></li>
      </ul>
    </nav>
        </div>
    </body>
  <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
</html>
