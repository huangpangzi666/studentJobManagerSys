<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

    <head>
        <meta charset="UTF-8">
        <title>用户登录</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css"/>
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
            <form id="form" action="${pageContext.request.contextPath }/login" method="post">
                <div class="page-header">
                    <h3 class="text-center text-primary">学生作业管理系统</h3>
			        <p>超级管理员账号: <span class="text-success">1000</span> 密<span class="text-success">123456</span></p>
			        <p>教师账户: <span class="text-success">1005</span> 密<span class="text-success">123456</span></p>
			        <p>学生账户: <span class="text-success">2019000000</span> 密<span class="text-success">123456</span></p>
			        <p class="text-info">其余学生教师账户登入管理员查看用户学号/工号,密码均123456</p>
                    <h1 class="text-center">登录</h1>
                </div>
                <div class="form-group">
                    <label class="control-label" for="inputSuccess1">学号/工号</label>
                    <input type="text" name="userId" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2">
                </div>
                <div class="form-group">
                    <label class="control-label" for="inputSuccess2">账户密码</label>
                    <input type="password" name="password" class="form-control" id="inputSuccess2" aria-describedby="helpBlock2">
                </div>
                 <div class="row">
                    <div class="col-xs-9">
                        <div class="form-group">
                          <label class="control-label" for="inputSuccess3">验证码</label>
                          <input type="text" name="validateCode" class="form-control" id="inputSuccess3" aria-describedby="helpBlock2">
                        </div>
                    </div>
                    <div class="col-xs-3">
                        <img src="${pageContext.request.contextPath }/comm/captcha-image" style="margin-top: 20px;" onclick="nextImg()" id="captch" />
                    </div>
                </div>
                <div class="row" style="margin-top: 30px;">
                    <div class="checkbox col-xs-5">
                        <label>
                        <input type="checkbox" name="rememberMe">记住我
                    </label>
                    </div>
                    <div class="col-xs-offset-4 col-xs-3">
                        <button type="submit" class="btn btn-block btn-info">登录</button>
                    </div>
                </div>
                <div class="form-group-lg list-a">
                    <a href="${pageContext.request.contextPath }/forget" class="text-danger right">忘记密码？</a>
                   <!--  <a href="regist.html" class="text-justify right">注册账号</a> -->
                </div>
            </form>
        </div>
        </div>
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
                  'username': {
                        message: '学号/工号无效',
                        validators: {
                            notEmpty: {
                                message: '学号/工号不能为空'
                            },
                            stringLength: {
                                min: 4,
                                max: 10,
                                message: '工号长度为4位，学号长度为10'
                            },
                            regexp: {
                                regexp: /^[1-9][0-9]{3,9}$/,
                                message: '请输入数字'
                           }
                        }
                   },
                  'password': {
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
                    'validateCode': {
                    	 validators: {
                             notEmpty: {
                                 message: '验证码不能为空'
                             },
                             regexp: {
                                 regexp: /^[0-9a-zA-z]{4}$/,
                                 message: '请输入四位验证码'
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
                    if (result.status == "SUCCESS") {
                    	window.location.href = "${pageContext.request.contextPath}" +result.uri;
                    } else  {
                	   layer.alert(result.msg, function(index){
                		   nextImg();
                           layer.close(index); //再执行关闭   
                       }); 
                   }
                }, 'json');
            });
        });
        function nextImg() {
        	$("#captch").attr("src", "${pageContext.request.contextPath }/comm/captcha-image?" + new Date());
        }
    </script>

</html>