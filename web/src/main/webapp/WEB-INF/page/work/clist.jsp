<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">

    <head>
        <meta charset="UTF-8">
        <title>班级作业列表</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/star-rating.min.css" />
         <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/bootstrapValidator.min.css" />
    </head>

    <body>
       <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
            <article class="show">
                <header>
                    <h2>
                        <a role="button" href="javascript:window.location.href=document.referrer;" class="btn btn-default">返回</a>
                        <c:if test="${datas.status ne 2}">
                        <button type="button" onclick="acceptance('${datas.workId}')" class="btn btn-info">验收作业</button>
                        </c:if>
                    </h2>
                </header>
                <footer class="tags">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <td>序号</td>
                                <td>学号</td>
                                <td>姓名</td>
                                <td>分数</td>
                                <td>提交时间</td>
                                <td>作业</td>
                                <td>验收状态</td>
                                <td>操作</td>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${datas.homeworks }" var="hw" varStatus="status">
                             <tr data-toggle="tooltip" data-placement="bottom" title="评论：${hw.comment }">
                              <td>${status.index+1 }</td>
                              <td>${hw.studentId }</td>
                              <td>${hw.studentName }</td>
                              <td>${hw.score }</td>
                              <td><fmt:formatDate value="${hw.gmtModified }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                              <td><a href="javascript:;" onclick="showZip('${hw.annex}')"><span class="glyphicon glyphicon-paperclip" aria-hidden="true">附件</span></a></td>
                              <td>
                                <c:if test="${hw.status eq 2 }">
                                    <span class="text-success">已验收</span>
                                </c:if>
                                <c:if test="${hw.status eq 1 }">
                                    <span class="text-info"><a href="">未验收</a></span>
                                </c:if>
                                <c:if test="${hw.status eq 0 }">
                                   <span class="text-danger">未提交</span>
                                </c:if>
                                <c:if test="${hw.status eq 3 }">
                                   <span class="text-danger">已完成</span>
                                </c:if>
                              </td>
                              <td> 
                                <c:if test="${hw.status eq 1 or hw.status eq 2}">
                                 <a href="javascript:;" class="text-info" onclick="mark('${hw.id}', '${hw.score }', '${hw.comment }')">评分</a>
                                 </c:if>
                                 <c:if test="${hw.status eq 0 }">
                                     <a href="javascript:;" class="text-danger" onclick="notice(this,'${hw.id}')">提醒</a>
                                 </c:if>
                                 <c:if test="${hw.status eq 3 }">
                                   <span class="text-danger">禁止操作</span>
                                </c:if>
                              </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </footer>
            </article>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
     <script src="${pageContext.request.contextPath}/bwx/js/star-rating.min.js" type="text/javascript" charset="utf-8"></script>
         <script src="${pageContext.request.contextPath}/bwx/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
     <script src="${pageContext.request.contextPath}/bwx/js/zh.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"
    type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
    function acceptance(workID) {
    	layer.confirm('一旦验收，无法再修改，是否继续？', {icon: 3, title:'提示'}, function(index){
    		  $.ajax({
	            url: '${pageContext.request.contextPath }/work/acceptance/' + workID,
	            type: 'put',
	            dataType: 'json',
	            success: function(result) {
	                if (result.status == 'SUCCESS') {
	                    layer.alert('操作成功', function(){
	                    	 layer.close(index); //再执行关闭
	                        window.location.reload();
	                    });
	                } else {
	                    layer.alert('操作失败:<p>'+ result.msg +'</p>');  
	                }
	            }
	         });
    		  layer.close(index);
    		});
     }
        $(function () {
          $('[data-toggle="tooltip"]').tooltip()
        })
        function notice(span, homeworkId) {
        	/* layer.msg('提醒用户功能正考虑是否需要开发中....', {icon: 6});  */
        	$.ajax({
                url: '${pageContext.request.contextPath}/work/notic/' + homeworkId,
                type: 'get',
                dataType: 'json',
                success: function(result) {
                    if (result.status == 'SUCCESS') {
                    	layer.msg("提醒用户成功", {icon: 6});
                    	$(span).remove();
                    } else {
                    	layer.msg("失败：" + result.msg, {icon: 5});
                    }
                }
             });
        }
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
        function mark(id, score, comment) {
        	layer.open({
                title: '作业评分',
                type: 1,
                area: ['480px', '400px'],
                content: '<form id="form" id="form" method="POST" style="width: 90%; margin-left: 20px; margin-top:40px;"><div class="form-group"><label class="control-label" for="inputSuccess1">评分<small class="text-danger"> (默认0) </small></label><input id="input-id" name="score" type="number" class="rating"  data-size="sm" ></div><div class="form-group"><label class="control-label" for="inputSuccess2">评论</label><textarea name="comment" class="form-control" id="comment" aria-describedby="helpBlock2" rows="5" id="comment"></textarea></div><button type="submit" class="btn btn-info btn-block">确定</button></form>',
                success: function(layero, index){
                	 score = score == '' ? 0 : score;
                	 $("#input-id").val(score);
                	 $("#comment").val(comment);
                	 
                	 $("#input-id").rating({
                		 stars: 10,
                		 min: 0,
                		 max: 100,
                		 step: 5,
                		 language: 'zh',
                		 starCaptions: {
                			 0: '0分不解释', 
                			 5: '5分', 
                			 10: '10分', 
                			 15: '15分',
                			 20: '20分',
                			 25: '25分',
                			 30: '30分',
                			 35: '35分',
                			 40: '40分',
                			 45: '45分',
                			 50: '50分',
                			 55: '55分',
                			 60: '60分 一般',
                			 65: '65分 一般',
                			 70: '70分 较好',
                			 75: '75分 较好',
                			 80: '80分 好',
                			 85: '85分 好',
                			 90: '90分 优',
                			 95: '95分 优',
                			 100: '100分 极好',
                		}
                	 });
                	 
                	 $(form).bootstrapValidator({}).on('success.form.bv', function(e) {
                         // Prevent form submission
                         e.preventDefault();
                         
                         var $score = $("#input-id").val(),
                             $comment = $("#comment").val(),
                             formData = {};
                         if (score != $score) {
                        	 formData.score = $score;
                         }
                         console.log(score);
                         console.log($score);
                         if (comment != $comment) {
                        	 formData.comment = $comment;
                        	 if ($score == '') {
                        		 formData.score = 0; 
                        	 }
                         }
                         if ($.isEmptyObject(formData)) {
                        	 return;
                         }
                         formData.id = id;
                         
                         // Get the form instance
                         var $form = $(e.target);

                         // Use Ajax to submit form data
                         $.ajax({
                             url: '${pageContext.request.contextPath}/work/mark',
                             type: 'put',
                             data: formData,
                             dataType: 'json',
                             success: function(result) {
                                 if (result.status == 'SUCCESS') {
                                     layer.alert('成功', function(){
                                    	 layer.close(index); //再执行关闭
                                         window.location.reload();
                                     });
                                 } else {
                                     layer.alert('失败，请重试');  
                                 }
                             }
                          });
                     });
               }
            }); 
        }
    </script>
</html>