<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <title>成绩单</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bwx/css/base.css" />
    </head>
    <body>
        <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
        <div class="main">
            
      <article class="show">
        <header>
            <h2>作业信息 </h2>
        </header>
        <footer class="tags">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">课程</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" disabled="disabled">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">题目</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" disabled="disabled">
                    </div>
                </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="inputtime">发布时间</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" disabled="disabled">
                </div>
            </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="inputtime">验收时间</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" disabled="disabled">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">附件</label>
                    <div class="col-sm-10">
                        <p class="help-block"><a href="">压缩卡扣式.zip</a></p>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">内容要求</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" rows="5" placeholder="要求:" disabled="disabled"></textarea>
                    </div>
                </div>
            </form>
        </footer>
      </article>
      <article class="show">
        <header>
            <h2>成绩评语 </h2>
        </header>
        <footer class="tags">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">分数</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" disabled="disabled">
                    </div>
                </div>
                <div class="form-group">
              <label class="col-sm-2 control-label">评语</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" rows="5" placeholder="要求:" disabled="disabled"></textarea>
                    </div>
                </div>
            </form>
        </footer>
      </article>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/bwx/js/jquery-3.3.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">

    </script>
</html>
