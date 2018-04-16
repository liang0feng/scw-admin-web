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

    <%
		pageContext.setAttribute("title", "用户维护");
	%>

	<!-- 引入顶部导航栏 -->
	<%@include file="/WEB-INF/include/top-navbar.jsp"%>

    <div class="container-fluid">
      <div class="row">
        
        <!-- 引入左侧控制栏 -->
		<%@include file="/WEB-INF/include/left-sidebar.jsp"%>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="${ctp}/main.html">首页</a></li>
				  <li><a href="${ctp}/user/list.html">数据列表</a></li>
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
				<form role="form" class="form-inline">
				  <div class="form-group">
					<label for="exampleInputPassword1">未分配角色列表</label><br>
					<select id="unassignedRoleSelect" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
						<c:forEach items="${unassingedRoles}" var="role">
	                        <option value="${role.id }">${role.name }</option>
						</c:forEach>
                    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li id="addRoleBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                            <br>
                            <li id="removeRoleBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                        </ul>
				  </div>
				  <div class="form-group" style="margin-left:40px;">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select id="assignedRoleSelect" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
						<c:forEach items="${assingedRoles}" var="unrole">
	                        <option value="${unrole.id}">${unrole.name}</option>
						</c:forEach>
                    </select>
				  </div>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
    
    <!-- 添加用户角色的提交表单 -->
    <form id="addUserRoleForm" action="${ctp}/user/addRoles">
    	<input name="userId" value="${param.id}" type="hidden">
    	<input name="selectedId" value="" type="hidden">
    </form>
    
     <!-- 移除用户角色的提交表单 -->
    <form id="removeUserRoleForm" action="${ctp}/user/removeRoles">
    	<input name="userId" value="${param.id}" type="hidden">
    	<input name="selectedId" value="" type="hidden">
    </form>
	
	<!-- 引入common-js -->
	<%@include file="/WEB-INF/include/common-js.jsp"%>
	
	<script type="text/javascript">
		//向右：添加按钮单击事件,form表单/或者使用Ajax网页无刷新方法
		$("#addRoleBtn").click(function(){
			//为用户添加角色需要要：用户uid、要添加的角色rids(rid字符串拼接)
			var uid = "${param.id}";
			var rids = "";
			$("#unassignedRoleSelect :selected").each(function(){
				rids+=$(this).val()+",";
			});
			//填写要提交的表单
			$("#addUserRoleForm input[name='selectedId']").val(rids);
			//提交添加表单
			$("#addUserRoleForm").submit();
		});
		
		
		//向左：移出按钮单击事件（）,form表单/或者使用Ajax网页无刷新方法
		$("#removeRoleBtn").click(function(){
			//为用户添加角色需要要：用户uid、要添加的角色rids(rid字符串拼接)
			var uid = "${param.id}";
			var rids = "";
			$("#assignedRoleSelect :selected").each(function(){
				rids+=$(this).val()+",";
			});
			//填写要提交的表单
			$("#removeUserRoleForm input[name='selectedId']").val(rids);
			//提交添加表单
			$("#removeUserRoleForm").submit();
		});
	</script>
  </body>
</html>
