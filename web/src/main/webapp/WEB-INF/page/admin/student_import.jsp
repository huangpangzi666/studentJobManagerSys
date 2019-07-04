<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" class="open-area-width">

<head>
<meta charset="UTF-8">
<title>Excel学生信息导入</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bwx/css/base.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
</head>

<body id="top_logo">
	<form action="${pageContext.request.contextPath }/admin/student/import"
		enctype="multipart/form-data" id="form"
		style="width: 100% !important;">
		<div class="form-group">
			<label class="control-label">为保证正确导入，请下载学生模板进行上传！</label>
		</div>
		<div class="form-group  text-center">
			<label class="control-label"><a
				href="${pageContext.request.contextPath }/comm/download/学生信息模板.xlsx"><strong
					class="text-danger">获取模板</strong></a></label>
		</div>
		<div class="form-group">
			<input type="file" name="file" id="exampleInputFile" >
		</div>
		<button type="submit" class="btn btn-info btn-block">上传</button>
	</form>
</body>
<script
	src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js"
	type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js"
	type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
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
	                    notEmpty: {
	                        message: '请选择一个Excel文件'
	                    },
	                    file: {
	                    	extension: 'xls,xlsx',
	                    	type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel',
                            message: '请选择Excel文件进行上传'
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
	           cache: false,
	           dataType: "json",
	           success:function(result) {
		           if (result.status == 'SUCCESS') {
		        	  var str = "<p>处理：<strong class='text-success'>"+ result.msg.count+"</strong> 个数据</p><p >完成：<strong class='text-success'>"+ result.msg.successSize +"</strong> 个</p><p >失败：<strong class='text-danger'>"+ result.msg.failSize+"</strong> 个</p>"
		        	  if (result.msg.failDatas != null) {
		        		  str += "<p >失败数据行：<strong class='text-danger'>"+ result.msg.failDatas +"</strong>";
		        	  }
		              layer.alert(str, function(index){
		                   var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		                   parent.layer.close(index); //再执行关闭
		               }); 
		           } else {
		               layer.alert('添加失败' + result.msg);  
		           }
	           }
	         })
		    });
	   });
    </script>

</html>