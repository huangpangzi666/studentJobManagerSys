<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
<meta charset="UTF-8">
<title>专业管理</title>
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
				<button type="button" class="btn btn-default" onclick="add()">添加专业</button>
				<div class="btn-group navbar-right">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	              选择院系 <span class="caret"></span>
	            </button>
	            <ul class="dropdown-menu">
	                <li><a href="${pageContext.request.contextPath }/admin/ui-major">不选择</a></li>

		            <c:forEach var="faculty" items="${datas.faculties }" varStatus="status">
		                <c:if test="${status.index % 3 eq 0 }">
		                  <li role="separator" class="divider"></li>
		                </c:if>
		                <li><a href="${pageContext.request.contextPath }/admin/ui-major?fid=${faculty.id}">${faculty.name}</a></li>
		            </c:forEach>
	            </ul>
	          </div>
			</header>
			<footer class="tags">
				<table class="table table-hover">
					<thead>
						<tr>
							<td>序号</td>
							<!-- <td>ID</td> -->
							<td>专业名称</td>
							<td>所属院系</td>
							<td>描述</td>
							<td>操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="vo" items="${datas.vo }" varStatus="status">
							<tr>
								<td>${pageNo*10+status.index+1 }</td>
								<%-- <td>${vo.major.id }</td> --%>
								<td><span class="text-success">${vo.major.name }</span></td>
								<td>${vo.facultyName }</td>
								<td>${vo.major.description }</td>
								<td><a href="#" class="text-info list-div pull-left"
									onclick="update(${vo.major.id})">修改</a> <a href="#"
									class="text-danger list-div pull-left margin-left-5"
									onclick="deleteItem(${vo.major.id})">删除</a></td>
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
						href="${pageContext.request.contextPath }/admin/ui-major?pageNo=${pageNo-1}&fid=${datas.fid}">上一页</a>
					</li>
				</c:if>
				<c:if test="${(pageNo+1)*10<count }">
					<li><a
						href="${pageContext.request.contextPath }/admin/ui-major?pageNo=${pageNo+1}&fid=${datas.fid}">下一页</a>
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
              title: '修改专业',
              type: 2,
              area: ['480px', '500px'],
              content: '${pageContext.request.contextPath}/admin/ui-major-update/' + id,
              end: function() {
                  window.location.reload();
               }
            }); 
        }
        // 删除
        function deleteItem(id) {
        	layer.confirm('确定要删除吗？', function(index){
       		$.ajax({
                url: '${pageContext.request.contextPath}/admin/major/' + id,
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
            title: '添加专业',
            type: 2,
            area: ['480px', '500px'],
            content: '${pageContext.request.contextPath}/admin/ui-major-add',
            end: function() {
                window.location.reload();
             }
          }); 
        }
        
    </script>

</html>