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
	<%@include file="/WEB-INF/include/common-css.jsp" %>
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
      <form id="regForm" class="form-signin" role="form" action="${ctp }/user/regist">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
        <h6 style="color: red;">${msg } </h6>
		  <div class="form-group has-success has-feedback">
		  	<!-- 默认是类名首字母小写（满足驼峰命名法）
		  		TUser：  TUser
		  		UserName:  userName
		  	 -->
			<input type="text" class="form-control" name="loginacct" placeholder="请输入登录账号" autofocus value="${TUser.loginacct }">
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" name="userpswd" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" name="email" placeholder="请输入邮箱地址" style="margin-top:10px;" value="${TUser.email }">
			<span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select class="form-control" >
                <option>会员</option>
                <option>管理</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="${ctp}/login.html">我有账号</a>
          </label>
        </div>
        <button type="submit" class="btn btn-lg btn-success btn-block" > 注册</button>
      </form>
    </div>
  	<%@include file="/WEB-INF/include/common-js.jsp" %>
  	<script type="text/javascript">
  	//设置校验器的默认行为
	  	$.validator.setDefaults({
	  		//错误显示的回调
	  		showErrors: function(map, list) {
	  			//定义错误的显示逻辑
	  			//清除所有的之前的错误
	  			//成功的元素
	  			//console.log("以上是成功的...");
	  			$.each(this.successList,function(){
	  				$(this).parent(".form-group").removeClass("has-success has-error").addClass("has-success");
	  				$(this).parent(".form-group").find("label").remove();
	  			});
	  			
	  			
	  			//$.each：遍历  两个参数：第一个：要遍历的集合  第二个是每次遍历的回调
	  			//错误显示的逻辑
	  			$.each(list,function(){
	  				//1、把错误消息放在每个input的span的后面
	  				var lable = "<label  class='help-block'>"+this.message+"</label>";
	  				//清除自己的之前的错误提示
	  				$(this.element).parent(".form-group").find("label.help-block").remove();
	  				
	  				//如果这样每次进来都append；就完蛋了
	  				$(this.element).parent(".form-group").removeClass("has-success has-error").addClass("has-error");
	  				$(this.element).parent(".form-group").append(lable);//发送错误的input元素
	  				
	  			});
	  			//成功的变为绿色;
	  		}
	  	});
  	
  		$(function(){
  			$("#regForm").validate({
  				rules:{
  					loginacct:{
  						required:true,
  						minlength:5,
  						maxlength:18
  					},
  					userpswd:{
  						required:true,
  						minlength:5,
  						maxlength:18
  					},
  					email:{
  						required:true,
  						email:true
  					}
  				},
  				messages:{
  					loginacct:{
  						required:"登陆账号必须填写",
  						minlength:"登陆账号必须大于5个字符",
  						maxlength:"登陆账号必须小于18个字符"
  					},
  					userpswd:{
  						required:"密码必须填写",
  						minlength:"密码必须在5个字符以上",
  						maxlength:"密码必须在18个字符以内"
  					},
  					email:{
  						required:"邮箱必须填写",
  						email:"必须是合法的邮箱格式"
  					}
  					
  				}
  			});
  		});
  	</script>
  </body>
</html>