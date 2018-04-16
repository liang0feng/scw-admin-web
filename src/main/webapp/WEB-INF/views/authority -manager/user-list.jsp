<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
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
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text"
										placeholder="请输入查询条件" name="condition" value="${condition }">
								</div>
							</div>
							<button id="queryBtn" type="button" class="btn btn-warning">
								<i class="glyphicon glyphicon-search" onclick=""></i> 查询
							</button>
						</form>
						<button id="batchDeleteUser" type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" id="addUserModalBtn" class="btn btn-primary"
							style="float: right;">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="50">编号</th>
										<th width="30"><input type="checkbox" id="selectAll"></th>
										<th>账号</th>
										<th>名称</th>
										<th>邮箱地址</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${pageInfo.list}" var="user">
										<tr>
											<td>${user.id }</td>
											<td><input type="checkbox" userId="${user.id}" class="selectBox"></td>
											<td>${user.loginacct }</td>
											<td>${user.username }</td>
											<td>${user.email }</td>
											<td>
												<button onclick="window.location.href='${ctp}/user/assign.html?id=${user.id}'" type="button" class="btn btn-success btn-xs">
													<i class=" glyphicon glyphicon-check"></i>
												</button>
												<a href="${ctp}/user/edit.html?id=${user.id}&pn=${pageInfo.pageNum}" type="button" class="btn btn-primary btn-xs">
													<i class=" glyphicon glyphicon-pencil"></i>
												</a>
												<button username="${user.username }" userId="${user.id}" type="submit" class="btn btn-danger btn-xs removeUser">
													<i class=" glyphicon glyphicon-remove"></i>
												</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">
													<c:if test="${pageInfo.hasPreviousPage}">
														<li><a href="${ctp}/user/list.html/?pn=${pageInfo.prePage}">上一页</a></li>
													</c:if>
												<c:forEach items="${pageInfo.navigatepageNums}" var="pn">
													<!-- 如果是当前页面，突出显示 -->
													<c:if test="${pn == pageInfo.pageNum }">
														<li class="active"><a href="${ctp}/user/list.html?pn=${pn}">${pn }<span
																class="sr-only">(current)</span></a></li>
														
													</c:if>
													<!-- 如果不是当前页面 -->
													<c:if test="${pn != pageInfo.pageNum}">
														<li><a href="${ctp}/user/list.html?pn=${pn}">${pn}</a></li>
													</c:if>
												</c:forEach>
												<c:if test="${pageInfo.hasNextPage}">
													<li><a href="${ctp}/user/list.html/?pn=${pageInfo.nextPage}">下一页</a></li>
												</c:if>
												<li class="disable"><a>&nbsp总记录：${pageInfo.total}条</a></li>
												<li class="disable"><a>总页数：${pageInfo.pages }页</a></li>
											</ul>
										</td>
									</tr>

								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 删除表单 -->
	<form id="deleteUserForm" action="${ctp}/user/delete" method="post">
		<input type="hidden" name="_method" value="delete"/>
		<input type="hidden" name="ids" value=""/>
	</form>
	
		<!-- 查询提交表单 -->
	<form id="queryUserForm" action="${ctp}/user/list.html" method="get">
		<input type="hidden" name="condition" value=""/>
		<input type="hidden" name="pn" value=""/>
	</form>
	

	
	<div class="modal fade" id="userAddModal" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增用户信息</h4>
				</div>
				<div class="modal-body">
					<form id="userAddForm" action="${ctp }/user/add"
						method="post">
						<div class="form-group">
							<label>用户账号</label> <input type="text" class="form-control"
								name="loginacct">
						</div>
						<div class="form-group">
							<label>用户昵称</label>
							<div class="input-group">
								<input type="text" class="form-control" name="username">
							</div>
						</div>
						<div class="form-group">
							<label>邮箱地址</label> <input type="email" class="form-control"
								name="email">
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="userAddFormSubmitBtn" onclick="$('#userAddForm').submit();">添加</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 引入common-js -->
	<%@include file="/WEB-INF/include/common-js.jsp"%>
	<script type="text/javascript">
		$(function(){
			//修改信息回显${msg != ""} && ${msg != null}
			var msg = "${msg}";
			if(msg.length != 0 && msg !=null){
				layer.msg("${msg}");
			}
			
			//单个用户删除提示
			$("button.removeUser").click(function(){
				var deleteUserId = $(this).attr("userId");
				var deleteUsername = $(this).attr("username");
				console.log(deleteUserId);
				console.log(deleteUsername);
				layer.confirm("确认删除【"+deleteUsername+"】用户吗?",{btn:["确认","取消"]},function(){
					//设置删除表单的ids属性,
					$("#deleteUserForm input[name='ids']").val(deleteUserId);
					//通过form表单,提交要删除的id
					$("#deleteUserForm").submit();
				},function(){
				});
			});	
			
			//批量删除
			$("#batchDeleteUser").click(function(){
				console.log(1);
				var ids = "";
				var checkedCount = $(".selectBox:checked").length;
				//1、获取到所有需要删除的用户的id
				$(".selectBox:checked").each(function(){
					//组装需要的数据
					ids+=$(this).attr("userId")+",";
					
				});
				layer.confirm("确认批量删除这【"+checkedCount+"】个用户吗?",["确认","取消"],function(){
					//2、把这个id设置到需要提交的表单的name="ids"中
					$("#deleteUserForm input[name='ids']").val(ids);
					//3、提交表单
					$("#deleteUserForm").submit();
				},function(){});
			});
			
			
			//添加按钮单击事件，弹出模态框
			$("#addUserModalBtn").click(function(){
				$("#userAddModal").modal({
					show:true,
					backdrop:'static'
				});
			});
			
			//全选或全不选
			$("#selectAll").click(function(){
				$(".selectBox").prop("checked",$(this).prop("checked"));
			});
			//全选跟随
			$(".selectBox").click(function(){
				$("#selectAll").prop("checked",$(".selectBox").length==$(".selectBox:checked").length);
			});
		});
		
		//查询按钮单击事件
		$("#queryBtn").click(function(){
			//获取查询条件
			var condition = $("input[name='condition']").val();
			
			//设置将查询条件和查询页码保存到 查询表单中
			$("#queryUserForm").find("input[name='condition']").val(condition);
			$("#queryUserForm").find("input[name='pn']").val();
			
			//提交查询表单
			$("#queryUserForm").submit();
		});
		
	</script>
	
</body>
</html>
