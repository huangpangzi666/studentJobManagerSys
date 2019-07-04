<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

    <head>
        <meta charset="UTF-8">
        <title>修改授课关系</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body id="top_logo">
        <form action="${pageContext.request.contextPath }/admin/teaching" id="form" style="width: 100% !important;">
            <input type="hidden" name="id" value="${teaching.id }">
            <div class="form-group">
              <label class="control-label" for="inputSuccess3">授课人</label>
              <select name="userId" class="form-control" id="inputSuccess3" >
                <c:forEach var="teacher" items="${datas.teachers }" varStatus="status">
                    <c:if test="${teacher.id eq datas.teaching.teacherId }">
					  <option value="${teacher.id }" selected>${teacher.name }</option>
                    </c:if>
                    <c:if test="${teacher.id ne datas.teaching.teacherId }">
					  <option value="${teacher.id }">${teacher.name }</option>
                    </c:if>
				</c:forEach>
				</select>
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess1">授课班级</label>
              <input type="text" value="${datas.teaching.className}" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2" readonly>
            </div>
            <div class="form-group">
              <label class="control-label" for="inputSuccess2">授课课程</label>
              <input type="text" value="${datas.teaching.lessionName}" class="form-control" id="inputSuccess2" aria-describedby="helpBlock2" readonly>
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
                    'userId': {
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
                
                if ('${datas.teaching.teacherId}' == $("#inputSuccess3 option:selected").val()) {
                    layer.alert("未修改");
                    return;
                }
                formData = {
                	id: '${datas.teaching.id}',
                	teacherId: $("#inputSuccess3 option:selected").val()
                }
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