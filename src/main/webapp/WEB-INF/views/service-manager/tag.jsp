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
		pageContext.setAttribute("title", "项目标签");
	%>

	<!-- 引入顶部导航栏 -->
	<%@include file="/WEB-INF/include/top-navbar.jsp"%>


	<div class="container-fluid">
		<div class="row">

			<!-- 引入左侧控制面板 -->
			<%@include file="/WEB-INF/include/left-sidebar.jsp"%>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-th-list"></i> 项目标签列表
					</div>
					<div class="panel-body">
						<ul id="projectTagTree" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- Modal -->
	<div class="modal fade" id="addTagModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加标签</h4>
				</div>
				<div class="modal-body">
					<form id="permissionAddForm"
						action="${ctp }/serviceManager/addProjectTag" method="post">
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
					<button type="button" class="btn btn-primary">添加</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="updataTagModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改标签</h4>
				</div>
				<div class="modal-body">
					<form id="permissionAddForm"
						action="${ctp }/serviceManager/updataProjectTag" method="post">
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
					<button type="button" class="btn btn-primary">修改</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Button trigger modal -->
	<button type="button" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal">Launch demo modal
	</button>

	<!-- 引入公共js：common-js -->
	<%@include file="/WEB-INF/include/common-js.jsp"%>

	<script type="text/javascript">
		$(function() {
			//初始化权限树
			initTagTree();
		});
		//初始化ztree   
		function initTagTree() {
			// 				<span id="btnGrouptreeDemo_1"><a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a></span>
			// 		    	 //定义按钮组
			// 		    	 var span = '<span id="BtnGroup"></span>';
			// 		    	 //增 删除  修改按钮
			// 		    	 var AddBtn = '';

			var setting = {
				data : {
					simpleData : {
						enable : true,
						pIdKey : "pid"
					}
				},
				view : {
					//自定义图标 
					addDiyDom : function(treeId, treeNode) {
						$("li").find("a:first").find("span:first").attr(
								"class", "glyphicon glyphicon-tag");
					},
					//鼠标移入
					addHoverDom : function(treeId, treeNode) {
						// 							//console.log(treeNode.name+" 鼠标放在上面了");
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
							if ($("#" + treeNode.tId + "_a").nextAll(
									"#crudBtnGroup").length == 0) {
								$("#" + treeNode.tId + "_a").after(span);
							}
							;
						}
						//1、如果是父菜单，并且没有子元素。显示完整的增删改
						if (treeNode.pid == 0 && treeNode.isParent == false) {
							var span = $("<span id='crudBtnGroup' nodeId='"+treeNode.id+"'></span>");
							span.append(btnEdit).append(" ").append(btnRemove)
									.append(" ").append(btnAdd);
							if ($("#" + treeNode.tId + "_a").nextAll(
									"#crudBtnGroup").length == 0) {
								$("#" + treeNode.tId + "_a").after(span);
							}
							;
						}
						//2、如果是父菜单，有子元素。显示增改。
						if (treeNode.pid == 0 && treeNode.isParent == true) {
							var span = $("<span id='crudBtnGroup' nodeId='"+treeNode.id+"'></span>");
							span.append(btnEdit).append(" ").append(btnAdd);
							if ($("#" + treeNode.tId + "_a").nextAll(
									"#crudBtnGroup").length == 0) {
								$("#" + treeNode.tId + "_a").after(span);
							}
							;
						}
						//3、如果是子菜单，只能删除和修改。
						if (treeNode.pid > 0 && treeNode.isParent == false) {
							var span = $("<span id='crudBtnGroup' nodeId='"+treeNode.id+"'></span>");
							span.append(btnEdit).append(" ").append(btnRemove);
							if ($("#" + treeNode.tId + "_a").nextAll(
									"#crudBtnGroup").length == 0) {
								$("#" + treeNode.tId + "_a").after(span);
							}
						}
					},
					//鼠标移出
					removeHoverDom : function(treeId, treeNode) {
						//移除这个按钮上的btn按钮组
						$("#" + treeNode.tId + "_a").nextAll("#crudBtnGroup")
								.remove();
					}
				}
			}

			//2.初始化树的所需的data数据:通过ajax请求获取所有标签
			$.get("${ctp}/serviceManager/getAllTag", function(data) {
				ztreeObject = $.fn.zTree.init($("#projectTagTree"), setting,
						data);
				//每一个节点默认全部展开；
				ztreeObject.expandAll(true);
			});
		}

		//给#crudBtnGroup未来内容添加单击事件
		$("body").on("click", "#crudBtnGroup", function(event) {
			console.log($(event.target).attr("class"));
			//添加单击事件
			if ($(event.target).attr("class") == "glyphicon glyphicon-plus") {
				console.log("添加");
				$('#addTagModal').modal({
					show : true,
					backdrop : 'static'
				});
			}

			//删除单击事件
			if ($(event.target).attr("class") == "glyphicon glyphicon-remove") {
				console.log("删除");
			}

			//修改单击事件
			if ($(event.target).attr("class") == "glyphicon glyphicon-pencil") {
				console.log("修改");
				$('#updataTagModal').modal({
					show : true,
					backdrop : 'static'
				});
			}
		});
	</script>

</body>
</html>
