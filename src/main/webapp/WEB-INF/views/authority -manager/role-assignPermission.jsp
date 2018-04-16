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

	<!-- 引入common-css -->
	<%@include file="/WEB-INF/include/common-css.jsp"%>
	<link rel="stylesheet" href="${ctp}/static/css/main.css">
	<link rel="stylesheet" href="css/main.css">
	
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

			<div class="panel panel-default">
              <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限分配列表<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
                  <button class="btn btn-success">分配许可</button>
                  <br><br>
                  <ul id="treeDemo" class="ztree"></ul>
			  </div>
			</div>
        </div>
      </div>
    </div>
	
   <!-- 引入common-js -->
	<%@include file="/WEB-INF/include/common-js.jsp"%>
	
      
  </body>
</html>
