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
</style>
</head>

<body>

	<%
		pageContext.setAttribute("title", "许可维护");
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
						<i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<ul id="permissionTree" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!--修改菜单内容  -->
	<div class="modal fade" id="permissionEditModal" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改菜单信息</h4>
				</div>
				<div class="modal-body">
					<form id="permissionEditForm" action="${ctp }/permission/update"
						method="post">
						<!-- 菜单的id -->
						<input type="hidden" name="_method" value="PUT" />
						<input type="hidden" name="id" value=""/>
						<div class="form-group">
							<label>菜单名</label> <input type="text" class="form-control"
								name="name">
						</div>
						<div class="form-group">
							<label>菜单图标</label>
							<div class="input-group">
								<input type="text" class="form-control" name="icon">
								<div class="input-group-addon">.00</div>
							</div>
						</div>
						<div class="form-group">
							<label>菜单地址</label> <input type="text" class="form-control"
								name="url">
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<!-- 提交修改表单  -->
					<button type="button" class="btn btn-primary" id="permissionEditBtn" >修改</button>
				</div>
			</div>
		</div>
	</div>

	<!--添加新的菜单  -->
	<div class="modal fade" id="permissionAddModal" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加新的菜单</h4>
				</div>
				<div class="modal-body">
					<form id="permissionAddForm" action="${ctp }/permission/add"
						method="post">
						<!-- 父菜单的id -->
						<input type="hidden" name="pid" value="" />
						<div class="form-group">
							<label>菜单名</label> <input type="text" class="form-control"
								name="name">
						</div>
						<div class="form-group">
							<label>菜单图标</label>
							<div class="input-group">
								<input type="text" class="form-control" name="icon">
								<div class="input-group-addon">.00</div>
							</div>
						</div>
						<div class="form-group">
							<label>菜单地址</label> <input type="text" class="form-control"
								name="url">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="permissionAddBtn">添加</button>
				</div>
			</div>
		</div>
	</div>
	<form id="permissionDeleteForm" action="" method="post">
		<!-- 父菜单的id -->
		<input type="hidden" name="_method" value="delete" />
	</form>

	<!-- 引入common-js -->
	<%@include file="/WEB-INF/include/common-js.jsp"%>

	<script type="text/javascript">
		var ztreeObject;
		$(function() {
			//就调用自定义初始化权限树方法
			initPermissionTree();
		});
		//自定义ztree显示效果；每一个节点需要显示的时候都会触发
		function permissionTreeView(treeId, treeNode) {
			var span = "<span class='" + treeNode.icon + "'><span>";
			$("#" + treeNode.tId + "_ico").removeClass();
			$("#" + treeNode.tId + "_ico").after(span);
		}

		function initPermissionTree() {
			var setting = {
				data : {
					simpleData : {
						enable : true,
						pIdKey : "pid"
					},
					key : {
						//禁用跳转
						url : "null"
					}
				},
				view : {
					//自定义ztree的显示
					addDiyDom : permissionTreeView,
					//鼠标移动到节点上后显示自定义元素
					addHoverDom : showCrudBtn,
					removeHoverDom : removeCrudBtn
				}
			};
			/* fa fa-fw fa-sitemap glyphicon glyphicon-home*/
			var zNodes = [ {
				id : 0,
				name : "系统权限菜单",
				icon : "fa fa-fw fa-sitemap"
			} ];
			$.get("${ctp}/permission/getAllPermission", function(data) {
				console.log(data);
				//合并数组数据
				zNodes = zNodes.concat(data);
// 				console.log(zNodes);
				//初始化权限树
				ztreeObject = $.fn.zTree.init($("#permissionTree"), setting,
						zNodes);
				//每一个节点默认全部展开；
				ztreeObject.expandAll(true);
			});
		}

		//鼠标放在元素上的回调，用来显示每个菜单的CRUD按钮；
		function showCrudBtn(treeId, treeNode) {
			//console.log(treeNode.name+" 鼠标放在上面了");
			var btnAdd = "<button  class='btn btn-primary btn-xs'><span class='glyphicon glyphicon-plus'></span></button>";
			var btnRemove = "<button  class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-remove'></span></button>";
			var btnEdit = "<button class='btn btn-warning btn-xs'><span class='glyphicon glyphicon-pencil'></span></button>";

			//0、根菜单，只有元素添加
			if (treeNode.pid == null) {
				//整个按钮组
				var span = $("<span id='crudBtnGroup' nodeId='"+treeNode.id+"'></span>");
				//按钮组里面先放一个添加按钮
				span.append(btnAdd);
				//找到当前节点所在的a标签
				if ($("#" + treeNode.tId + "_a").nextAll("#crudBtnGroup").length == 0) {
					$("#" + treeNode.tId + "_a").after(span);
				}
				;
			}
			//1、如果是父菜单，并且没有子元素。显示完整的增删改
			if (treeNode.pid == 0 && treeNode.isParent == false) {
				var span = $("<span id='crudBtnGroup' nodeId='"+treeNode.id+"'></span>");
				span.append(btnEdit).append(" ").append(btnRemove).append(" ")
						.append(btnAdd);
				if ($("#" + treeNode.tId + "_a").nextAll("#crudBtnGroup").length == 0) {
					$("#" + treeNode.tId + "_a").after(span);
				}
				;
			}
			//2、如果是父菜单，有子元素。显示增改。
			if (treeNode.pid == 0 && treeNode.isParent == true) {
				var span = $("<span id='crudBtnGroup' nodeId='"+treeNode.id+"'></span>");
				span.append(btnEdit).append(" ").append(btnAdd);
				if ($("#" + treeNode.tId + "_a").nextAll("#crudBtnGroup").length == 0) {
					$("#" + treeNode.tId + "_a").after(span);
				}
				;
			}
			//3、如果是子菜单，只能删除和修改。
			if (treeNode.pid > 0 && treeNode.isParent == false) {
				var span = $("<span id='crudBtnGroup' nodeId='"+treeNode.id+"'></span>");
				span.append(btnEdit).append(" ").append(btnRemove);
				if ($("#" + treeNode.tId + "_a").nextAll("#crudBtnGroup").length == 0) {
					$("#" + treeNode.tId + "_a").after(span);
				}
				;
				return;
			}
		}

		//鼠标移出元素上的回调，用来移出每个菜单的CRUD按钮；
		function removeCrudBtn(treeId, treeNode) {
			//移除这个按钮上的btn按钮组
			$("#" + treeNode.tId + "_a").nextAll("#crudBtnGroup").remove();
		}
		
		
		//第一次给body绑事件；如果body里面的东西点击了，浏览器看是不是选择器规定的元素，如果是调用（第三个）回调函数
		$("body").on("click","#crudBtnGroup",function(event) {
					//事件的所有详情都在event里面；
					//修改效果
					if ($(event.target).is(".glyphicon-pencil")) {
						$('#permissionEditModal').modal({
							show : true,
							backdrop : 'static'
						});
						//去ztree查出这个节点封装的所有详细信息
						
						
						var node = ztreeObject.getNodeByParam("id", $(this).attr("nodeid"), null);
						$("#permissionEditForm").find("input[name='id']").val(node.id);
						$("#permissionEditForm").find("input[name='name']").val(node.name);
						$("#permissionEditForm").find("input[name='url']").val(node.url);
						$("#permissionEditForm").find("input[name='icon']").val(node.icon);
					};

					//添加效果
					if ($(event.target).hasClass("glyphicon-plus")) {
						//弹出添加的模态框
						$('#permissionAddModal').modal({
							show : true,
							backdrop : 'static'
						});

						//找到当前点击了哪个ztree节点，获取到这个节点的id，就是模态框里面的pid
						//this=当前点击的按钮
						/* var ztreeNodeA = $(this).prev();//找到属于ztree的这个元素
						var str = ztreeNodeA.attr("id");
						//获取到了tId的值
						var tId = str.substring(0,str.length-2);
						var id = ztreeObject.getNodeByParam("tId", tId, null).id;
						 */
						//console.log(this.nodeid);
						$('#permissionAddModal').find("input[name='pid']").val($(this).attr("nodeId"));
					};
					
					//删除菜单
					if ($(event.target).is(".glyphicon-remove")) {
						var del_id = $(this).attr("nodeid");
						var node = ztreeObject.getNodeByParam("id", $(this).attr("nodeid"), null);
						//js里面的this会有漂移现象；
						layer.confirm('确认删除菜单【'+node.name+'】吗？', {btn: ['确认','算了']},
							function(){
								//改变提交地址
								$("#permissionDeleteForm").attr("action","${ctp}/permission/delete/"+del_id);
								//提交表单
								$("#permissionDeleteForm").submit();
							},function(){
								layer.msg("不删算了...");
						});
						
					}
				});

		//点击添加提交表单
		$("#permissionAddBtn").click(function() {
			//提交表单
			console.log("添加");
			$("#permissionAddForm").submit();
		});
		
		$("#permissionEditBtn").click(function() {
			//提交表单
			console.log(1);
			$("#permissionEditForm").submit();
		});
		
		
	</script>
</body>

</html>