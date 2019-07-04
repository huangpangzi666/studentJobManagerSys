<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>修改学生</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/student" id="form" style="width: 100% !important;">
            <input type="hidden" name="id" value="${datas.id }">
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">姓名</label>
               <input type="text" value="${datas.name }" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2" readonly="readonly">
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">角色</label>
               <input type="text" value="${datas.role.name }" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2" readonly>
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess2">选择院系</label>
              <select  class="form-control" id="inputSuccess2" onchange="showMajor()" required>
                <option>请选择院系</option>
                <c:forEach var="faculty" items="${datas.faculties }" varStatus="status">
                  <option value="${faculty.id }">${faculty.name }</option>
                </c:forEach>
                </select>
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess3">所属专业</label>
              <select  class="form-control" id="inputSuccess3" onchange="showClass()" required>
                <option>请选择专业</option>
              </select>
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess4">选择班级</label>
              <select name="classId" class="form-control" id="inputSuccess4" >
              <option>请选择班级</option>
               </select>
            </div>
            <button type="submit" class="btn btn-info btn-block">确认修改</button>
        </form>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
    /* 获取班级信息 */
    function showClass(){
    	$.get(
           "${pageContext.request.contextPath}/admin/class/api-major/" + $("#inputSuccess3 option:selected").val(),
           function (result) {
               var selectTag = $("#inputSuccess4");
               $(selectTag).empty();
               $.each(result, function(index, item) {
                   $(selectTag).append("<option value="+result[index].id+">"+result[index].year+""+result[index].name+"</option>");
               })
           },
           "json"
       );
    }
    /* 获取专业信息 */
    function showMajor() {
    	$.get(
            "${pageContext.request.contextPath}/admin/major/api-faculty/" + $("#inputSuccess2 option:selected").val(),
            function (result) {
            	var selectTag = $("#inputSuccess3");
            	$(selectTag).empty();
                $.each(result, function(index, item) {
                	$(selectTag).append("<option value="+result[index].id+">"+result[index].name+"</option>");
                })
                showClass();
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
                    'classId': {
                    	 validators: {
                             notEmpty: {
                                 message: '不能为空'
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
                
                var cId = $("#inputSuccess4 option:selected").val();
                if (cId == '${datas.classId}') {
                	layer.alert("未修改");
                	return;
                }
                $.ajax({
                    url: $form.attr('action'),
                    type: 'put',
                    data: $form.serialize(),
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