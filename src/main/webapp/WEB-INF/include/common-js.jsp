<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctp}/static/jquery/jquery-2.1.1.min.js"></script>
<script src="${ctp}/static/bootstrap/js/bootstrap.min.js"></script>
<script src="${ctp}/static/script/docs.min.js"></script>

<!--1、引入校验框架  -->
<script src="${ctp}/static/jquery-validation-1.13.1/dist/jquery.validate.min.js"></script>
<!-- 2、引入前端ztree框架 -->
<script src="${ctp}/static/ztree/jquery.ztree.all-3.5.min.js"></script>
<script src="${ctp}/static/layer/layer.js"></script>

<script type="text/javascript" src="${ctp}/static/DataTables/datatables.min.js"></script>

<script type="text/javascript">
	//修改图标的数字代码
	$(function() {
		$(".parentMenu").each(function() {
			//修改父菜单，小圆圈数字动态显示
			var length = $(this).find("li").length;
			$(this).find("span.badge").text(length);
		});
	});
	//菜单展开关闭切换
	$(function() {
		$(".list-group-item").click(function() {
			if ($(this).find("ul")) {
				$(this).toggleClass("tree-closed");
				console.log(1);
				if ($(this).hasClass("tree-closed")) {
					$("ul", this).hide("fast");
				} else {
					$("ul", this).show("fast");
				}
			}
		});
	});
	//菜单高亮
	$(function() {
		var name = "${title}";
// 		if (name == "") {
// 			name = "null";
// 		}
		console.log(2);
		//找到a标签，标红
		$("a:contains(" + name + "):not('.navbar-brand')").css("color", "red");
		//让父ul展开
		$("a:contains(" + name + ")").parent().parent().show();
		//解决点2次才隐藏的bug；
		$("a:contains(" + name + ")").parent().parent().parent().toggleClass(
			"tree-closed");
	});
</script>