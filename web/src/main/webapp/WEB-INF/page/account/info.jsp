<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <title>个人信息</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    </head>
    <body>
         <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
            <form class="form-horizontal center-top " action="${pageContext.request.contextPath }/user/info" id="form">
        <div class="form-group">
            <label for="input1" class="col-sm-2 control-label">用户</label>
            <div class="col-sm-9">
	            <shiro:hasRole name="学生">
	                <input type="text" name="id" value="${login.userId }" class="form-control" id="input1" disabled="">
	            </shiro:hasRole>
	            <shiro:hasRole name="教师">
	                <input type="text" name="id" value="${login.userId }" class="form-control" id="input1" disabled="">
	            </shiro:hasRole>
            </div>
        </div>
        <div class="form-group">
            <label for="input2" class="col-sm-2 control-label">姓名</label>
            <div class="col-sm-9">
                <shiro:hasRole name="学生">
                    <input type="text" value="${login.student.name }" class="form-control" id="input2" disabled="">
                </shiro:hasRole>
                <shiro:hasRole name="教师">
                    <input type="text" value="${login.teacher.name }" class="form-control" id="input2" disabled="">
                </shiro:hasRole>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">性别</label>
            <div class="col-sm-9">
                <shiro:hasRole name="学生">
                    <c:if test="${login.student.sex eq true }">
	                    <label class="radio-inline">
	                      <input type="radio" name="sex"  value="1" checked> 男
	                    </label>
	                    <label class="radio-inline">
	                      <input type="radio" name="sex"  value="0"> 女
	                    </label>
                    </c:if>
                    <c:if test="${login.student.sex eq false }">
                        <label class="radio-inline">
                          <input type="radio" name="sex"  value="1" > 男
                        </label>
                        <label class="radio-inline">
                          <input type="radio" name="sex"  value="0" checked> 女
                        </label>
                    </c:if>
                </shiro:hasRole>
                <shiro:hasRole name="教师">
                    <c:if test="${login.teacher.sex eq true }">
	                   <label class="radio-inline">
		                  <input type="radio" name="sex"  value="1" checked> 男
		                </label>
		                <label class="radio-inline">
		                  <input type="radio" name="sex" value="0"> 女
		                </label>
		            </c:if>
                    <c:if test="${login.teacher.sex eq false }">
	                   <label class="radio-inline">
		                  <input type="radio" name="sex" value="1"> 男
		                </label>
		                <label class="radio-inline">
		                  <input type="radio" name="sex"  value="0" checked> 女
		                </label>
		            </c:if>
                </shiro:hasRole>
            </div>
        </div>
        <div class="form-group">
            <label for="input3" class="col-sm-2 control-label">电话</label>
            <div class="col-sm-9">
                <shiro:hasRole name="学生">
	                <input type="text" name="phone" maxlength="11" class="form-control" id="input3" value="${login.student.phone }"/>
                </shiro:hasRole>
                <shiro:hasRole name="教师">
	                <input type="text" name="phone" maxlength="11" class="form-control" id="input3" value="${login.teacher.phone }"/>
                </shiro:hasRole>
            </div>
        </div>
        <div class="form-group">
            <label for="input4" class="col-sm-2 control-label">邮件</label>
            <div class="col-sm-9">
                <shiro:hasRole name="学生">
	                <input type="email" name="email" class="form-control" id="input4" value="${login.student.email }" />
                </shiro:hasRole>
                <shiro:hasRole name="教师">
	                <input type="email" name="eamil" class="form-control" id="input4" value="${login.teacher.email }" />
                </shiro:hasRole>
            </div>
        </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-9">
                        <button type="submit" class="btn btn-info">更新修改</button>
                    </div>
                </div>
            </form>
        </div>
    </body>
  <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
   <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
  var phone = $.trim($("#input3").val()),
	  email = $.trim($("#input4").val()),
	  sex = $("input:radio:checked").val(),
	  formData = {},
	  enable = true;
  // 校验
  $(document).ready(function() {
      $(form).bootstrapValidator({
          feedbackIcons: {
              invalid: 'glyphicon glyphicon-remove',
              validating: 'glyphicon glyphicon-refresh'
          },
          fields: {
              'name': {
                  validators: {
                      notEmpty: {
                          message: '不能为空'
                      },
                      stringLength: {
                          min: 2,
                          max: 64,
                          message: '长度为2 ~ 64位'
                      },
                      regexp: {
                          regexp: /^[^\x00-\xff]+$/,
                          message: '字符限制：中文汉字'
                     }
                  }
              },
              'phone': {
                   validators: {
                       notEmpty: {
                           message: '不能为空'
                       },
                       stringLength: {
                           min: 11,
                           max: 11,
                           message: '11位电话号码'
                       },
                       regexp: {
                           regexp: /^[1-9][0-9]+$/,
                           message: '请输入数字'
                      }
                   }
              },
              'email': {
                  validators: {
                	  notEmpty: {
                          message: '邮件不能为空'
                      },
                      emailAddress: {
                          message: '邮箱地址格式有误'
                      }
                  }
             },
             'sex': {
                 validators: {
                     notEmpty: {
                         message: '不能为空'
                     }
                 }
            }
          }
      }).on('success.form.bv', function(e) {
          // Prevent form submission
          e.preventDefault();
          
          // Get the form instance
          var $form = $(e.target);

          // Get the BootstrapValidator instance
          var bv = $form.data('bootstrapValidator');
          
       // 校验数据 start
          var enbale = false;
          if (phone != $("#input3").val()) {
              formData.phone = $("#input3").val();
          }
          if (email != $("#input4").val()) {
              isStudent = ${login.userId} > 9999 ? true:false;
              function showClass(){
                  $.get(
                	'${pageContext.request.contextPath}/api-email-able',
                	{
                		name: $('#inputSuccess7').val(),
                        flag: isStudent
                	},
                     function (result) {
                		   if (result.valid == true) {
                			   formData.email = $("#input4").val();
                			   enable = true;
                		   } else {
                			   enable = false;
                		   }
                	},
                     "json"
                 );
              }
          }
          if (enable == false) {
        	  layer.alert("邮箱已被注册,请重新输入");
        	  return;
          }
          if (sex != $("input:radio:checked").val()) {
              formData.sex = $("input:radio:checked").val();
          }
          if ( $.isEmptyObject(formData)) {
                layer.alert('未修改');  
              return;
          }
          formData.id = '${login.userId}';
          
          $.ajax({
              url: $form.attr('action'),
              type: 'put',
              data: formData,
              dataType: 'json',
              success: function(result) {
                  if (result.status == 'SUCCESS') {
                      layer.alert('修改成功', function() {
                    	  window.location.reload();
                      });  
                  } else {
                      layer.alert('修改失败，请重试');  
                  }
              }
           });
      });
  });
  </script>
</html>
