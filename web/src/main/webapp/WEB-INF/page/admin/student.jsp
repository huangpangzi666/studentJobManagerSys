<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
<meta charset="UTF-8">
<title>学生管理</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bwx/css/base.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
</head>

<body>
	<jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
	<div class="main">
		<article class="show">
			<header>
				<button type="button" class="btn btn-default margin-left-5"
					onclick="add()">添加学生</button>
				<button type="button" class="btn btn-default"
					onclick="importStudent()">EXCEL导入</button>
				<button type="button"
					class="btn btn-group navbar-right margin-left-5 btn-info"
					onclick="clearConditinal()">清除条件</button>
				<div class="btn-group navbar-right margin-left-5">
					<button type="button" class="btn btn-default dropdown-toggle"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						选择班级 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu dropdown-menu-height" id="cls">
					</ul>
				</div>
				<div class="btn-group navbar-right margin-left-5">
					<button type="button" class="btn btn-default dropdown-toggle"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						选择专业 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" id="major">
					</ul>
				</div>
				<div class="btn-group navbar-right margin-left-5">
					<button type="button" class="btn btn-default dropdown-toggle"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						选择院系 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" id="faculty">
						<li><a href="javascript:;"
							data-url="${pageContext.request.contextPath }/admin/api-student-list">不选择</a></li>
						<c:forEach var="faculty" items="${datas }" varStatus="status">
							<c:if test="${status.index % 3 eq 0 }">
								<li role="separator" class="divider"></li>
							</c:if>
							<li><a href="javascript:;"
								data-url="${pageContext.request.contextPath }/admin/api-student-list?fId=${faculty.id}"
								data-id="${faculty.id }">${faculty.name}</a></li>
						</c:forEach>
					</ul>
				</div>
				<div class="btn-group navbar-right margin-left-5">
					<input type="text" name="name" placeholder="请输入姓名筛选"
						class="form-control" id="inputSuccess3"
						aria-describedby="helpBlock2" onchange="changeName(this)">
				</div>
			</header>
			<footer class="tags">
				<table class="table table-hover">
					<thead>
						<tr>
							<td>序号</td>
							<td>学号</td>
							<td>姓名</td>
							<td>性别</td>
							<td>所属班级</td>
							<td>电话</td>
							<td>邮件</td>
							<td>上次登录</td>
							<td>状态</td>
							<td>操作</td>
						</tr>
					</thead>
					<tbody id="tBody">
					</tbody>
				</table>
			</footer>
			<p class="text-danger" align="center" id="count"></p>
		</article>

		<nav aria-label="...">
			<ul class="pager" id="page">
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
<script
	src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js"
	type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    // 筛选name的条件
    var nameLike;
    // 用于刷新用的请求条件
     var sURL = "";
    // 当前页
    var nowPage;
    // 当前请求条件总计数
    var nowCount;
    function changeName(obj) {
	   nameLike = $.trim($(obj).val());
	   apiDatas("${pageContext.request.contextPath }/admin/api-student-list");
   }
    function clearConditinal() {
    	nameLike = "";
    	$("#inputSuccess3").val("");
    	 apiDatas("${pageContext.request.contextPath }/admin/api-student-list");
    }
    /*  ajax获取数据 */
   
    function apiDatas(url) {
    	$.get(
          url,
          {
        	  name: nameLike
          },
          function (result) {
        	  var str = "";
        	  var body = $("#tBody");
        	  $("tbody").empty();
             $.each(result.students, function(index, res) {
            	str = "";
				str += '<tr><td>' + (result.pageNo*10+index+1) + '</td>';
				str += '<td>'+res.id+'</td>';
				str += '<td><strong class="text-success">'+ res.name +'</strong></td>';
				str += '<td>';
				if (res.sex == true) {
					str += "男";
				} else if (res.sex == false) {
					str += "女";
				}
				str += '</td>';
				str += '<td>'+ res.className +'</td>';
				if (res.phone == null) {
					str += '<td></td>';
				} else {
					str += '<td>'+ res.phone +'</td>';
				}
				if (res.email == null) {
					str += '<td></td>';
				} else {
					str += '<td>'+ res.email +'</td>';
				}
				if (res.login.lastLoginTime == null) {
					str += '<td><span class="text-success"></span></td>';
				} else {
				    str += '<td><span class="text-success">'+ res.login.lastLoginTime+'</span></td>';
				}
				str += '<td>';
				if (res.login.status == true) {
				    str += '<span class="text-success">正常使用</span>';
				} else if (res.login.status == false) {
				    str += '<span class="text-danger">禁止登陆</span>';
				}
				str += '</td>';
				str += '<td colspan="2" >';
				str += '<a href="#" class="text-success list-div pull-left" onclick="updateItem('+ res.id +',\''+ res.name +'\',\''+ res.classId+'\')">修改</a>';
				if (res.login.status == true) {
				    str += '<a href="#" class="text-info list-div pull-left  margin-left-5" onclick="update('+ res.login.id +', '+ 0 +')">禁用</a>';
				} else if (res.login.status == false) {
				    str += '<a href="#" class="text-info list-div pull-left  margin-left-5" onclick="update('+ res.login.id +', '+ 1 +')">恢复</a>';
				}
				str += '<a href="#" class="text-danger list-div pull-left margin-left-5" onclick="deleteItem('+ res.id +')">删除</a></td></tr>';
				
				$(body).append(str);
             })
             $("#count").html("总记录数：" +result.count);
             var page = $("#page");
             var pageStr = "";
            
             if (result.fId != null || result.fId != undefined) {
            	 sURL += "&fId="+result.fId;
             } else if (result.mId != null || result.mId != undefined) {
            	 sURL += "&mId="+result.mId;
             } else if (result.cId != null || result.cId != undefined) {
            	 sURL += "&cId="+result.cId;
             }
             if (result.pageNo > 0) {
            	 requestS = "${pageContext.request.contextPath }/admin/api-student-list?pageNo="+ (result.pageNo-1) + sURL;
            	 pageStr +='<li><a href="javascript:;" onclick="changePage(\''+ requestS +'\') ">上一页</a></li>';
             }
             if ((result.pageNo+1)*10<result.count){
            	 requestS = "${pageContext.request.contextPath }/admin/api-student-list?pageNo="+ (result.pageNo+1) + sURL;
            	 pageStr +='<li><a href="javascript:;" onclick="changePage(\''+ requestS +'\') ">下一页</a></li>';
             }
             nowPage = result.pageNo;
             nowCount = result.count;
             $(page).html(pageStr);
          },
          "json"
      );
    }
    var frist = true;
    if (frist) {
        apiDatas("${pageContext.request.contextPath }/admin/api-student-list");
    	frist = false;
    }
    function changePage(url) {
    	apiDatas(url);
    }
    // 选择院系事件
    $("#faculty li a").click(function() {
    	var ul = $("#major");
    	var id = $(this).attr("data-id"),
    	    url = $(this).attr("data-url");
    	apiDatas(url);

        $(ul).empty();
        $("#cls").empty();
    	if (jQuery.isEmptyObject(id)) {
    		return;
    	}
    	$.get(
           "${pageContext.request.contextPath}/admin/major/api-faculty/" + id,
           function (result) {
               $(ul).append('<li><a href="javascript:;" data-url="${pageContext.request.contextPath }/admin/api-student-list?fId='+id+'" >不选择</a></li>');
               $.each(result, function(index, item) {
                   $(ul).append('<li><a href="javascript:;" data-url="${pageContext.request.contextPath }/admin/api-student-list?mId='+item.id+ '" data-id="'+item.id+'">'+item.name+'</a></li>');
               })
               activeMajor();
           },
           "json"
       );
    });
    // 选择专业事件
    function activeMajor() {
	    $("#major li a").click(function() {
	    	var id = $(this).attr("data-id"),
	    	    url = $(this).attr("data-url");
	    	apiDatas(url);
	    	
	    	 var ul = $("#cls");
	         $(ul).empty();
	    	if (jQuery.isEmptyObject(id)) {
	            return;
	        }
	    	$.get(
	           "${pageContext.request.contextPath}/admin/class/api-major/" + id,
	           function (result) {
	               $(ul).append('<li><a href="javascript:;" data-url="${pageContext.request.contextPath }/admin/api-student-list?mId='+id+'">不选择</a></li>');
	               $.each(result, function(index, item) {
	                   $(ul).append('<li><a href="javascript:;" data-url="${pageContext.request.contextPath }/admin/api-student-list?cId='+item.id+'">'+item.year+item.name+'</a></li>');
	               })
	               activeCls();
	           },
	           "json"
	       );
	    });
    }
    // 选择班级
   function activeCls() {
	   $("#cls li a").click(function(){
           var url = $(this).attr("data-url");
           apiDatas(url);
       });
    }
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
	            url: '${pageContext.request.contextPath}/admin/student/' + id,
	            type: 'delete',
	            dataType: 'json',
	            success: function(result) {
	                if (result.status == 'SUCCESS') {
	                    layer.alert('删除成功', function(index){
	                    	var page = nowPage;
	                        if ((nowPage + 1 ) * 10 - nowCount == 9) {
	                            page = nowPage - 1;
	                            page = page < 0 ? 0 : page;
	                        }
	                        var reload = "${pageContext.request.contextPath }/admin/api-student-list?pageNo=" + page + sURL;
	                        apiDatas(reload);
	                        layer.close(index);
	                    });  
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
        title: '添加学生',
        type: 2,
        area: ['480px', '610px'],
        content: '${pageContext.request.contextPath}/admin/ui-student-add',
        end: function() {
            window.location.reload();
         }
      });
    }
    // 添加
    function updateItem(id, name, classId) {
      layer.open({
        title: '修改学生',
        type: 2,
        area: ['480px', '580px'],
        content: '${pageContext.request.contextPath}/admin/ui-student-update/' + id + '?name=' + name + '&classId=' + classId,
        end: function() {
            window.location.reload();
         }
      });
    }
      // Excel导入student
    function importStudent() {
      layer.open({
        title: 'Excel一件导入学生信息',
        type: 2,
        area: ['480px', '320px'],
        content: '${pageContext.request.contextPath}/admin/ui-student-import',
        end: function() {
        	 window.location.reload();
         }
      }); 
    }
    </script>

</html>