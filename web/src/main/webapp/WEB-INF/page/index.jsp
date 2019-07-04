<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>首页</title>
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
		<div class="page-header">
		<iframe name="weather_inc" src="http://i.tianqi.com/index.php?c=code&id=2" width="770" height="70" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
		</div>
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<h4 id="word" class="text-muted" style="line-height: 140%"></h4>
				<h5 class="text-right">
					<span class="text-danger ">For -- </span> <i id="word_from"
						class="text-danger"></i>
				</h5>
				<div class=" text-center " style="margin-top: 40px;">
					<img src="" id="img_url" width="100%" height="100%">
				</div>
				<h5 class="text-info  text-center">
					<span id="img_kind"></span> | <span id="img_author"></span>
				</h5>
			</div>
		</div>
	</div>
</body>
<script src="${pageContext.request.contextPath }/bwx/js/jquery-3.3.1.min.js" type="text/javascript"
	charset="utf-8"></script>
	    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
        $.ajax({
            type: "POST",
            url: 'https://api.hibai.cn/api/index/index',
            dataType: 'json',
            data: {
                "TransCode": "030111",
                "OpenId": "123456789",
                "Body": ""
            },
            success: function(result) {
                var body = result.Body;
                $("#word").text(body.word);
                $("#word_from").text(body.word_from);
                $("#img_url").attr("src", body.img_url);
                $("#img_kind").text(body.img_kind);
                $("#img_author").text(body.img_author);
            }
        });
    </script>
</html>