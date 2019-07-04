<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>提交作业</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bwx/css/base.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
	<div class="main">
		<article class="show">
			<header>
				<h2>作业信息</h2>
			</header>
			<footer class="tags">
				<form class="form-horizontal">
					<div class="form-group has-success">
						<label class="col-sm-2 control-label">题目</label>
						<div class="col-sm-10">
							<input type="text" class="form-control"
								value="${datas.work.name }" disabled>
						</div>
					</div>
					<div class="form-group has-success">
						<label class="col-sm-2 control-label">课程</label>
						<div class="col-sm-10">
							<input type="text" class="form-control"
								value="${datas.work.lessionName }" disabled>
						</div>
					</div>
					<div class="form-group has-success">
						<label class="col-sm-2 control-label">任课教师</label>
						<div class="col-sm-10">
							<input type="text" class="form-control"
								value="${datas.work.teacherName }" disabled>
						</div>
					</div>
					<div class="form-group has-success">
						<label class="col-sm-2 control-label">要求</label>
						<div class="col-sm-10">
							<textarea class="form-control" rows="5"  disabled="disabled"> ${datas.work.demand }</textarea>
						</div>
					</div>
					<div class="form-group has-success">
						<label class="col-sm-2 control-label">时限</label>
						<div class="col-sm-10">
							<input type="text" class="form-control"
								value='<fmt:formatDate  value="${datas.work.acceptanceTime }" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>' disabled />
						</div>
					</div>
					<div class="form-group has-success">
						<label class="col-sm-2 control-label">附件</label>
						<div class="col-sm-10">
							<p class="help-block">
							 <a href="javascript:;" onclick="showZip('${datas.work.annex }')"><span class="glyphicon glyphicon-paperclip" aria-hidden="true">${datas.work.annex }</span></a>
						  </p>
						</div>
					</div>
				</form>
			</footer>
		</article>
		<article class="show">
			<header>
				<h2>
				<c:choose>
				    <c:when test="${datas.homework.status eq 0  and datas.work.status eq 0 }">上传作业</c:when>
				    <c:when test="${datas.homework.status eq 1 and datas.work.status eq 0 }">更新作业</c:when>
				    <c:otherwise>作业明细</c:otherwise>
				</c:choose>
				</h2>
			</header>
			<footer class="tags">
				<form class="form-horizontal"
					action="${pageContext.request.contextPath }/work/submit" id="form"
					method="post" enctype="multipart/form-data">
					<c:if test="${ datas.work.status ne 0}">
                        <div class="form-group has-success">
                            <label class="col-sm-2 control-label">评分</label>
                            <div class="col-sm-10">
                                  <input type="text" class="form-control"
                                    value="${datas.homework.score }" placeholder="待验收" disabled>
                            </div>
                        </div>
                        <div class="form-group has-success">
                            <label class="col-sm-2 control-label">评论</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" rows="5" disabled="disabled">
                                ${datas.homework.comment }
                                </textarea>
                            </div>
                        </div>
                        <%-- <div class="form-group has-success">
                            <label class="col-sm-2 control-label">附件</label>
                            <div class="col-sm-10">
                                <p class="help-block">
                                    <a href="javascript:;" onclick="showZip('${datas.homework.annex }')">${datas.homework.annex }</a>
                                </p>
                            </div>
                        </div> --%>
                    </c:if>

                    <input type="hidden" name="workId" value="${datas.work.id }" />
                    <c:if
                        test="${datas.work.status eq 0 and (datas.homework.status eq 1 || datas.homework.status eq 0)}">
                         <c:if test="${datas.homework.status ne 0 }">
                            <div class="form-group has-success">
                                <label class="col-sm-2 control-label">附件</label>
                                <div class="col-sm-10">
                                    <p class="help-block">
                                        <a href="javascript:;" onclick="showZip('${datas.homework.annex }')">${datas.homework.annex }</a>
                                    </p>
                                </div>
                            </div>
                        </c:if>
                    <div class="form-group">
                        <label for="input3" class="col-sm-2 control-label text-danger"> 
                        <c:if test="${datas.homework.status eq 0 }">
                                        上传附件
                        </c:if> 
                        <c:if test="${datas.homework.status eq 1 }">
                                        更新附件
                        </c:if>
                        </label>
                       
                        <div class="col-sm-10">
                            <input type="file" name="file" id="exampleInputFile"
                                accept=".zip">
                            <p class="help-block">点击上传作业</p>
                        </div>
                    </div>
                     <div class="form-group">
                         <div class="col-sm-offset-2 col-sm-10">
                             <button type="submit" class="btn btn-info">提交</button>
                         </div>
                     </div>
                    </c:if>
				</form>
			</footer>
		</article>
	</div>
</body>
<script
	src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"
	type="text/javascript" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
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
                        message: '请将文件打包压缩成zip格式进行上传, 且不能超过10MB'
                   },
                   notEmpty: {
                       message: '作业不能为空'
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
                  layer.alert("上传成功", function(){
                	  window.location.reload();
                  });
               } else {
                   layer.alert('上传失败<p>'+ result.msg+'</p>');  
               }
           }
         })
        });
   });
    </script>
</html>
