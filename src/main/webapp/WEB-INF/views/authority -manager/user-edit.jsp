<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<!-- 引入common-css -->
	<%@include file="/WEB-INF/include/common-css.jsp"%>
	<link rel="stylesheet" href="${ctp}/static/css/main.css">
	
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

   <%pageContext.setAttribute("title", "用户维护"); %>

	<!-- 引入顶部导航栏 -->
	<%@include file="/WEB-INF/include/top-navbar.jsp"%>

    <div class="container-fluid">
      <div class="row">
        
        <!-- 引入左侧控制栏 -->
		<%@include file="/WEB-INF/include/left-sidebar.jsp"%>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form" action="${ctp}/user/edit" method="post">
				  <input name="_method" value="put" type="hidden">
				  <input name="id" type="hidden" value="${user.id }">
				  <div class="form-group">
					<label for="exampleInputPassword1">登陆账号</label>
					<input type="text" class="form-control" name="loginacct" value="${user.loginacct }">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">用户名称</label>
					<input type="text" class="form-control" name="username" value="${user.username }">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input type="email" class="form-control" name="email" value="${user.email }">
<!-- 					<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p> -->
				  </div>
				  <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> 修改</button>
				  <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	
   
	<!-- 引入common-js -->
	<%@include file="/WEB-INF/include/common-js.jsp"%>
	<script type="text/javascript">
		$(function(){
			var msg = "${msg}";
			if(msg != null && msg.length != 0){
				layer.msg("${msg}");
			}
		});
	</script>
  </body>
</html>
