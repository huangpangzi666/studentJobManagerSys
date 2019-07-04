<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>添加角色</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/role" id="form" style="width: 100% !important;">
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">角色名称</label>
              <input type="text" name="role.name" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2">
            </div>
      <strong>选择权限</strong>
      <hr />
      <div class="form-group">
           <div class="row">
	        <c:forEach items="${permissions }" var="permission">
	           <div class="col-xs-4 col-sm-4 col-md-4">
		           <label>
		            <input type="checkbox" name="permissionids" value="${permission.id }">${permission.description }
		           </label>
	           </div>
	        </c:forEach>
           </div>
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
                                message: '不能为空'
                            },
                            stringLength: {
                                min: 2,
                                max: 32,
                                message: '长度为2~ 32位'
                            }
                        }
                    }
                }
            }).on('success.form.bv', function(e) {
                e.preventDefault();
                var $form = $(e.target);
                var bv = $form.data('bootstrapValidator');
                
                checkSize = $("input:checked").length;
                if (checkSize == 0) {
                	layer.alert("请选择至少一个权限", function(index) {
                		$(":submit").removeAttr("disabled");
                		 layer.close(index);
                	})
                	return;
                }
             // Use Ajax to submit form data
                $.post($form.attr('action'), $form.serialize(), function(result) {
                   if (result.status == 'SUCCESS') {
                       layer.alert('添加成功', function(index){
                           var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                           parent.layer.close(index); //再执行关闭   
                       });  
                   } else if (result.status == 'FAIL'){
                       layer.alert('角色名称重复！');  
                   } else {
                       layer.alert('添加失败，请重试');  
                   }
                }, 'json');
            });
        });
    </script>

</html>