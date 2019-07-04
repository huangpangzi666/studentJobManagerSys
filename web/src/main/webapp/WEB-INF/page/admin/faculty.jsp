<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
<meta charset="UTF-8">
<title>院系管理</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bwx/css/base.css" />
	<style type="text/css">
	   .table { table-layout: fixed;}
	</style>
</head>

<body>
	<jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
	<div class="main">
		<article class="show">
			<header>
				<button type="button" class="btn btn-default" onclick="add()">添加院系</button>
			</header>
			<footer class="tags">
				<table class="table table-hover">
					<thead>
						<tr >
							<td>序号</td>
							<!-- <td>ID</td> -->
							<td colspan="2">院系名称</td>
							<td colspan="7">描述</td>
							<td colspan="2">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="faculty" items="${datas }" varStatus="status">
							<tr>
								<td>${pageNo*10+status.index+1 }</td>
								<%-- <td>${faculty.id }</td> --%>
								<td colspan="2"><strong class="text-success">${faculty.name }</strong></td>
								<td colspan="7">${faculty.description }</td>
								<td colspan="2" ><a href="#" class="text-info list-div pull-left"
									onclick="update(${faculty.id})">修改</a> <a href="#"
									class="text-danger list-div pull-left margin-left-5"
									onclick="deleteItem(${faculty.id})">删除</a></td>
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
						href="${pageContext.request.contextPath }/admin/ui-faculty?pageNo=${pageNo-1}">上一页</a>
					</li>
				</c:if>
				<c:if test="${(pageNo+1)*10<count }">
					<li><a
						href="${pageContext.request.contextPath }/admin/ui-faculty?pageNo=${pageNo+1}">下一页</a>
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
              title: '修改院系',
              type: 2,
              area: ['480px', '500px'],
              content: '${pageContext.request.contextPath}/admin/ui-faculty-update/' + id,
              end: function() {
                  window.location.reload();
               }
            }); 
        }
        // 删除
        function deleteItem(id) {
        	layer.confirm('确定要删除吗？', function(index){
       		$.ajax({
                url: '${pageContext.request.contextPath}/admin/faculty/' + id,
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
            title: '添加权限',
            type: 2,
            area: ['480px', '500px'],
            content: '${pageContext.request.contextPath}/admin/ui-faculty-add',
            end: function() {
                window.location.reload();
             }
          }); 
        }
        
    </script>

</html>