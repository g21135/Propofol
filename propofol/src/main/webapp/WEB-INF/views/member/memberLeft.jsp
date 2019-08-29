<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class ="pf_sideBar">
	<ul id="pf_snb">
		<li class="snb bo_tablegallery  bo_tablegallery bo_tablegallery2 bo_tablegallery_box bo_tablegallery_box2  active show"><h2>
		<c:choose>
			<c:when test="${sessionScope.authMember.gr_num ne 3 }">
				<a href="${cPath }/member/manager/${sessionScope.authMember.mem_id}" target="_self">
				<span>관리자페이지</span>
					<b>AdminPage</b>
				</a>
			</c:when>
			<c:otherwise>
				<a href="${cPath }/member/members/${sessionScope.authMember.mem_id}" target="_self">
				<span>마이페이지</span>
					<b>MyPage</b>
				</a>
			</c:otherwise>
		</c:choose>
			</h2>
			<em class="snb2dDown">
				<i class="fa fa-angle-down"></i>
				<u class="fa fa-angle-up"></u>
			</em>
		<ul class="pf_snb2dul">
			<c:choose>
				<c:when test="${sessionScope.authMember.gr_num ne 3 }">
					<c:forEach items="${adminList }" var="menu">
						<li class="snb2d snb2d_bo_tablegallery active show">
							<a href="<c:url value='${menu.menuURL }/${sessionScope.authMember.mem_id }'/>" target="_self">
								<b>
									<i class="fa fa-angle-right"></i>
									${menu.menu }
								</b>
							</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach items="${menuList }" var="menu">
						<c:choose>
							<c:when test="${empty sessionScope.authMember['login_type'] }">
								<li class="snb2d snb2d_bo_tablegallery active show">
									<a href="<c:url value='${menu.menuURL }/${sessionScope.authMember.mem_id }'/>" target="_self">
										<b>
											<i class="fa fa-angle-right"></i>
											${menu.menu }
										</b>
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="snb2d snb2d_bo_tablegallery active show">
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</ul>
	</li>
</ul>
</div>
