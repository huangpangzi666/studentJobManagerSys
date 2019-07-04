<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <title>已完成作业列表</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    </head>
    <body>
       <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
           <c:forEach items="${datas.works }" var="work">
             <article class="show">
			        <header>
			            <h2>
			              <a  href="${pageContext.request.contextPath }/work/ui-submit/${work.id}">
			                 ${work.name }
			              </a>
			            </h2>
			            <time><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
			<fmt:formatDate value="${work.gmtCreate }" pattern="yyyy-MM-dd HH:mm:ss"/> </time>
			        </header>
			        <section class="abstract article-body">
			         ${work.demand }
			        </section>
			        <footer class="tags">
			            <span class="tag">已完成</span>
			            <span class="tag ">课程：${work.lessionName }</span>
			            <span class="tag ">任课老师：${work.teacherName }</span>
			        </footer>
			    </article>
           </c:forEach>
    <nav aria-label="...">
      <ul class="pager">
        <c:if test="${datas.pageNo>0}">
            <li><a
                href="${pageContext.request.contextPath }work/ui-overs?pageNo=${datas.pageNo-1}&status=${datas.status}">上一页</a>
            </li>
        </c:if>
        <c:if test="${(pageNo+1)*10<count }">
            <li><a
                href="${pageContext.request.contextPath }/work/ui-overs?pageNo=${datas.pageNo+1}&status=${datas.status}">下一页</a>
            </li>
        </c:if>
      </ul>
    </nav>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
</html>
