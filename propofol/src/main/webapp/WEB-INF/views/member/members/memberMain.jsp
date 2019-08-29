<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
<c:if test="${not empty message}">
	alert("${message}");
	<c:remove var="message" scope="session"/>
</c:if>
</script>
<div id="register_form"  class="mp_form">   
	<div class="mp_btn_confirm" style="float : left">
		<c:choose>
		<c:when test="${empty sessionScope.authMember.mem_image}">
			<img alt="회원프로필" src="${cPath }/img/iu5.jpg" style="width: 200px; height: 200px; border-radius: 50%;" >
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${sessionScope.authMember['login_type'] == 1 }">
					<p>
						<img alt="회원프로필" src="${mv.mem_image}" style="width: 200px; height: 200px; border-radius: 50%;">
					</p>
				</c:when>
				<c:when test="${sessionScope.authMember['login_type'] == 2 }">
					<p>
						<img alt="회원프로필" src="${mv.mem_image}" style="width: 200px; height: 200px; border-radius: 50%;">
					</p>
				</c:when>
				<c:otherwise>
					<p>
						<img alt="회원프로필" src="${cPath }/img/profile/${mv.mem_image }" style="width: 200px; height: 200px; border-radius: 50%;">
					</p>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
		</c:choose>
		<div>
			<p><span style="font-size: 1.5em;">${mv.mem_name } 님</span></p>
		</div>
	</div>
		<div id="mp_container" style="display: table-caption; margin-left : 50px; float:none">
			<div>
	        <h2>회원 정보</h2>
		        <ul>
					<li>
						<label for="reg_mb_id" class="sound_only">아이디</label>
						<input type="text" name="mb_id" 
							value="${mv.mem_id }" id="reg_mb_id" required  class="mp_frm_input half_input " maxlength="20"	>
						<span id="msg_mb_id"></span>
					</li>
		            <li>
		                <label for="reg_mb_email" class="sound_only">이메일</label>
		                <input type="email" name="mb_password" 
		                	value="${sessionScope.authMember.mem_mail }"	id="reg_mb_email" required class="mp_frm_input half_input" maxlength="20"
		                 >
		            </li>
				</ul>
			</div>
			<c:choose>
				<c:when test="${sessionScope.authMember['login_type'] == 1 }">
					<div style="float: left;">
						<p><span style="font-size: 1.5em;">Kakao로그인 회원입니다.</span></p>
					</div>
				</c:when>
				<c:when test="${sessionScope.authMember['login_type'] == 2 }">
					<div style="float: left;">
						<p><span style="font-size: 1.5em;">Naver로그인 회원입니다.</span></p>
					</div>
				</c:when>
				<c:otherwise>
					<div style="float: left;">
					 <ul class="notice_v_com">
						<li style="width : 60px"><button class="list_btn btn" id="goPage" style="width : 118px; height : 42px" data-toggle="modal" data-target="#passModal"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>회원정보수정</button></li>
					</ul>
					</div>
				</c:otherwise>
			</c:choose>
	    </div>
</div>

<div class="modal fade modal-sm" id="passModal" role="dialog">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content modal-sm">
      <div class="modal-header">
        <h5 class="modal-title">비밀번호 입력♥</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="chkForm" method="post" action="<c:url value='/member/members/memberContent'/>">
	     	<input type="hidden" name="mem_id" value="${mv.mem_id }"/>
    	<div class="modal-body">
        	<table class="table table-border">
				<tr>
					<th><label>비밀번호<input type="password" name="mem_pass" id="modifyPass" class="form-control" /></label></th>
				</tr>
			</table>
	      </div>
	      <div class="modal-footer">
	      	<input type="submit" value="확인" class="mp_btn_submit">
	        <button type="button" class="mp_btn_cancel" data-dismiss="modal">닫기</button>
	      </div>	
      </form>
    </div>
  </div>
</div>
<script>
var chkForm = $('#chkForm');
var modifyPass = $('#modifyPass');

chkForm.on('submit', function(){
	if(modifyPass.val().trim() == "" || modifyPass.val().trim().length == 0){
		alert("비밀번호를 입력해주세요!!");
		return false;
	}
});
</script>