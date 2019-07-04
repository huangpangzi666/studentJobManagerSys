<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">

    <head>
        <meta charset="UTF-8">
        <title>老师管理</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body>
         <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
            <article class="show">
                <header>
                    <form id="form" action="${pageContext.request.contextPath }/admin/ui-teacher">
                        <div class="row">
                            <div class="col-xs-8">
                                <div class="form-group">
                                  <label class="control-label" for="inputSuccess3">姓名查询</label>
                                  <input type="text" name="name" value="${datas.name }" class="form-control" id="inputSuccess3" aria-describedby="helpBlock2">
                                </div>
                            </div>
                            <div class="col-xs-4">
                                <button type="submit" class="btn btn-default btn-block" style="margin-top: 25px;">检索</button>
                            </div>
                        </div>
                    </form>
                    <button type="button" class="btn btn-default" onclick="add()">添加教师</button>
                </header>
                <footer class="tags">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <td>序号</td>
                                <td>工号</td>
                                <td>姓名</td>
                                <td>性别</td>
                                <td>电话</td>
                                <td>邮件</td>
                                <td>上次登录</td>
                                <td>状态</td>
                                <td>操作</td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${datas.vo }" var="vo" varStatus="status">
	                            <tr>
	                                <td>${pageNo*10+status.index+1 }</td>
	                                <td>${vo.id }</td>
	                                <td><strong class="text-success">${vo.name }</strong></td>
	                                <td>
	                                    <c:if test="${vo.sex eq true }">男</c:if>
                                         <c:if test="${vo.sex eq false }"> 女 </c:if>
                                    </td>
	                                <td>${vo.phone }</td>
	                                <td>${vo.email }</td>
	                                <td><span class="text-success"><fmt:formatDate value="${vo.login.lastLoginTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </span></td>
	                                <td>
	                                     <c:if test="${vo.login.status eq true }">
	                                       <span class="text-success">正常使用</span>
	                                     </c:if>
	                                     <c:if test="${vo.login.status eq false }">
                                           <span class="text-danger">禁止登陆</span>
                                         </c:if>
	                                </td>
	                               <td colspan="2" >
	                                   <c:if test="${vo.login.status eq true }">
                                            <a href="#" class="text-info list-div pull-left"
                                                onclick="update('${vo.login.id}', '0')">禁用</a>
                                         </c:if>
                                         <c:if test="${vo.login.status eq false }">
                                           <a href="#" class="text-info list-div pull-left"
                                                onclick="update('${vo.login.id}', '1')">恢复</a>
                                         </c:if>
	                               <a href="#"
                                    class="text-danger list-div pull-left margin-left-5"
                                    onclick="deleteItem(${vo.id})">删除</a></td>
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
                        href="${pageContext.request.contextPath }/admin/ui-teacher?pageNo=${pageNo-1}&name=${datas.name}">上一页</a>
                    </li>
                </c:if>
                <c:if test="${(pageNo+1)*10<count }">
                    <li><a
                        href="${pageContext.request.contextPath }/admin/ui-teacher?pageNo=${pageNo+1}&name=${datas.name}">下一页</a>
                    </li>
                </c:if>
            </ul>
            </nav>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
 // 更新
    function update(id, status) {
    	layer.confirm('确定要修改吗？', function(index){
            $.ajax({
              url: '${pageContext.request.contextPath}/auth/status',
              type: 'put',
              data: {
            	  id: id,
            	  status: status
              },
              async: false,
              dataType: 'json',
              success: function(result) {
                  if (result.status == 'SUCCESS') {
                      layer.alert('修改成功', function(ind){
                          layer.close(index); //再执行关闭
                          window.location.reload();
                      });  
                  } else {
                      layer.alert('修改失败，请重试');  
                  }
              }       
            });
            
          });
    }
    // 删除
    function deleteItem(id) {
        layer.confirm('确定要删除吗？', function(index){
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/teacher/' + id,
            type: 'delete',
            dataType: 'json',
            success: function(result) {
                if (result.status == 'SUCCESS') {
                    layer.alert('删除成功', function(){
                    	 layer.close(index);
                    	 window.location.reload();
                    });  
                } else {
                    layer.alert('删除失败，请重试');  
                }
            }       
          });
        });
    }
    // 添加
    function add() {
      layer.open({
        title: '添加教师',
        type: 2,
        area: ['480px', '710px'],
        content: '${pageContext.request.contextPath}/admin/ui-teacher-add',
        end: function() {
            window.location.reload();
         }
      }); 
    }
    </script>

</html>