<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<aside id="pf_sideBar">
	<!-- SNB // -->
	<ul id="pf_snb">
		<li class="snb bo_tablegallery  bo_tablegallery bo_tablegallery2 bo_tablegallery_box bo_tablegallery_box2  active show">
		<h2>
			<a href="${cPath}/homeintroduction" target="_self">
				<span style="font-size: 30px;">소개</span>
				<b>Introduction</b>
			</a>
		</h2>
		<ul class="pf_snb2dul">
			<c:forEach items="${introList}" var="menu">
				<li class="snb2d snb2d_bo_tablegallery active show">
					<a href="<c:url value='${menu.menuURL}'/>" target="_self">
						<b>
							<i class="fa fa-angle-right"></i>
							${menu.menu}
						</b>
					</a>
				</li>
			</c:forEach>
		</ul>
		</li>
		<li class="snb noInfoPageTit hide"></li>
	</ul>
	</aside>