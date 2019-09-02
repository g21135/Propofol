<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<nav class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top" id="manageNav">
  <div class="container">
    <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarDefault"
      aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
      <span></span>
      <span></span>
      <span></span>
    </button>
    <a class="navbar-brand text-brand nav-item dropdown" href='<c:url value="/"/>'><span class="color-e">Pro</span><span class="color-b">pofol</span></a>
    <div class="navbar-collapse collapse justify-content-center" id="navbarDefault">
    <c:choose>
		<c:when test="${sessionScope.authMember.mem_id eq 'root'}">
	      <ul class="navbar-nav">
	       <li class="nav-item dropdown">
	           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
	             aria-haspopup="true" aria-expanded="false"><span class="color-e">회원 포트폴리오 관리</span></a>
	           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
	             <a class="dropdown-item" href="<c:url value='/allMemPort'/>">전체 회원 포트폴리오 리스트</a>
	             <a class="dropdown-item" href="<c:url value='/sucMemPort'/>">성공한 포트폴리오 리스트</a>
	             <a class="dropdown-item" href="<c:url value='/blackMemPort'/>">부적절한 포트폴리오 리스트</a>
	           </div>
	       </li>
	       <li class="nav-item dropdown">
	           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
	             aria-haspopup="true" aria-expanded="false"><span class="color-e">주문 관리</span></a>
	           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
	             <a class="dropdown-item" href="<c:url value='/orderPortfolio'/>">신청 관리</a>
	             <a class="dropdown-item" href="<c:url value='/order_producePortfolio'/>">제작중인 포트폴리오 관리</a>
	             <a class="dropdown-item" href="<c:url value='/order_modifyPortfolio'/>">수정중인 포트폴리오 관리</a>
	           </div>
	       </li>
	      </ul>
      	</c:when>
      	<c:otherwise>
      		<ul class="navbar-nav">
		       <li class="nav-item dropdown">
		           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
		             aria-haspopup="true" aria-expanded="false"><span class="color-e">포트폴리오관리</span></a>
		           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		             <a class="dropdown-item" href="<c:url value='/myPortfolio'/>">제작 포트폴리오</a>
		           </div>
		       </li>
		       <li class="nav-item dropdown">
		           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
		             aria-haspopup="true" aria-expanded="false"><span class="color-e">서비스이용내역</span></a>
		           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		             <a class="dropdown-item" href="<c:url value='/myOrder'/>">주문내역</a>
		           </div>
		       </li>
		     </ul>
      	</c:otherwise>
      </c:choose>
    </div>
 
	<div id="userInfo">
	    <div class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
	            aria-haspopup="true" aria-expanded="false">
	   			<span class="color-e"><span class="fa fa-user" aria-hidden="true">${sessionScope.authMember.mem_name}</span></span>
		</a>
			<c:choose>
				<c:when test="${sessionScope.authMember.mem_id eq 'root'}">
				  <div style="left: -65px; min-width: 100px;" id="loginMenu" class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 50px;">
					<a class="dropdown-item" href="<c:url value='/login'/>">로그아웃</a>
		            <a class="dropdown-item" href="<c:url value='member/manager/${sessionScope.authMember.mem_id}'/>">관리자 페이지</a>
		            <a class="dropdown-item" href=''>포트폴리오 관리</a>
		          </div>
				</c:when>
				<c:when test="${not empty sessionScope.authMember}">
				  <div style="left: -65px; min-width: 100px;" id="loginMenu" class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 50px;">
					<c:choose>
						<c:when test="${empty sessionScope.authMember['login_type']}">
							<a class="dropdown-item" href="<c:url value='/login'/>">로그아웃</a>
						</c:when>
						<c:when test="${sessionScope.authMember['login_type'] == 1}">
							<a class="dropdown-item" href="<c:url value='/kakao'/>">로그아웃</a>
						</c:when>
						<c:when test="${sessionScope.authMember['login_type'] == 2}">
							<a class="dropdown-item" href="<c:url value='/naverLogout'/>">로그아웃</a>
						</c:when>
					</c:choose>
					<a class="dropdown-item" href="<c:url value='/member/members/${sessionScope.authMember.mem_id }'/>">마이페이지</a>
		            <a class="dropdown-item" href="<c:url value='/managementPort'/>">포트폴리오 관리</a>
		          </div>
				</c:when>
				<c:otherwise>
		          <div style="left: -65px; min-width: 100px;" id="loginMenu" class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 50px;">
		            <a class="dropdown-item" href='' data-toggle="modal" data-target="#myModal">로그인</a>
		            <a class="dropdown-item" href=''>회원가입</a>
		          </div>
				</c:otherwise>
			</c:choose>  
		</div>
    </div>
  </div>
</nav>