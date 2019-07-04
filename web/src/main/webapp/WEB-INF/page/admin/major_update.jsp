<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>修改院系</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/major" id="form" style="width: 100% !important;">
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">名称</label>
              <input type="text" value="${datas.vo.major.name }" name="name" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2" onchange="able(this)">
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess3">所属院系</label>
              <select name="facultyId" class="form-control" id="inputSuccess3" >
                <c:forEach var="faculty" items="${datas.faculties }" varStatus="status">
                  <c:if test="${faculty.id eq datas.vo.major.facultyId }">
                    <option value="${faculty.id }" selected="selected">${faculty.name }</option>
                  </c:if>
                  <c:if test="${faculty.id ne datas.vo.major.facultyId }">
                    <option value="${faculty.id }">${faculty.name }</option>
                  </c:if>
                </c:forEach>
                </select>
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess2">描述</label>
              <textarea name="description" class="form-control" id="inputSuccess2" aria-describedby="helpBlock2" rows="5">${datas.vo.major.description }</textarea>
            </div>
            <button type="submit" class="btn btn-info btn-block">确认修改</button>
        </form>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
       <!-- 判断name是否已经存在，即可用 -->
       var isable = true;
	    function able(value) {
	    	$.get(
	    		"${pageContext.request.contextPath }/admin/major/api-isable",
	    		{name: $(value).val()},
	    		function(result) {
	    			 if (result.status == 'SUCCESS') {
	    				 isable = true;
	    				 layer.alert("名称可用")
	    			 } else {
	    				 if ($.trim($("#inputSuccess1").val()) != "${datas.vo.major.name}") {
	    					 layer.alert("名称不可用，请重新输入");
	    					 isable = false;
	    				 } else {
	    					 isable = true;
	    				 }
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
                                min: 1,
                                max: 255,
                                message: '长度为1 ~ 255位'
                            },
                            regexp: {
                            	 regexp: /^[^\x00-\xff]+$/,
                                message: '字符限制：字母 - /'
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
                var name = $.trim($("#inputSuccess1").val()),
                    facultyId = $("#inputSuccess3").val(),
                    description = $.trim($("#inputSuccess2").val()),
                    formData = {};
                if (!isable) {
                    layer.alert('名称重复');  
                    return;
                }
                
                if (name != "${datas.vo.major.name}") {
                	formData.name = name;
                }
                if (facultyId != "${datas.vo.major.facultyId}") {
                    formData.facultyId = facultyId;
                }
                if (description != '${datas.vo.major.description}') {
                	formData.description = description;
                }
                if ($.isEmptyObject(formData)) {
                	  layer.alert('未修改');  
                	return;
                }
                formData.id = '${datas.vo.major.id}';
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
                       } else {
                           layer.alert('修改失败，请重试');  
                       }
                   }
                });
            });
        });
    </script>

</html>