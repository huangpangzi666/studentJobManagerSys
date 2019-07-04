<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>添加班级</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/class" id="form" style="width: 100% !important;">
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">名称</label>
              <input type="text" name="name" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2" readonly>
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess5">届（年级）</label>
              <input type="text" name="year" class="form-control" id="inputSuccess5" aria-describedby="helpBlock2">
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess3">所属院系</label>
              <select name="facultyId" class="form-control" id="inputSuccess3" onchange="showMajor()">
                <c:forEach var="faculty" items="${faculties }" varStatus="status">
				  <option value="${faculty.id }">${faculty.name }</option>
				</c:forEach>
				</select>
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess4">所属专业</label>
              <select name="majorId" class="form-control" id="inputSuccess4" onchange="showName()">
                <%-- <c:forEach var="faculty" items="${faculties }" varStatus="status">
				  <option value="${faculty.id }">${faculty.name }</option>
				</c:forEach> --%>
				</select>
            </div>
            <button type="submit" class="btn btn-info btn-block">添加</button>
        </form>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
    function showName() {
    	var text = $("#inputSuccess4 option:selected").text();
    	$("#inputSuccess1").val(text);
    }
    function showMajor() {
    	$.get(
            "${pageContext.request.contextPath}/admin/major/api-faculty/" + $("#inputSuccess3 option:selected").val(),
            function (result) {
            	var selectTag = $("#inputSuccess4");
            	$(selectTag).empty();
                $.each(result, function(index, item) {
                	$(selectTag).append("<option value="+result[index].id+">"+result[index].name+"</option>");
                })
                showName();
            },
            "json"
        );
    }
    showMajor();
    showName();
     var isable = false;
       
	    function able() {
	    	$.ajax({
	    		url: "${pageContext.request.contextPath}/admin/class/api-isable",
	    		type: "get",
	    		data: {
	    			name: $.trim($("#inputSuccess1").val()), 
	    			year: $.trim($("#inputSuccess5").val())
	    		},
	    		async: false,
	    		success: function (result) {
	    			if (result.status == "SUCCESS") {
	    				isable = true;
	    			} else {
	    				isable = false;
	    			}
	    		}
	    	});
	    	return isable;
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
                    'facultyId': {
                    	 validators: {
                             notEmpty: {
                                 message: '不能为空'
                             }
                    	 }
                    },
                    'majorId': {
                    	 validators: {
                             notEmpty: {
                                 message: '不能为空'
                             }
                         }
                    },
                    'year': {
                    	 validators: {
                             notEmpty: {
                                 message: '不能为空'
                             },
                             stringLength: {
                                 min: 4,
                                 max: 4,
                                 message: '长度为4位'
                             },
                             regexp: {
                                  regexp: /^[1-9][0-9]{3}/,
                                  message: '输入数字'
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
                
                if (!able()) {
                    layer.alert("（年级+名称） 班级重复，请重新输入");
                    return;
                }
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