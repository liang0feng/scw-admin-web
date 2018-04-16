<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${ctp}/static/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctp}/static/css/font-awesome.min.css">
	<link rel="stylesheet" href="${ctp}/static/css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="${ctp}/static/index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">
      <form class="form-signin" role="form" action="">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i>密码重置</h2>
        <h6 style="color: red;">${msg }</h6>
		 <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" name="userpswd" placeholder="请输入新密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" name="userpswd" placeholder="确认新密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
        <button type="submit" class="btn btn-lg btn-success btn-block">修改密码</button>
      </form>
    </div>
    <script src="${ctp}/static/jquery/jquery-2.1.1.min.js"></script>
    <script src="${ctp}/static/bootstrap/js/bootstrap.min.js"></script>
    <script>
   
    </script>
  </body>
</html>