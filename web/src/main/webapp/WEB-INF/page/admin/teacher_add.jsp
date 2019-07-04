<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>添加教师</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/teacher" id="form" style="width: 100% !important;">
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">工号</label>
              <input type="text"  class="form-control" id="inputSuccess1" aria-describedby="helpBlock2" value="注册成功后自动获取"  disabled>
            </div>
            <div class="form-group"> 
              <label class="control-label" for="inputSuccess6">角色</label>
              <input type="text"  class="form-control" id="inputSuccess6" aria-describedby="helpBlock2" value="${role.name }"  readonly>
              <input type="hidden" name="login.roleId" value="${role.id }">
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess4">姓名</label>
              <input type="text" name="name" class="form-control" id="inputSuccess4" aria-describedby="helpBlock2">
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess2">密码</label>
              <input type="password" name="login.password" class="form-control" id="inputSuccess2" aria-describedby="helpBlock2">
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess7">电子邮箱</label>
              <input type="email" name="email" class="form-control" id="inputSuccess7" aria-describedby="helpBlock2">
            </div>
            <div class="form-group">
	          <label class="control-label" for="inputSuccess5">性别</label>
			  <label class="radio-inline">
			    <input type="radio" name="sex" id="optionsRadios1" value="1" checked>
			   男
			  </label>
			   <label class="radio-inline">
                   <input type="radio" name="sex" id="optionsRadios2" value="0">
                           女
                 </label>
			</div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess3">手机</label>
              <input type="text" name="phone" class="form-control" id="inputSuccess3" aria-describedby="helpBlock2">
            </div>
            <button type="submit" class="btn btn-info btn-block">添加</button>
        </form>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
     <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        // 校验
        $(document).ready(function() {
            $(form).bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    'name': {
                        validators: {
                            notEmpty: {
                                message: '姓名不能为空'
                            },
                            stringLength: {
                                min: 2,
                                max: 8,
                                message: '长度为2 ~ 8位'
                            },
                            regexp: {
                                regexp: /^[^\x00-\xff]+$/,
                                message: '字符限制：中文汉字'
                           }
                        }
                    },
                    'login.password': {
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
                    'phone': {
                        message: '电话无效',
                        validators: {
                            notEmpty: {
                                message: '手机号码不能为空'
                            },
                            stringLength: {
                                min: 11,
                                max: 11,
                                message: '长度为11位'
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
                            },
                            remote: {
                              url: '${pageContext.request.contextPath}/api-email-able',
                              message:"此邮箱已经注册",
                              type: "get",
                              dataType: 'json',
                              data: {
                            	  email: $('#inputSuccess7').val(),
                            	  flag: false
                              },
                              delay: 1000,//延迟效果
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

                // Use Ajax to submit form data
                $.post($form.attr('action'), $form.serialize(), function(result) {
                	if (result.status == 'SUCCESS') {
                        layer.alert('添加成功,您的工号为<br><p class="text-danger text-center">'+result.uid+'</p>', function(index){
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭   
                        });  
                    } else {
                        layer.alert('添加失败，请重试');  
                    }
                }, 'json');
            });
        });
    </script>

</html>