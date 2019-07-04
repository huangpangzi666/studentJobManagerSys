<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">

    <head>
        <meta charset="UTF-8">
        <title>角色管理</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    </head>

    <body>
        <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
            <article class="show">
                <header>
                    <button type="button" class="btn btn-default" onclick="addRole()">添加角色</button>
                </header>
                <footer class="tags">
                <c:forEach var="role" items="${datas }" varStatus="status">
                    <table class="table table-hover table-bordered margin-bottom-0">
                        <thead>
                            <tr>
                                <td>序号</td>
                                <td>ID</td>
                                <td>角色名称</td>
                                <td>角色类型</td>
                                <td>操作</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>${pageNo*10+status.index+1 }</td>
                                <td>${role.id }</td>
                                <td><span class="text-success">${role.name }</span></td>
                                <td>${role.type }</td>
                                <td><a href="#" class="text-info list-div pull-left"
                                    onclick="updateItem(${role.id})">修改</a> <a href="#"
                                    class="text-danger list-div pull-left margin-left-5"
                                    onclick="deleteItem(${role.id})">删除</a></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="panel panel-default">
                      <div class="panel-heading">权限</div>
                      <div class="panel-body">
                      <div class="row">
                        <c:forEach var="permission" items="${role.permissions }" varStatus="status">
                            <div class="col-xs-4 col-md-3 col-sm-4">
	                            <span class="margin-left-5">${permission.description}</span>
                            </div>
                        </c:forEach>
                         </div>
                      </div>
                    </div>
                 </c:forEach>
                </footer>
                <p class="text-danger" align="center">总记录数：${count }</p>
            </article>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        function updateItem(id) {
        	 layer.open({
                 title: '修改角色',
                 type: 2,
                 area: ['980px', '750px'],
                 content: '${pageContext.request.contextPath}/admin/ui-role-update/' + id,
                 end: function() {
                     window.location.reload();
                  }
               }); 
        }
        function deleteItem(id) {
        	layer.confirm('确定要删除吗？', function(index){
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/role/' + id,
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
        function addRole() {
        	layer.open({
              title: '添加角色',
              type: 2,
              area: ['980px', '750px'],
              content: '${pageContext.request.contextPath}/admin/ui-role-add',
              end: function() {
                  window.location.reload();
               }
            }); 
        }
        
    </script>

</html>