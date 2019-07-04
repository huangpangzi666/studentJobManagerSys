<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <title>作业发布记录列表</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    </head>
    <body>
       <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
         <article class="show" style="padding: 20px">
           <div class="btn-group ">
               <button type="button" class="btn btn-default dropdown-toggle"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                   筛选 <span class="caret"></span>
               </button>
               <ul class="dropdown-menu">
                   <li><a href="${pageContext.request.contextPath }/work/ui-recoders?status=0">默认</a></li>
                   <li><a href="${pageContext.request.contextPath }/work/ui-recoders?status=1">进行时</a></li>
                   <li><a href="${pageContext.request.contextPath }/work/ui-recoders?status=2">倒计时</a></li>
                   <li><a href="${pageContext.request.contextPath }/work/ui-recoders?status=3">待验收</a></li>
                   <li><a href="${pageContext.request.contextPath }/work/ui-recoders?status=4">已完成</a></li>
               </ul>
           </div>
           </article>
           <c:forEach items="${datas.works }" var="work">
             <article class="show">
			        <header>
			            <h2>
			              <a  href="${pageContext.request.contextPath }/work/ui-clist/${work.id}">
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
			            <c:if test="${work.status == 0 }">
			              <span class="tag downTime" data-time='<fmt:formatDate  value="${work.acceptanceTime }" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>'>已验收</span>
			            </c:if>
			            <c:if test="${work.status == 1 }">
			              <span class="tag">待验收</span>
			            </c:if>
			            <c:if test="${work.status == 2 }">
			              <span class="tag">已完成</span>
			            </c:if>
			            <span class="tag ">班级：${work.className }</span>
			            <span class="tag ">课程：${work.lessionName }</span>
			            <a href="javascript:;" onclick="showZip('${work.annex }')"  class="btn btn-link" style="line-height: 0.428571;">附件</a>
			            <c:if test="${work.status == 0 }">
			             <a  href="${pageContext.request.contextPath }/work/republish/${work.id }?cname=${work.className}-${work.lessionName}" class="btn btn-danger pull-right" style="line-height: 0.428571;">重新修改</a>
                        </c:if>
			            <c:if test="${work.status ne 0 }">
			             <a target="_blank" href="${pageContext.request.contextPath }/work/republish/${work.id }?cname=${work.className}-${work.lessionName}" class="btn btn-info pull-right" style="line-height: 0.428571;">查看</a>
                        </c:if>
			        </footer>
			    </article>
           </c:forEach>
    <nav aria-label="...">
      <ul class="pager">
        <c:if test="${datas.pageNo>0}">
            <li><a
                href="${pageContext.request.contextPath }/work/ui-recoders?pageNo=${datas.pageNo-1}&status=${datas.status}">上一页</a>
            </li>
        </c:if>
        <c:if test="${(pageNo+1)*10<count }">
            <li><a
                href="${pageContext.request.contextPath }/work/ui-recoders?pageNo=${datas.pageNo+1}&status=${datas.status}">下一页</a>
            </li>
        </c:if>
      </ul>
    </nav>
        </div>
    </body>
  <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
  function showZip(file) {
	    if (file == '') {
	        layer.alert("没有附件");
	        return;
	    }
	    layer.open({
	         title: '文件',
	         type: 2,
	         area: ['580px', '640px'],
	         content: "${pageContext.request.contextPath}/comm/show" + file
	    });
	}
  $(document).ready(function(){
	  var timeTag = $("span.downTime");
	  $.each(timeTag, function(index, item) {
		  var overTime = $(item).attr("data-time");
		  start(item, overTime);
	  })
	});
  function start(item, overTime) {
	//获取当前时间  
	 var date = new Date();  
	 var now = date.getTime();  
	 //设置截止时间  
	 var endDate = new Date(overTime); 
	 var end = endDate.getTime();  
	 //时间差  
	 var leftTime = end-now; 
	 //定义变量 d,h,m,s保存倒计时的时间  
	 var d,h,m,s,str;  
	 if (leftTime>=0) {  
	     d = Math.floor(leftTime/1000/60/60/24);  
	     h = Math.floor(leftTime/1000/60/60%24);  
	     m = Math.floor(leftTime/1000/60%60);  
	     s = Math.floor(leftTime/1000%60);
	     str = "剩余: " + d + "天" + h + "时" + m + "分" + s + "秒";
	 } else {
		 str = "已完成";
	 }
	 $(item).html(str);
	/*  setTimeout('start("'+item+'","'+ overTime +'")',1000); */
	 setTimeout(function(){
		 start(item, overTime)
     }, 1000)
  }
  </script>
</html>
