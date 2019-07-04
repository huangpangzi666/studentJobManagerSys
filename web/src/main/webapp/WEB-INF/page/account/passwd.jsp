<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <title>修改密码</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    </head>
    <body>
        <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
            <form class="form-horizontal center-top" action="${pageContext.request.contextPath }/user/passwd" id="form">
        <div class="form-group">
            <label for="input1" class="col-sm-2 control-label">原密码</label>
            <div class="col-sm-9">
                <input type="password" name="oldPasswd" class="form-control" id="input2">
            </div>
        </div>
        <div class="form-group">
            <label for="input2" class="col-sm-2 control-label">新密码</label>
            <div class="col-sm-9">
                <input type="password" name="newPasswd" class="form-control" id="input3" >
            </div>
        </div>
        <div class="form-group">
            <label for="input3" class="col-sm-2 control-label">确认密码</label>
            <div class="col-sm-9">
                <input type="password" name="renewPasswd" class="form-control" id="input4" placeholder="再次输入新密码">
            </div>
        </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-9">
                        <button type="submit" class="btn btn-info">修改</button>
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
//校验
  $(document).ready(function() {
      $(form).bootstrapValidator({
          feedbackIcons: {
              valid: 'glyphicon glyphicon-ok',
              invalid: 'glyphicon glyphicon-remove',
              validating: 'glyphicon glyphicon-refresh'
          },
          fields: {
        	  'oldPasswd': {
                  validators: {
                      notEmpty: {
                          message: '密码不能为空'
                      },
                      stringLength: {
                          min: 6,
                          max: 24,
                          message: '密码长度为6 ~ 24位'
                      }
                  }
              },
              'newPasswd': {
                  message: '密码无效',
                  validators: {
                      notEmpty: {
                          message: '密码不能为空'
                      },
                      stringLength: {
                          min: 6,
                          max: 24,
                          message: '密码长度为6 ~ 24位'
                      }
                  }
              },
              'renewPasswd': {
            	  identical: {
                      field: 'newPasswd',
                      message: '确认密码与新密码不一致！'
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

          if ($.trim($("#input2").val()) == $.trim($("#input3").val())) {
        	  layer.alert("原始密码不能与新密码一致!");
        	  return;
          }
          // Use Ajax to submit form data
          $.ajax({
              url: $form.attr('action'),
              type: 'put',
              data: {
                  oldPasswd: $.trim($("#input2").val()),
                  newPasswd: $.trim($("#input3").val())
              },
              dataType: 'json',
              success: function(result) {
                  if (result.status == 'SUCCESS') {
                      layer.alert('密码修改成功,请重新登录', function() {
	                      window.location.href = '${pageContext.request.contextPath}/index';
                      })
                  } else {
                      layer.alert('密码修改失败');  
                  }
              }
           });
      });
  });
  </script>
</html>
