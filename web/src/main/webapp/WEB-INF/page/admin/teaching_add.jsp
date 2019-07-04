<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>添加授课关系</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/teaching" id="form" style="width: 100% !important;">
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">选择教师</label>
              <select name="teacherId" class="form-control" id="inputSuccess1" >
                <c:forEach var="teacher" items="${datas.teachers }" varStatus="status">
                  <option value="${teacher.id }">${teacher.name }</option>
                </c:forEach>
                </select>
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
               </select>
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess5">选择课程</label>
              <select name="lessionId" class="form-control" id="inputSuccess5" >
                <c:forEach var="lession" items="${datas.lessions }" varStatus="status">
                  <option value="${lession.id }">${lession.name }</option>
                </c:forEach>
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
              
               $(selectTag).change();
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
   /*  showMajor(); */
        // 校验
        $(document).ready(function() {
            $(form).bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    'teacherId': {
                        validators: {
                            notEmpty: {
                                message: '不能为空'
                            }
                        }
                    },
                    'classId': {
                    	trigger:"change",
                    	 validators: {
                             notEmpty: {
                                 message: '不能为空'
                             }
                    	 }
                    },
                    'lessionId': {
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