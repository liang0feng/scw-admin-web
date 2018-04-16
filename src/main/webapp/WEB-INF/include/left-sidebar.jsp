<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-sm-3 col-md-2 sidebar">
	<div class="tree">
		<ul style="padding-left: 0px;" class="list-group">
			<li class="list-group-item tree-closed"><a
				href="${ctp }/main.html"><i
					class="glyphicon glyphicon-dashboard"></i> 控制面板</a></li>

			<!-- 遍历显示菜单 -->
			<c:forEach items="${userMenus }" var="parentMenu">
				<c:if test="${parentMenu.pid == 0 }">
					<li class="parentMenu list-group-item tree-closed">
						<span><i class="${parentMenu.icon }"></i> ${parentMenu.name }
							<span class="badge" style="float: right">3</span>
						</span>
						<ul style="margin-top: 10px; display: none;">
							<!-- 遍历所有菜单 -->
							<c:forEach items="${userMenus }" var="childMenu">
								<!-- 父菜单 -->
								<c:if test="${childMenu.pid == parentMenu.id }">
									<!-- 遍历到子菜单 -->
									<li style="height: 30px;">
										<a href="${ctp}/${childMenu.url}"> <i class="${childMenu.icon}"></i> ${childMenu.name }</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>