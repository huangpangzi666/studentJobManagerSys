<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

    <head>
        <meta charset="UTF-8">
        <title>用户注册</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <div class="container center-top">
            <form action="" id="form">
                <div class="page-header">
                    <h1 class="text-center">注册</h1>
                </div>
                <div class="form-group">
                  <label class="control-label" for="inputSuccess1">邮箱地址</label>
                  <input type="text" name="email" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2">
                </div>
                <div class="form-group">
                  <label class="control-label" for="inputSuccess2">账户密码</label>
                  <input type="password" name="password" class="form-control" id="inputSuccess2" aria-describedby="helpBlock2">
                </div>
                <div class="row">
                    <div class="col-xs-8">
                        <div class="form-group">
                          <label class="control-label" for="inputSuccess3">验证码</label>
                          <input type="text" name="vcode" class="form-control" id="inputSuccess3" aria-describedby="helpBlock2">
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <button type="button" class="btn btn-default btn-block" style="margin-top: 25px;">获取验证码</button>
                    </div>
                </div>
                <button type="submit" class="btn btn-info btn-block">注册</button>
            </form>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
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
                    'vcode': {
                        message: '验证码无效',
                        validators: {
                            notEmpty: {
                                message: '验证码不能为空'
                            },
                            stringLength: {
                                min: 32,
                                max: 32,
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
                $.post($form.attr('action'), $form.serialize(), function(result) {

                }, 'json');
            });
        });
    </script>

</html>