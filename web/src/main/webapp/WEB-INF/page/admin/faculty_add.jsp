<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>添加院系</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/faculty" id="form" style="width: 100% !important;">
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">名称</label>
              <input type="text" name="name" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2" onchange="able(this)">
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess2">描述</label>
              <textarea name="description" class="form-control" id="inputSuccess2" aria-describedby="helpBlock2" rows="5"></textarea>
            </div>
            <button type="submit" class="btn btn-info btn-block">添加</button>
        </form>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        var isable = false;
	    function able(item) {
	    	$.get(
	    		"${pageContext.request.contextPath}/admin/faculty/api-isable",
	    		{name: $(item).val()},
	    		function (result) {
	    			if (result.status == "SUCCESS") {
	    				isable = true;
	    				layer.alert("名称可用")
	    			} else {
	    				isable = false;
	    				layer.alert("名称不可用，请重新输入")
	    			}
	    		},
	    		"json"
	    	);
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
                    'description': {
                        validators: {
                            notEmpty: {
                                message: '不能为空'
                            },
                            stringLength: {
                                min: 1,
                                max: 255,
                                message: '长度为1 ~ 255字符'
                            }
                        }
                    }
                }
            }).on('success.form.bv', function(e) {
                // Prevent form submission
                e.preventDefault();
                
                if (!isable) {
                	layer.alert("名称重复");
                	return;
                }
                
                // Get the form instance
                var $form = $(e.target);

                // Get the BootstrapValidator instance
                var bv = $form.data('bootstrapValidator');

                // Use Ajax to submit form data
                $.post($form.attr('action'), $form.serialize(), function(result) {
                   if (result.status == 'SUCCESS') {
                	   layer.alert('添加成功', function(index){
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