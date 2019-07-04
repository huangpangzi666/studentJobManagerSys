<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>修改作业</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bwx/css/base.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bwx/css/bootstrap-datetimepicker.min.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
	<div class="main">
		<form class="form-horizontal center-top"
			action="${pageContext.request.contextPath }/work/republish"
			method="post" enctype="multipart/form-data" id="form">
			<div class="form-group">
				<label for="input1" class="col-sm-2 control-label">课程</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" value="${datas.clname }"
						disabled="disabled">
				</div>
			</div>
			<div class="form-group">
				<label for="input2" class="col-sm-2 control-label">题目</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="input2"
						value="${datas.work.name }">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="inputtime">验收时间</label>
				<div class="col-sm-9">
					<input size="30" type="text"
						value='<fmt:formatDate  value="${datas.work.acceptanceTime }" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>'
						readonly class="form_datetime form-control" id="inputtime">
				</div>
			</div>
			<div class="form-group">
				<label for="input3" class="col-sm-2 control-label">附件</label>
				<div class="col-sm-9">
					<p class="help-block">
						<a href="javascript:;" onclick="showZip('${datas.work.annex }')">
							${datas.work.annex }</a>
					</p>
				</div>
			</div>
			 <c:if test="${datas.work.status == 0 }">
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-9">
						<input type="file" id="exampleInputFile" accept=".zip">
						<p class="help-block text-info">点击更新文件</p>
					</div>
				</div>
			</c:if>
			<div class="form-group">
				<label for="input4" class="col-sm-2 control-label">内容要求</label>
				<div class="col-sm-9">
					<textarea class="form-control" rows="5" placeholder="要求:"
						id="input4">${datas.work.demand }</textarea>
				</div>
			</div>
			 <c:if test="${datas.work.status == 0 }">
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-9">
						<button type="submit" class="btn btn-info">确认更新</button>
					</div>
				</div>
			</c:if>
		</form>
	</div>
</body>
<script
	src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="${pageContext.request.contextPath}/bwx/js/bootstrap-datetimepicker.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="${pageContext.request.contextPath}/bwx/js/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js"
	type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js"
	type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
  function showZip(file) {
	    if (file == '') {
	        layer.alert("没有附件");
	        return;
	    }
	    layer.open({
	         title: '文件',
	         type: 2,
	         area: ['580px', '640px'],
	         content: "${pageContext.request.contextPath}/comm/show" + file
	    });
	}
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
                             message: '请将文件打包压缩成zip格式进行上传，且文件大小不超过10M'
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
          
             var formData = new FormData(),
                 name = $("#input2").val(),
                 acceptanceTime = $("#inputtime").val(),
                 demand = $("#input4").val();
           
                 if (name != "${datas.work.name}") {
                	  formData.append("name", name);
                 }
                 if (acceptanceTime != '<fmt:formatDate  value="${datas.work.acceptanceTime }" pattern="yyyy-MM-dd hh:mm"/>') {
                	 formData.append("acceptanceTime", acceptanceTime);
                 }
                 if (demand != "${datas.work.demand}") {
                	 formData.append("demand", demand);
                 }
                 if ($.isEmptyObject(formData)) {
                     layer.alert("未修改！");
                     return;
                 } 
                 var file = document.getElementById("exampleInputFile").files[0],
                     id = "${datas.work.id}";
                 formData.append("file", file);
                 formData.append("id", id);
              $.ajax({
                url: $form.attr('action'), 
                type : "POST",
                data: formData, 
                processData: false,
                contentType: false,
                cache: false,
                async: false,
                dataType: "json",
                success:function(result) {
                    if (result.status == 'SUCCESS') {
                       layer.alert("更新成功", function() {
                    	   window.location.href = "${pageContext.request.contextPath}/work/ui-recoders";
                       }); 
                    } else {
                        layer.alert('更新失败');  
                    }
                }
              })
             });
        });
  </script>
</html>
