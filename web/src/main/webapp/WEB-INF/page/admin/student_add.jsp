<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>添加学生</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/student" id="form" style="width: 100% !important;">
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">姓名</label>
               <input type="text" name="name" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2" >
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess7">电子邮件</label>
               <input type="email" name="email" class="form-control" id="inputSuccess7" aria-describedby="helpBlock2" >
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">角色</label>
               <input type="text" value="${datas.role.name }" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2" readonly>
               <input type="hidden" name="login.roleId" value="${datas.role.id }">
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
                    	trigger:"change",
                    	 validators: {
                             notEmpty: {
                                 message: '不能为空'
                             }
                    	 }
                    },
                    'email': {
                        validators: {
                            notEmpty: {
                                message: '邮件不能为空'
                            },
                            emailAddress: {
                                message: '邮箱地址格式有误'
                            },
                            remote: {
                              url: '${pageContext.request.contextPath}/api-email-able',
                              message:"此邮箱已经注册",
                              type: "get",
                              dataType: 'json',
                              data: {
                                  name: $('#inputSuccess7').val(),
                                  flag: true
                              },
                              delay: 1000,//延迟效果
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