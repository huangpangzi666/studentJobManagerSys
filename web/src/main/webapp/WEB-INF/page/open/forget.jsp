<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

    <head>
        <meta charset="UTF-8">
        <title>找回密码</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
        <style type="text/css">
             body {
                background-image: url('${pageContext.request.contextPath}/imgs/bg.jpg');
                background-position: center;
                background-size: cover;
                background-repeat: no-repeat;
            }
        </style>
    </head>

    <body id="top_logo">
        <div class="container ">
            <div class="content-center">
            <form id="form" action="${pageContext.request.contextPath }/newpass" >
                <div class="page-header">
                    <h1 class="text-center">找回密码</h1>
                </div>
                <div class="form-group">
                  <label class="control-label" for="inputSuccess2">用户名</label>
                  <input type="text" class="form-control" name="userId" placeholder="用户的学号/工号" id="inputSuccess2" aria-describedby="helpBlock2">
                </div>
                <div class="form-group">
                  <label class="control-label" for="inputSuccess1">邮箱地址<small class="text-danger">(若用户没有设置邮箱，请联系管理员)</small> </label>
                  <input type="text" class="form-control" name="email" placeholder="账户的邮箱" id="inputSuccess1" aria-describedby="helpBlock2">
                </div>
                <div class="row">
                    <div class="col-xs-8">
                        <div class="form-group">
                          <label class="control-label" for="inputSuccess3">更密验证码</label>
                          <input type="text" name="vaild" placeholder="输入发送至邮箱的验证码" class="form-control" id="inputSuccess3" aria-describedby="helpBlock2">
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <button type="button" class="btn btn-default btn-block" style="margin-top: 25px;" onclick="sendEmailCode()" id="activieCode">获取验证码</button>
                    </div>
                </div>
                <button type="submit" class="btn btn-info btn-block">获取新密码</button>
            </form>
            </div>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
    // 获取验证码
    function isEmail(str) {
       var reg = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g;
       return reg.test(str);
     }
    var endCount = -1;
        function timedCount()
        {
           $("#activieCode").text("("+ endCount + "s) 重发");
            endCount = endCount - 1;
            t=setTimeout("timedCount()",1000);
            if (endCount < 0) {
                stopCount();
            }
        }
       
        function stopCount()
        {
           clearTimeout(t);
           $("#activieCode").removeAttr("disabled");
           $("#activieCode").text("获取验证码");
           $("#inputSuccess1").removeAttr("readOnly");
        }
    
        // 激活邮箱,获取验证码
        function sendEmailCode() {
            if (endCount >= 0) {
                return;
            }
            if (!isEmail($("#inputSuccess1").val())) {
                layer.alert('请输入合格的邮箱地址');   
                return;
            }
            emailStr = $("#inputSuccess1").val();
            $("#inputSuccess1").attr("readOnly", "readOnly");
            $("#activieCode").attr("disabled", "disabled");
            endCount = 120;
            timedCount();
            sendVaild();
        }
    function sendVaild() {
    	var userId = $("#inputSuccess2").val();
    	if ($.isEmptyObject($.trim(userId))) {
    		layer.alert("请先输入用户名");
    		endCount = -1;
    		return;
    	}
    	$.ajax({
    		url: "${pageContext.request.contextPath}/comm/email",
            type: 'get',
            data:  {
                email: $("#inputSuccess1").val(),
                type: 1
            },
            async: false,
            dataType: 'json',
            success: function(result) {
                if (result.status == 'SUCCESS') {
                    layer.alert('邮件下发成功,请<span class="text-danger">复制验证码</span>获取新密码<p>如若未收到邮件,请查看是否被视为垃圾邮件放入垃圾回收站中</p>');
                } else {
                    layer.alert("邮件下发失败,请稍后重试");
                }
            }
    	})
    }
        // 校验
        $(document).ready(function() {
            $(form).bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                	'userId': {
                		 validators: {
                             notEmpty: {
                                 message: '不能为空'
                             }
                		 }
                	},
                    'email': {
                        message: '邮箱无效',
                        validators: {
                            notEmpty: {
                                message: '邮箱不能为空'
                            },
                            emailAddress: {
                                message: '请输入有效的邮箱格式'
                            }
                        }
                    },
                    'vaild': {
                        message: '验证码无效',
                        validators: {
                            notEmpty: {
                                message: '验证码不能为空'
                            },
                            stringLength: {
                                min: 36,
                                max: 36,
                                message: '请输入有效的验证码'
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
                $.ajax({
                    url: $form.attr('action'),
                    type: 'put',
                    data: $form.serialize(),
                    dataType: 'json',
                    async: false,
                    success: function(result) {
                        if (result.status == 'SUCCESS') {
                            layer.alert('密码重置成功<br/>新密码:<span class="text-success">'+ result.msg+'</span><p class="text-danger">该密码仅出现一次，请及时登录进行修改密码操作</p>', function() {
                            	window.location.href = "${pageContext.request.contextPath}/login";
                            });  
                        } else {
                            layer.alert(result.msg);  
                        }
                    }
                 });
            });
        });
    </script>

</html>