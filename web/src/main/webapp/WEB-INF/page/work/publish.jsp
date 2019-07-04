<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <title>发布作业</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrap-datetimepicker.min.css"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
            <form class="form-horizontal center-top" action="${pageContext.request.contextPath }/work/publish" method="post" enctype="multipart/form-data" id="form">
        <div class="form-group">
            <label for="input1" class="col-sm-2 control-label">课程</label>
            <div class="col-sm-9">
                <select class="form-control" name="teachingLessionId">
                    <c:forEach var="tLession" items="${tLessions }">
                        <option value="${tLession.id }">${tLession.className } - ${tLession.lessionName }</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="input2" class="col-sm-2 control-label">题目</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="input2" name="name">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="inputtime">验收时间</label>
            <div class="col-sm-9">
                <input size="30" type="text" name="acceptanceTime"  readonly class="form_datetime form-control" id="inputtime">
            </div>
        </div>
        <div class="form-group">
            <label for="input3" class="col-sm-2 control-label">上传附件</label>
            <div class="col-sm-9">
                <input type="file" id="exampleInputFile" name="file" accept=".zip">
            <p class="help-block">点击上传文件</p>
            </div>
        </div>
        <div class="form-group">
            <label for="input4" class="col-sm-2 control-label">内容要求</label>
            <div class="col-sm-9">
                <textarea class="form-control" name="demand" rows="5" placeholder="要求:" id="input4"></textarea>
            </div>
        </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-9">
                        <button type="submit" class="btn btn-info">发布</button>
                    </div>
                </div>
            </form>
        </div>
    </body>
  <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${pageContext.request.contextPath}/bwx/js/bootstrap-datetimepicker.min.js" type="text/javascript" charset="utf-8"></script>
  <script src="${pageContext.request.contextPath}/bwx/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript" charset="utf-8"></script>
   <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
     $(".form_datetime").datetimepicker({
       format: 'yyyy-mm-dd hh:ii',
       language: 'zh-CN',
       startDate: new Date(),
        autoclose: 1,
     });
     $(document).ready(function() {
         $(form).bootstrapValidator({
             feedbackIcons: {
                 valid: 'glyphicon glyphicon-ok',
                 invalid: 'glyphicon glyphicon-remove',
                 validating: 'glyphicon glyphicon-refresh'
             },
             fields: {
                 'file': {
                     validators: {
                        file: {
                             extension: 'zip',
                             maxSize: 1024*1024*10,
                             type: 'application/zip,application/octet-stream,application/x-zip-compressed,multipart/x-zip',
                             message: '请将文件打包压缩成zip格式进行上传， 且文件大小不超过10M'
                        }
                     }
                 },
                 'teachingLessionId': {
                	 validators: {
                		 notEmpty: {
                             message: '任课班级不能为空'
                         }
                	 }
                 },
                 'name': {
                	 validators: {
                		 notEmpty: {
                             message: '题目不能为空'
                         },
                         stringLength: {
                             min: 2,
                             max: 64,
                             message: '题目长度为2 ~ 64位'
                         }
                	 }
                 },
                 'acceptanceTime': {
                	 validators: {
                		 notEmpty: {
                             message: '验收时间不能为空'
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
          
              $.ajax({
                url: $form.attr('action'), 
                type : "post",
                data: new FormData($("#form")[0]), 
                processData: false,
                contentType: false,
                async: false,
                cache: false,
                dataType: "json",
                success:function(result) {
                    if (result.status == 'SUCCESS') {
                       layer.alert("发布成功", function() {
	                       window.location.href = "${pageContext.request.contextPath}/work/ui-recoders";
                       });
                    } else {
                        layer.alert('发布失败');  
                    }
                }
              })
             });
        });
  </script>
</html>
