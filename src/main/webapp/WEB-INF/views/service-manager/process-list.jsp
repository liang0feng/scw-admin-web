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
		pageContext.setAttribute("title", "流程管理");
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
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">

						<button type="button" class="btn btn-primary"
							style="float: right;" onclick="uploadBtnClick()">
							<i class="glyphicon glyphicon-upload"></i> 上传流程定义文件
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table id="processTable" class="table  table-bordered">
								<!--         <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-eye-open"></i></button> -->
								<!--         <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button> -->

							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 上传流程文件的表单 -->
	<!-- Modal -->
	<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">选择要上传的流程文件</h4>
				</div>
				<div class="modal-body">
					<form id="uploadForm" enctype="multipart/form-data" method="post">
						<input type="file" name="file" placeholder="上传 ">
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="uploadConfirmBtn" class="btn btn-primary">上传</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 引入common-js -->
	<%@include file="/WEB-INF/include/common-js.jsp"%>

	<script type="text/javascript">
	
		$(function() {
			//1、发送ajax请求加载页面的数据
			initProcessDefinitionData();
		});

		//发送ajax请求加载页面的数据
		function initProcessDefinitionData() {
			$.get("${ctp}/process/procs?i=" + Math.random(),function(data) {
				//处理数据
				//清除表格之前的数据
				//使用jquertDataTable显示
				table = $("#processTable").DataTable(
				{
					destroy : true,
					data : data.result,
					columns : [
						{
							data : "id",
							title : "#"
						},
						{
							data : "name",
							title : "流程定义名"
						},
						{
							data : "key",
							title : "流程key"
						},
						{
							data : "category",
							title : "分类"
						},
						{
							data : "tenantId",
							title : "发布者"
						},
						{
							data : "resourceName",
							title : "流程图片"
						},
						{
							defaultContent : "<button class='btn btn-success btn-xs glyphicon glyphicon-eye-open'></button>&nbsp;<button class='btn btn-danger btn-xs glyphicon glyphicon-remove'></button>",
							title : "操作",
							orderable : false,
							className : "btnGroup"
						} ],
					language : {
						info : "当前  _PAGE_ 页,总计 _TOTAL_ 记录"
					}
				});
			});
		}

		//上传流程文件按钮单击事件
		
		function uploadBtnClick() {
			$("#uploadModal").modal({
				backdrop : 'static',
				show : true
			});
		}

		//确认上传按钮单击事件
		$("#uploadConfirmBtn").click(function() {
			this.setAttribute("disabled","disabled");
			var fd = new FormData($("#uploadForm")[0]);
			var dataForm = document.getElementById("uploadForm");
			var $dataForm = $("#uploadForm");
			console.log(dataForm);
			console.log(fd);
			console.log($dataForm);
			//ajax版文件上传；1、创建FormData包装表单数据   2、设置contentType:false  3、设置processData:false,
			$.ajax({
				url : "${ctp }/process/uploadAndDeploy",
				type : "POST",
				contentType : false,//不要用默认的文件类型
				processData : false,//不要进行编码处理
				data : fd,//提交FormData对象
				success : function(data) {
					layer.msg(data.msg);
					//关闭模态框
					$("#uploadModal").modal("hide");
					initProcessDefinitionData();
				},
				error : function() {
					layer.msg("网络异常");
				}
			});
			
			this.removeAttribute("disabled","");
		});

		
		//绑定单击事件；
		$("#processTable").on("click","td .btn-success",function() {
			//alert(this);
			//alert(this);
			//var pid = $(this).parents("tr").find("td:eq(0)").text() ;
			var tr = $(this).closest('tr');
			//利用DataTable对象的.row(传入tr元素)直接锁定这一行；
			var data = table.row(tr).data();//拿到这一行之前需要对应的所有数据，即使没有显示出来
			//查出流程图；
			//所有的请求浏览器都会缓存，我们可以请求后面随机添加一个可变数
			layer.open({
				type : 1,
				offset : [ '100px', '300px' ],
				skin : 'layui-layer-rim', //加上边框
				content : '<img class="img-responsive" src="${ctp}/process/img?pdId='
						+ data.id
						+ '&time='
						+ Math.random() + '"/>'
			});

		});
	</script>
</body>
</html>
