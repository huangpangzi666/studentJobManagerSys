<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
<meta charset="UTF-8">
<title>授课管理</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bwx/css/base.css" />
</head>

<body>
	<jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
	<div class="main">
		<article class="show">
			<header>
				<button type="button" class="btn btn-default" onclick="add()">添加授课</button>
                 <div class="btn-group navbar-right margin-left-5">
                    <a type="button" class="btn btn-info" href="${pageContext.request.contextPath }/admin/ui-teaching">清除条件</a>
                 </div>
                <div class="btn-group navbar-right margin-left-5">
                    <button type="button" class="btn btn-default dropdown-toggle"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        选择班级 <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-height">
                        <li><a
                            href="${pageContext.request.contextPath }/admin/ui-teaching?status=${datas.status }&teacherId=${datas.teacherId}">不选择</a></li>

                        <c:forEach var="cls" items="${datas.classes }"
                            varStatus="status">
                            <c:if test="${status.index % 3 eq 0 }">
                                <li role="separator" class="divider"></li>
                            </c:if>
                            <li><a
                                href="${pageContext.request.contextPath }/admin/ui-teaching?status=${datas.status }&teacherId=${datas.teacherId}&classId=${cls.id}">${cls.name}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="btn-group navbar-right margin-left-5">
                    <button type="button" class="btn btn-default dropdown-toggle"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        选择教师 <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-height">
                        <li><a
                            href="${pageContext.request.contextPath }/admin/ui-teaching?status=${datas.status }&classId=${datas.classId}">不选择</a></li>

                        <c:forEach var="teacher" items="${datas.teachers }"
                            varStatus="status">
                            <c:if test="${status.index % 3 eq 0 }">
                                <li role="separator" class="divider"></li>
                            </c:if>
                            <li><a
                                href="${pageContext.request.contextPath }/admin/ui-teaching?status=${datas.status }&teacherId=${teacher.id}&classId=${datas.classId}">${teacher.name}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="btn-group navbar-right margin-left-5">
                    <button type="button" class="btn btn-default dropdown-toggle"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        选择状态 <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a
                            href="${pageContext.request.contextPath }/admin/ui-teaching?status=1&teacherId=${datas.teacherId}&classId=${datas.classId}">授课中</a></li>
                        <li><a
                            href="${pageContext.request.contextPath }/admin/ui-teaching?status=0&teacherId=${datas.teacherId}&classId=${datas.classId}">已完成</a></li>
                    </ul>
                </div>
			</header>
			<footer class="tags">
				<table class="table table-hover">
					<thead>
						<tr>
							<td>序号</td>
							<!-- <td>ID</td> -->
							<td>授课人</td>
							<td>授课班级</td>
							<td>授课课程名</td>
							<td>授课状态</td>
							<td>操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="teachings" items="${datas.teachings }" varStatus="status">
							<tr>
								<td>${pageNo*10+status.index+1 }</td>
								<%-- <td>${vo.cid }</td> --%>
								<td><strong class="text-success">${teachings.teacherName }</strong></td>
								<td>${teachings.className}</td>
								<td>${teachings.lessionName }</td>
								<td>
								    <c:if test="${teachings.status eq true }">
                                      <span class="text-success">授课中</span>
                                    </c:if>
                                    <c:if test="${teachings.status eq false }">
                                      <span class="text-info">已完成</span>
                                    </c:if>
                                 </td>
								<td>
								 <c:if test="${teachings.status eq true }">
									<a href="#" class="text-info list-div pull-left"
										onclick="update('${teachings.id}')">修改</a>
								     <a href="#"
										class="text-danger list-div pull-left margin-left-5"
										onclick="deleteItem('${teachings.id}')">删除</a>
	                                 <a href="#"
	                                    class="text-success list-div pull-left margin-left-5"
	                                    onclick="setStatus('${teachings.id}')">完成授课</a>
                                    </c:if>
									</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</footer>
			<p class="text-danger" align="center">总记录数：${count }</p>
		</article>

		<nav aria-label="...">
			<ul class="pager">
				<c:if test="${pageNo>0}">
					<li><a
						href="${pageContext.request.contextPath }/admin/ui-class?pageNo=${pageNo-1}&fid=${datas.fid}&mid=${datas.mid}">上一页</a>
					</li>
				</c:if>
				<c:if test="${(pageNo+1)*10<count }">
					<li><a
						href="${pageContext.request.contextPath }/admin/ui-class?pageNo=${pageNo+1}&fid=${datas.fid}&mid=${datas.mid}">下一页</a>
					</li>
				</c:if>
			</ul>
		</nav>
	</div>
</body>
<script
	src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"
	type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js"
	type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
        // 更新
        function update(id) {
            layer.open({
              title: '修改授课',
              type: 2,
              area: ['480px', '500px'],
              content: '${pageContext.request.contextPath}/admin/ui-teaching-update/' + id,
              end: function() {
                  window.location.reload();
               }
            }); 
        }
        // 设置状态
        function setStatus(id) {
        	layer.confirm('一旦确定完成授课，无法再修改，是否继续？', {icon: 3, title:'提示'}, function(index){
                $.ajax({
                  url: '${pageContext.request.contextPath }/admin/teaching-status',
                  data: {
                	id: id  
                  },
                  type: 'put',
                  dataType: 'json',
                  success: function(result) {
                      if (result.status == 'SUCCESS') {
                          layer.alert('操作成功', function(){
                               layer.close(index); //再执行关闭
                              window.location.reload();
                          });
                      } else {
                          layer.alert('操作失败:<p>'+ result.msg +'</p>');  
                      }
                  }
               });
                layer.close(index);
              });
        }
        // 删除
        function deleteItem(id) {
        	layer.confirm('确定要删除吗？', function(index){
       		$.ajax({
                url: '${pageContext.request.contextPath}/admin/teaching/' + id,
                type: 'delete',
                dataType: 'json',
                success: function(result) {
                    if (result.status == 'SUCCESS') {
                        layer.alert('删除成功', function(){
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                        });  
                        window.location.reload();
                    } else {
                        layer.alert('删除失败，请重试');  
                    }
                }       
              });
      		  layer.close(index);
      		});
        }
        // 添加
        function add() {
          layer.open({
            title: '添加授课',
            type: 2,
            area: ['480px', '540px'],
            content: '${pageContext.request.contextPath}/admin/ui-teaching-add',
            end: function() {
                window.location.reload();
             }
          }); 
        }
        
    </script>

</html>