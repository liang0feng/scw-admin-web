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
	<%
		pageContext.setAttribute("title", "角色维护");
	%>

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
							<i class="glyphicon glyphicon-th-large"></i> 角色列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;"  action="${ctp}/role/list.html">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text" name="condition"
										placeholder="请输入查询条件" value="${condition}">
								</div>
							</div>
							<button type="submit" class="btn btn-warning" id="queryBtn"> 
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary" id="addRoleBtn"
							style="float: right;">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="50">序号</th>
										<th width="30"><input type="checkbox"></th>
										<th>名称</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${pageInfo.list }" var="role">
										<tr>
											<td>${role.id }</td>
											<td><input type="checkbox"></td>
											<td>${role.name }</td>
											<td>
												<button type="button" roleId="${role.id}"
													class="btn btn-success btn-xs assignPermissionBtn">
													<i class=" glyphicon glyphicon-check"></i>
												</button>
												<button type="button" class="btn btn-primary btn-xs">
													<i class=" glyphicon glyphicon-pencil"></i>
												</button>
												<button type="button" id="deleteBtn" roleId="${role.id }" class="btn btn-danger btn-xs" onclick="removeClick()">
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
												<c:if test="${!pageInfo.isFirstPage}">
													<li><a
														href="${ctp }/role/list.html?pn=${pageInfo.prePage}">上一页</a></li>
												</c:if>
												<c:forEach items="${pageInfo.navigatepageNums}"
													var="pageNum">
													<c:if test="${pageInfo.pageNum == pageNum}">
														<li class="active"><a
															href="${ctp }/role/list.html?pn=${pageInfo.pageNum}">${pageInfo.pageNum}
																<span class="sr-only">(current)</span>
														</a></li>
													</c:if>


													<c:if test="${pageInfo.pageNum != pageNum}">
														<li><a
															href="${ctp }/role/list.html?pn=${pageInfo.pageNum}">${pageNum}</a></li>
													</c:if>

												</c:forEach>

												<c:if test="${!pageInfo.isLastPage}">
													<li><a
														href="${ctp }/role/list.html?pn=${pageInfo.nextPage}">下一页</a></li>
												</c:if>
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


	<!-- 角色新增模态框 -->
	<!-- Large modal -->
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
		aria-labelledby="addRoleModal" id="addRoleModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增角色</h4>
					</br>
				</div>

				<div class="modal-body">
					<form id="addRoleModalForm" action="${ctp}/role/add" method="post">
						<div class="form-group">
							<label for="recipient-name" class="control-label">新增角色名称:</label>
							<input type="text" name="roleName" value="" class="form-control"
								placeholder="输入新增角色名称，如：PM-项目经理">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">取消</button>
							<button type="submit" class="btn btn-primary">确定</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- 角色权限分配模态框 -->
	<div class="modal fade" id="rolePermissionAssignModal" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">权限分配列表</h4>
					</br>
					<button class="btn btn-success">分配许可</button>
				</div>
				<div class="modal-body">
					<ul class="ztree" id="rolePermissionZtree"></ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-success"
						id="rolePermissionUpdateBtn">修改</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 引入common-js -->
	<%@include file="/WEB-INF/include/common-js.jsp"%>


	<script type="text/javascript">
		var zTreeObj; //角色权限树对象
		var roleId = "";//要修改角色的id

		//页面加载完成之后，初始化modal中的ztree权限树
		$(function() {
			initPerimssionTree();
		})
		function initPerimssionTree() {
			var setting = {
				data : {
					simpleData : {
						enable : true,
						idKey : "id",
						pIdKey : "pid",
						rootPId : null
					},
					key : {
						url : "xUrl"
					},
					view : {
						addDiyDom : permissionTreeView
					}

				},
				check : {
					enable : true
				}
			}

			$.get("${ctp}/permission/getAllPermission", function(data) {
				zTreeObj = $.fn.zTree.init($("#rolePermissionZtree"), setting,
						data);
				zTreeObj.expandAll(true);
			});
		}

		//单击弹出权限分配列表modal框
		$(".assignPermissionBtn").click(function() {
			//1.清除之前勾选框
			zTreeObj.checkAllNodes(false);

			//获取单击角色的id
			roleId = $(this).attr("roleId");
			//2.根据角色roleId查询角色拥有的权限的permissionId,并勾选
			$.get("${ctp}/role/getPermissionByRoleId", {
				"id" : roleId
			}, function(data) {
				$.each(data, function() {
					var node = zTreeObj.getNodeByParam("id", this.id, null);
					zTreeObj.checkNode(node, true, false);
				});

			});

			//3.弹出modal
			$("#rolePermissionAssignModal").modal({
				show : true,
				backdrop : 'static'
			});
		});

		//自定义ztree显示效果；每一个节点需要显示的时候都会触发
		function permissionTreeView(treeId, treeNode) {
			var span = "<span class='" + treeNode.icon + "'><span>";
			$("#" + treeNode.tId + "_ico").removeClass();
			$("#" + treeNode.tId + "_ico").after(span);
		}

		//角色权限修改按钮单击事件
		$("#rolePermissionUpdateBtn").click(function() {

			//Ajax发送勾选项的PermissionId，返回修改后的PermissionId

			var pid = "";//修改后的角色选中的PermissionId
			//获取所有勾选的节点集合
			var checkedNodes = zTreeObj.getCheckedNodes(true);

			$.each(checkedNodes, function() {
				pid += (this.id + ",");
			});
			//提交请求，请求参数rid,permissionIds权限id字符串
			$.get("${ctp}/role/updatePermission", {
				"roleId" : roleId,
				"permissionIds" : pid
			}, function(data) {
				//1.清空之前勾选项
				zTreeObj.checkAllNodes(false);
				$.each(data, function() {
					//2.根据data返回数据，勾选修改后的权限
					var node = zTreeObj.getNodeByParam("id", this.id, null);
					zTreeObj.checkNode(node, true, false);
					layer.msg("修改成功!");
				});
			});
		});
		
		//新增单击事件：弹出新增角色模态框
		$("#addRoleBtn").click(function(){

			//弹出新增模态框
			$("#addRoleModal").modal({
				backdrop:'static',
				show:true
			});
		});
		
		//页面加载完成之后的，增删改提示信息
		$(function(){
			var msg = "${msg}";
			if (msg != null && msg != "") {
				layer.msg("页面加载完成之后 ");
			}
		});
		
		//单个删除的按钮的单击事件：
		function removeClick(){
// 			window.onclick.href='${ctp}/role/delete?rid=${role.id}&pn=${pageInfo.pageNum}'
			//获取要删除的roleId
			var roleId = $("#deleteBtn").attr("roleId");
			//获取当前页面
			var pn = "${param.pn}";
			if (pn == "" || pn == null) {
				pn = 1;
			}
			alert("roleId:"+roleId);
			alert("pn:"+pn);
			layer.msg("removeClick");
 			location.href="${ctp}/role/delete?rid="+roleId + "&pn=" + pn;
		};
		
	</script>
</body>
</html>
