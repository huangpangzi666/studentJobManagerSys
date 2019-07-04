<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>修改权限资源</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/permission" id="form" style="width: 100% !important;">
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">权限码</label>
              <input type="text" value="${permission.url }" name="url" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2">
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess2">描述</label>
              <textarea name="description" class="form-control" id="inputSuccess2" aria-describedby="helpBlock2" rows="5">${permission.description }</textarea>
            </div>
            <button type="submit" class="btn btn-info btn-block">确认修改</button>
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
                    'url': {
                        validators: {
                            notEmpty: {
                                message: '不能为空'
                            },
                            stringLength: {
                                min: 1,
                                max: 255,
                                message: '长度为1 ~ 255位'
                            }
                        }
                    },
                    'description': {
                        validators: {
                            notEmpty: {
                                message: '不能为空'
                            },
                            stringLength: {
                                min: 1,
                                max: 255,
                                message: '长度为1 ~ 255位'
                            }
                        }
                    }
                }
            }).on('success.form.bv', function(e) {
                e.preventDefault();
                var $form = $(e.target);
                var bv = $form.data('bootstrapValidator');
                // 校验数据 start
                var url = $.trim($("#inputSuccess1").val()),
                    description = $.trim($("#inputSuccess2").val()),
                    formData = {};
                if (url != "${permission.url}") {
                	formData.url = url;
                }
                if (description != '${permission.description}') {
                	formData.description = description;
                }
                if ($.isEmptyObject(formData)) {
                	  layer.alert('未修改');  
                	return;
                }
                formData.id = '${permission.id}';
                // end
                 $.ajax({
                   url: $form.attr('action'),
                   type: 'put',
                   data: formData,
                   dataType: 'json',
                   success: function(result) {
                	   if (result.status == 'SUCCESS') {
                           layer.alert('修改成功', function(){
                               var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                               parent.layer.close(index); //再执行关闭   
                           });  
                       } else if (result.status == 'FAIL') {
                    	   layer.alert('url地址重复');  
                       } else {
                           layer.alert('修改失败，请重试');  
                       }
                   }
                });
            });
        });
    </script>

</html>