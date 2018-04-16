<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">

	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">

		<%-- 
	
	包含：
		静态包含： <%@include %>：被包含页面的内容【1】会复制到目标页面【2】，统一写出去；被包含页面不会编译 大多都用静态； 目标页面第一次运行jsp，jsp翻译成xxx_servlet.java 【1,2】-3；翻译的时候把被包含页面的内容复制进来； java在编译class，以后运行jsp运行class； 动态包含：

		<jsp:include>：把被包含页面运行后的结果和目标页面运行后的结果合并起来1,2，；被包含页面会编译 被包含页面的内容经常变换；就用动态包含 --%>

			<%request.setAttribute("title", "控制面板"); %>

			<%@include file="/WEB-INF/include/common-css.jsp" %>
			<link rel="stylesheet" href="${ctp}/static/css/main.css">
			<style>
				.tree li {
					list-style-type: none;
					cursor: pointer;
				}
				
				.tree-closed {
					height: 40px;
				}
				
				.tree-expanded {
					height: auto;
				}
			</style>
	</head>

	<body>

		<!-- 导入顶部导航 -->
		<%@include file="/WEB-INF/include/top-navbar.jsp" %>

		<div class="container-fluid">
			<div class="row">
				<!-- 导入侧边 栏 -->
				<%@include file="/WEB-INF/include/left-sidebar.jsp" %>

				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
					<h1 class="page-header">控制面板</h1>

					<div class="row placeholders">
						<div class="col-xs-6 col-sm-3 placeholder">
							<img data-src="holder.js/200x200/auto/sky" class="img-responsive" alt="Generic placeholder thumbnail">
							<h4>Label</h4>
							<span class="text-muted">Something else</span>
						</div>
						<div class="col-xs-6 col-sm-3 placeholder">
							<img data-src="holder.js/200x200/auto/vine" class="img-responsive" alt="Generic placeholder thumbnail">
							<h4>Label</h4>
							<span class="text-muted">Something else</span>
						</div>
						<div class="col-xs-6 col-sm-3 placeholder">
							<img data-src="holder.js/200x200/auto/sky" class="img-responsive" alt="Generic placeholder thumbnail">
							<h4>Label</h4>
							<span class="text-muted">Something else</span>
						</div>
						<div class="col-xs-6 col-sm-3 placeholder">
							<img data-src="holder.js/200x200/auto/vine" class="img-responsive" alt="Generic placeholder thumbnail">
							<h4>Label</h4>
							<span class="text-muted">Something else</span>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%@include file="/WEB-INF/include/common-js.jsp" %>

	</body>

</html>