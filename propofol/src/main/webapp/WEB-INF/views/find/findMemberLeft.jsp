<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class ="pf_sideBar">
	<ul id="pf_snb">
		<li class="snb bo_tablegallery  bo_tablegallery bo_tablegallery2 bo_tablegallery_box bo_tablegallery_box2  active show"><h2>
				<a href="${cPath }/find/findMember" target="_self">
				<span>아이디/비밀번호</span>
					<b>찾기</b>
				</a>
			</h2>
			<em class="snb2dDown">
				<i class="fa fa-angle-down"></i>
				<u class="fa fa-angle-up"></u>
			</em>
		<ul class="pf_snb2dul">
			<li class="snb2d snb2d_bo_tablegallery active show">
				<a href="<c:url value='/find/findMember/userId'/>" target="_self">
					<b>
						<i class="fa fa-angle-right"></i>
						아이디 찾기
					</b>
				</a>
			</li>
			<li class="snb2d snb2d_bo_tablegallery active show">
				<a hr.	ef="<c:url value='/find/findMember/userPw'/>" target="_self">
					<b>
						<i class="fa fa-angle-right"></i>
						비밀번호 찾기
					</b>
				</a>
			</li>
		</ul>
	</li>
</ul>
</div>