<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<!--/ Nav Star /-->
<nav class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top">

  <div class="container">
    <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarDefault"
      aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
    </button>
    <a class="navbar-brand text-brand nav-item dropdown" href='<c:url value="/"/>'>Pro<span class="color-b">pofol</span></a>
    <div class="navbar-collapse collapse justify-content-center" id="navbarDefault">
      <ul class="navbar-nav" id="navBar">
       <li class="nav-item dropdown">
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
             aria-haspopup="true" aria-expanded="false">INTRO</a>
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
             <a class="dropdown-item" href="<c:url value='/homeintroduction'/>">홈페이지 소개</a>
             <a class="dropdown-item" href="<c:url value='/directions'/>">오시는 길</a>
             <a class="dropdown-item" href="<c:url value='/instructions'/>">사용법</a>
             <a class="dropdown-item" href="<c:url value='/operationPolicy'/>">이용약관</a>
           </div>
       </li>
         <li class="nav-item">
           <a class="nav-link" href="<c:url value='/noticeBoards'/>">NOTICE</a>
         </li>
       <li class="nav-item dropdown">
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
             aria-haspopup="true" aria-expanded="false">PORTFOLIO</a>
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
             <a class="dropdown-item" href="<c:url value='/portfolioList'/>">열람</a>
	             <a id="makeBtn" class="dropdown-item" href='#'>제작</a>
             <a class="dropdown-item" href="">주문제작</a>
           </div>
       </li>
       <li class="nav-item dropdown">
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
             aria-haspopup="true" aria-expanded="false">COUMMUNITY</a>
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
             <a class="dropdown-item" href="<c:url value='/jobnews'/>">취업뉴스</a>
             <a class="dropdown-item" href="<c:url value='/recruit'/>">채용공고</a>
             <a class="dropdown-item" href="<c:url value='/PayList'/>">정보공유</a>
             <a class="dropdown-item" href="<c:url value='/freeBoards'/>">자유게시판</a>
           </div>
       </li>
       <li class="nav-item dropdown">
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
             aria-haspopup="true" aria-expanded="false">CUSTOMER</a>
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
             <a class="dropdown-item" href="<c:url value='/faq'/>">FAQ</a>
             <a class="dropdown-item" href="<c:url value='/qna'/>">QNA</a>
			<a class="dropdown-item" href="<c:url value='/suggest'/>">건의게시판</a>
           </div>
       </li>
      </ul>
    </div>
 	<div id="userInfo">
 		<c:if test="${not empty sessionScope.authMember}">
		 	<i id="alarm" tabindex="0" data-toggle="popover" class="far fa-bell" style="margin: 7px;font-size: 25px;float: left;cursor: pointer;">
				<span class="badge badge-danger" id="alarmSize" style="position: relative; top: -13px; right: 14px; border-radius: 50%; font-size: 13px;">
			 	</span>
		  	</i>
 		</c:if>
	    <div class="nav-item dropdown" style="float: left;">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
            aria-haspopup="true" aria-expanded="false">
   		   <span class="fa fa-user" aria-hidden="true">${sessionScope.authMember.mem_name}</span>
		  </a>
			<c:choose>
				<c:when test="${sessionScope.authMember.mem_id eq 'root'}">
				  <div style="left: 0px; min-width: 100px;" id="loginMenu" class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 50px;">
					<a class="dropdown-item" href="<c:url value='/login'/>">로그아웃</a>
		            <a class="dropdown-item" href="<c:url value='/member/manager/${sessionScope.authMember.mem_id }'/>">관리자 페이지</a>
		            <a class="dropdown-item" href="<c:url value='/managementPort'/>">포트폴리오 관리</a>
		          </div>
				</c:when>
				<c:when test="${not empty sessionScope.authMember}">
				  <div style="left: 0px; min-width: 100px;" id="loginMenu" class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 50px;">
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
					<a class="dropdown-item" href="<c:url value='/member/members/${sessionScope.authMember.mem_id}'/>">마이페이지</a>
		            <a class="dropdown-item" href="<c:url value='/managementPort'/>">포트폴리오 관리</a>
		          </div>
				</c:when>
				<c:otherwise>
		          <div style="left: 0px; min-width: 100px;" id="loginMenu" class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 50px;">
		            <a class="dropdown-item" href='' data-toggle="modal" data-target="#myModal">로그인</a>
		          </div>
				</c:otherwise>
			</c:choose>  
		</div>
    </div>
  </div>
</nav>
<!--/ Nav End /-->

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div id="loginModal" class="modal-body">
		<section class="container">
          <article class="half">
                 <h1>Propofol</h1>
	                 <div class="tabs">
                        <span class="tab signin active"><a href="#signin">Sign in</a></span>
                        <span class="tab signup"><a href="#signup">Sign up</a></span>
	                 </div>
	                 <div class="content">
                        <div class="signin-cont cont">
                               <form id="loginForm" action="${cPath}/login" method="post" enctype="multipart/form-data">
                                  <input type="text" name="mem_id" class="inpt more" required="required" placeholder="Your email">
                                  <input type="password" name="mem_pass" class="inpt more" required="required" placeholder="Your password">
                                  <input type="checkbox" id="remember" name="saveSession" class="checkbox more" value="check">
                                  <label for="remember">로그인 상태 유지</label>
                                  
                                  <div class="submit-wrap">
	                                    <!-- 네이버 로그인 -->
								       <a id="naver_id_login" href="${url}" class="inpt more"> 
									     <img style="width: 290px;"  alt ="네이버 로그인" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" />
									   </a>
										<!-- 카카오톡 로그인 -->
                                       <a id="kakaoLogin" class="inpt more" href="https://kauth.kakao.com/oauth/authorize?client_id=59b155def6f27f08bfa207c1585ff2a8&redirect_uri=http://localhost/kakao/kakaologin&response_type=code">
                                         <img style="width: 290px;" alt="카카오톡 로그인" src="${cPath}/img/kakao_account_login_btn_medium_narrow.png">
                                       </a>
                                       <input type="submit" value="L O G I N" class="submit more">
                                       <a href="<c:url value='/find/findMember/userId'/>" class="more">아이디 찾기</a>
                                       <a href="<c:url value='/find/findMember/userPw'/>" class="more">비밀번호 찾기</a>
                                   </div>
                               </form>
	                    </div>
	                     <!-- 회원가입 -->
                		<div class="signup-cont cont" style="overflow: overlay; height: 430px;">
                			<form id="joinForm" style="width: 90%;" action="${cPath }/member/members" method="post" enctype="multipart/form-data">
	                            <input type="text" name="mem_id" id="mem_id" class="inpt more" required="required" placeholder="Your ID">
								<div class="submit-wrap" id="wrap">
	                            	<input style="margin-bottom: 15px" id="idChk" type="button" value="아이디 중복 체크" class="submit more">
	                            </div>
	                            <input type="text" name="mem_name" id="memName" class="inpt more" required="required" placeholder="Your Name"
	                            onchange="nameChk()">
	                            <span id="nameChkText"></span>
	                            <input type="password" name="mem_pass" id="pass" class="inpt more" required="required" placeholder="Your Password"
	                            	onchange="isSame()">
	                            <span id="passChkText"></span>
	                            <input type="password" class="inpt more" id="rePassChk" required="required" placeholder="Password Check"
	                            	onchange="isSame()">
	                            <span id="rePassChkText"></span>
	                            <span id="gender_select" class ="more">
		                            <input type="radio" id="male" required name="mem_gen" value="M"/> 남  
		                            <input type="radio" id="female" required name="mem_gen" style="margin-left: 25px;" value="F"/> 여 
	                            </span>
	                            <input type="tel" name="mem_tel" id="memTell" class="inpt more" required="required" placeholder="Your Tell Number. ex)01012341234"
	                            onchange="tellChk()">
	                           	<span id="tellChkText"></span>
	          					<input type="email" name="mem_mail" id="memMail" class="inpt more" required="required" placeholder="Your Email. ex)asd123@gmail.com"
	          					onchange="mailChk()">
	                            <span id="mailChkText"></span>
					            <span id="img_select" class ="more" style="height:75px">
					                <span>Your Profile Image</span><br>
	                        		<input type="file" name="mem_img" required="required" style="width:200px">
				                </span>
				                <!-- reCAPTCHA -->
				                <div id="reCaptcha" class="g-recaptcha" 
									data-sitekey="6Ld3ybIUAAAAABEZ39A25fq674itxPNo-vrdElhP"
									data-theme="dark" data-type="image"
									style="transform:scale(0.85);transform-origin:0 0;margin-top:4px"
									>
								</div>
								<button id="test" type="button">확인</button>
				                <div class="submit-wrap">
				                	<input style="margin-bottom: 15px" id="cpactha" type="button" value="Sign Up" class="submit more" >
					            </div> 
						    </form>
           				</div>
	                 </div>
	          </article>
   			  <div class="half bg">
	          </div>	      
		   </section>       
      </div>
    </div>
  </div>
</div>

<!-- loginForm  -->
<link href="${cPath}/css/makePortfolio/before.css" rel="stylesheet">

<form id="makeBeforeForm" action="<c:url value='/makePortfolio'/>" method="post">
	<!-- Modal -->
	<div class="modal fade" id="makeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog" style="width: 800px">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      </div>
	      <div class="content" class="modal-body">
	      <img class="more beforeMain" src="${cPath}/img/makePortfolio/recommend.jpg" style="float: left;">
	    	  <div style="display: inline-block;">
			      <div class="text">
				      <p>1. 자신의 연락처와 이메일 주소를 표기하시나요?</p>
				      <label><input type="radio" name="q_tel" value="Y"/> 네  </label> &nbsp;&nbsp;
				      <label><input type="radio" name="q_tel" value="N"/> 아니오 </label>
			      </div>
			      <div class="text">
				      <p>2. 자신의 SNS계정(페이스 북,인스타)을 표기하시나요?</p>
				      <label><input type="radio" name="q_sns" value="Y"/> 네 </label> &nbsp;&nbsp;
				      <label><input type="radio" name="q_sns" value="N"/> 아니오 </label>
			      </div>
			      <div class="text">
				      <p>3. 자신의 위치를 지도를 통해 표기하시나요?</p>
				      <label><input type="radio" name="q_map" value="Y"/> 네 </label> &nbsp;&nbsp;
				      <label><input type="radio" name="q_map" value="N"/> 아니오 </label>
			      </div>
			      <input type="hidden" name="question_map"/>
			      <input type="hidden" name="question_tel"/>
			      <input type="hidden" name="question_sns"/>
		      </div>
	      </div> 
	      <div class="modal-footer">
	        <button data-toggle="modal" data-target="#makeModal2" type="button" class="btn btn-primary" onclick="makeModal.modal('hide');">다음</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="modal fade" id="makeModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog" style="width: 800px">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      </div>
	      <div class="content" class="modal-body">
	      <img class="more beforeMain" src="${cPath}/img/makePortfolio/theme.jpg">
			  <div id="divide">	
				<c:if test="${not empty themeList}">
					<c:forEach var="item" items="${themeList}" varStatus="vs">
						<c:if test="${0 eq vs.count%5}">
							<br>
						</c:if>
						<div class="themeContent">
							<img class="themeImg" id="${item.theme_num}" src="${cPath}/img/makePortfolio/theme/${item.theme_img}">
							<span class="themeName">${item.theme_name}</span> 
						</div>
					</c:forEach>
				</c:if>
				<input type="hidden" name="theme_num" value="1">
		      </div>
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-primary">제작</button>
	      </div>
	    </div>
	  </div>
	</div>
</form>

<link href="${cPath}/css/alarm/alarm.css" rel="stylesheet">

<div id="alarms" style="display: none;">
</div>
<form id="alarmForm">
	<input type="hidden" name="mem_id" value="${sessionScope.authMember.mem_id }">
	<input type="hidden" name="page" value="2">
</form>
<form id="alarmModyForm" action="${cPath }/alarm/modify" method="post" enctype="multipart/form-data">
	<input type="hidden" name="notice_num">
	<input type="hidden" name="notice_url">
</form>
<form id="alarmDelForm" action="${cpath }/alarm/remove" method="post" enctype="multipart/form-data">
	<input type="hidden" name="notice_num">
</form>
<script type="text/javascript">

var loginForm = $("#loginForm");
var joinForm = $("#joinForm");
var userInfo = $("#userInfo");
var myModal = $("#myModal");	
var makeModal = $("#makeModal");	
var makeModal2 = $("#makeModal2");	
var makeBeforeForm = $("#makeBeforeForm");	
var themeContent = $(".themeContent");
var themeImg = $(".themeImg");
var theme_num =$("[name=theme_num]");

$("#makeBtn").on("click",function(){
	<c:if test="${not empty sessionScope.authMember}">
    $.ajax({
    	url : "${cPath}/makePortfolio/checkPort",
		method : "get",
		dataType : "json",
		success : function(resp){
			if(resp.success){
				alert("이미 포트폴리오가 존재합니다. 추가 결제가 필요합니다.");
				location.href = "<c:url value='/PayList'/>"
			}else{
				makeModal.modal("show");
			}
		},
		error : function(){
			
		}
    })
    </c:if>
    <c:if test="${empty sessionScope.authMember}">
		alert("로그인이 필요합니다.");
		myModal.modal("show");
    </c:if>
})
//----------------------------------------------------------------------------------------------
var cpactha = $('#cpactha');
var chk = 0;
cpactha.on('click',function(){
	$.ajax({
	     url: "${pageContext.request.contextPath}/member/members/VerifyRecaptcha",
         type: 'post',
         data: {
             recaptcha: $("#g-recaptcha-response").val()
         },
         success: function(data) {
             switch (data) {
                 case 0:
                	 chk = 5;
                	 if(chkNum != 1){
                		 alert("아이디 중복체크를 해주세요!!");
	                	 console.log(chk + "성공");
                		 return;
                	 }else{
	                     joinForm.submit();
                	 }
                     break;
                 case 1:
                	 chk = 1;
    				 console.log(chk + "실패");
                     alert("자동 가입 방지 봇을 확인한 뒤 진행 해 주세요.");
                     grecaptcha.reset();
                     return;
                 default:
                	 chk = -1;
                     alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
                     grecaptcha.reset();
                     return;
             }
         }
	});//ajax end
});
//--------------------------------------------------------------------------
$('.tabs .tab').click(function(){
    if ($(this).hasClass('signin')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signin-cont').show();
    } 
    if ($(this).hasClass('signup')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signup-cont').show();
    }
});
$('.container .bg').mousemove(function(e){
    var amountMovedX = (e.pageX * -1 / 30);
    var amountMovedY = (e.pageY * -1 / 9);
    $(this).css('background-position', amountMovedX + 'px ' + amountMovedY + 'px');
});
//--------------------------------------------------------------------------------

makeModal.on("hide.bs.modal",function(){
	var q_map =$("[name=q_map]:checked");
	var q_tel =$("[name=q_tel]:checked");
	var q_sns =$("[name=q_sns]:checked");
	var question_map = $("[name=question_map]");
	var question_tel = $("[name=question_tel]");
	var question_sns = $("[name=question_sns]");
	question_map.val(q_map.val());
	q_map.prop('checked', false);
	question_tel.val(q_tel.val());
	q_tel.prop('checked', false);
	question_sns.val(q_sns.val());
	q_sns.prop('checked', false);
});

makeModal2.on("hide.bs.modal",function(){
	makeBeforeForm[0].reset();
	themeContent.css("border","");
	theme_num.val(1);
});

var join = $("#join");
var authMemId = $("#authMemId");

loginForm.on("submit",function(event){
	event.preventDefault();
	
	let form = $(this)[0];
	let formData = new FormData(form);
	
	let url = $(this).attr("action");
	let method = $(this).attr("method");
	let encType = $(this).attr("encType");
	
	$.ajax({
		url : url,
		method : method,
		data : formData,
		encType : encType,
	    contentType: false,
		processData: false,
		dataType : "json",
		success : function(resp) {
			successFunc(resp, form);
		},
		error:function(error){
			console.log(error);
		}
	})
	return false;
})
//-------------------------------------------------------------------------------------------
var idChk = $('#idChk');
var mem_id = $('#mem_id');
var wrap = $('#wrap');
var pass = $('#pass');
var passChk = $('#rePassChk');
var memTell = $('#memTell');
var memMail = $('#memMail');
var memName = $('#memName');
//아이디 정규식
var idReg = /^[A-za-z0-9]{5,12}$/;
//비밀번호 정규식
var passReg = /^(?=.*[a-z0-9])(?=.*[!@#$%^*+=-])(?=.*[a-z0-9]).{6,16}$/;
//이메일 정규식
var mailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
//전화번호 정규식
var tellReg =  /^01[0-9]{1}\d{3,4}\d{4}$/;
//이름 정규식
var nameReg = /^[가-힣]{2,6}$/;

var spanPassChk = $('#passChkText');
var spanRePassChk = $('#rePassChkText');
spanPassChk.hide();
spanRePassChk.hide();

function isSame(){
	if (pass.val().trim().length < 6  || pass.val().trim().length > 17 || pass.val() == "" || !(passReg.test(pass.val()))) {
        spanPassChk.text("비밀번호는 영문 소문자, 숫자, 특수문자(!,@,#,$,%,^,*,+,=,-) 포함한 6자리 이상 16자리 이하로 설정해주세영~");
        spanPassChk.show();
        pass.focus();
    }else{
    	spanPassChk.text("사용가능한 비밀번호 입니당♥");
        spanPassChk.show();
    }
	
 	if (passChk.val() != pass.val()) {
 		spanRePassChk.text("비밀번호가 일치하지 않습니다.");
 		spanRePassChk.show();
 		passChk.focus();
 	}else if(pass.val().trim().length < 6  || pass.val().trim().length > 17 || pass.val() == "" || !(passReg.test(pass.val())) && passChk.val() == pass.val()){
 		spanRePassChk.hide();
 	}else{
		 spanRePassChk.text("비밀번호가 일치합니당♥");
		 spanRePassChk.show();
	 }
};

var tellChkText = $('#tellChkText');
tellChkText.hide();
function tellChk(){
	if(memTell.val() == "" || !(tellReg.test(memTell.val()))){
		console.log(memTell.val());
		tellChkText.text("옳바른 전화번호 형식이 아닙니다.");
		tellChkText.show();
		memTell.focus();
	}else{
		tellChkText.text("사용가능한 전화번호 입니당♥");
		tellChkText.show();
	}
};

var mailChkText = $('#mailChkText');
mailChkText.hide();
function mailChk(){
	if(memMail.val().trim() == "" || !(mailReg.test(memMail.val()))){
		mailChkText.text("옳바른 이메일 형식이 아닙니다.");
		mailChkText.show();
		memMail.focus();
	}else{
		mailChkText.text("사용가능한 이메일 입니당♥");
		mailChkText.show();
	}
};

var nameChkText = $('#nameChkText');
nameChkText.hide();
function nameChk(){
	if(memName.val().trim() == "" || !(nameReg.test(memName.val()))){
		nameChkText.text("옳바르지 않은 이름 입니다.");
		nameChkText.show();
		memName.focus();
	}else{
		nameChkText.text("사용가능한 이름입니다♥");
		nameChkText.show();
	}
};

var chkNum = 0;
/* 아이디 중복 확인 */
idChk.on('click', function(){
	var memId = mem_id.val();
	if(memId.trim().length < 6 || memId.trim().length > 16 || !(idReg.test(memId))){
		alert("아이디는 숫자, 영문 대소문자 포함 5~15자리 사이로 입력해주시기 바랍니다");
		idChk.val("해당 아이디는 사용할 수 없습니다.");
		return false;
	}
	$.ajax({
		url : "${cPath}/member/members/idChk",
		data : {"mem_id" : memId},
		method : "post",
		dataType : "json",
		success : function(resp){
			chkNum = 1;
			if(resp.success && !resp.duplicated){
				idChk.val("해당 아이디는 사용가능♥");
			}else {
				idChk.val("해당 아이디는 이미 사용중입니다.");
			}
		}
	});//ajax end
});//idChk end

/* 회원가입 */
joinForm.on('submit', function(event){
	event.preventDefault();
	
	let form = $(this)[0];
	let formData = new FormData(form);
	
	let url = $(this).attr('action');
	let method = $(this).attr('method');
	let encType = $(this).attr('encType');
	
	let memId = mem_id.val();
	if(memId.trim().length < 6 || memId.trim().length > 16 || !(idReg.test(memId))){
		alert("아이디는 숫자, 영문 대소문자 포함 5~15자리 사이로 입력해주시기 바랍니다");
		grecaptcha.reset();
		return false;
	}
	if (pass.val().trim().length < 6  || pass.val().trim().length > 17 || pass.val() == "" || !(passReg.test(pass.val()))) {
         alert("비밀번호는 영문 소문자, 숫자, 특수문자(!,@,#,$,%,^,*,+,=,-) 포함한 6자리 이상 16자리 이하로 설정해주세영~");
         pass.focus();
         grecaptcha.reset();
         return false;
     }
     if (pass.val() != passChk.val()) {
         alert("비밀번호가 같지 않습니다.");
         passChk.focus();
         grecaptcha.reset();
         return false;
     }
     
     if(memTell.val() == "" || !(tellReg.test(memTell.val()))){
    	 alert("옳바른 전화번호 형식을 입력해 주세용~");
    	 memTell.focus();
    	 grecaptcha.reset();
    	 return false;
     }
     if(memMail.val() == "" || !(mailReg.test(memMail.val()))){
    	 alert("옳바른 형식의 이메일 주소를 입력해주세용~");
    	 memMail.focus();
    	 grecaptcha.reset();
    	 return false;
     }
     
     if(memName.val().trim() == "" || !(nameReg.test(memName.val()))){
    	 alert("옳바른 형식의 이름을 입력해주세용~");
    	 memName.focus();
    	 grecaptcha.reset();
    	 return false;
     }
	$.ajax({
		url : url,
		data : formData,
		method : method,
		encType : encType,
		contentType : false,
		processData : false,
		dataType : 'json',
		success : function(resp){
			if(resp.success){
				location.href = "${cPath}/";
			}else{
				if(resp.errors){
					if(resp.errors.mem_id){
						alert(resp.errors.mem_id);						
					}else if(resp.errors.mem_pass){
						alert(resp.errors.mem_pass);
					}else if(resp.errors.mem_tel){
						alert(resp.errors.mem_tel);
					}else if(resp.errors.mem_mail){
						alert(resp.errors.mem_mail);
					}
				}//if end
			}//else end
		},
		error:function(){
			
		}
	})//ajax end
});//join submit end

//----------------------------------------------------------------------------------------------
function successFunc(resp, form){
	if(resp.msg){ // 실패
		alert(resp.msg);
		return;
	}else if(resp.success){ // 목록 갱신
		form.reset();
		myModal.modal('hide');
		location.reload();
	}else{
		location.href = "${cPath}/";
	}
}

//----------------------------------------------------------------------------------------------
themeContent.on("click",function(){
	themeContent.css("border","");
	$(this).css("border","solid 3px gray");
	var tn = $(this).find(themeImg).attr("id");
	theme_num.val(tn);
}) 
//----------------------------------------------------------------------------------------------
var alarmForm = $('#alarmForm');
alarmForm.on('submit', function(event){
	event.preventDefault();
	let form = $(this)[0];
	let formData = new FormData(form);
})//submit end

function alarm() {
	var mem_id = alarmForm.find("input[name='mem_id']").val();
	let action = $(this).attr('action');
	$.ajax({
		url : "${cPath }/alarm",
		method :"get",
		data : {	
			"mem_id" : mem_id
		},
		dataType : "json",
		success : function(resp){
			var pf_liTags = [];
			$(resp.alarmList.dataList).each(function(idx, alarm){
				let result = alarm.notice_read == "Y"? true : false;
				let li = $("<div>").prop({"class" : "alarm_div_"+ alarm.notice_read }).append(
					$("<span onclick='alarmBtn("+alarm.notice_num+", \""+alarm.notice_url+"\")'>")
					.prop({"class" : "alarm_aTag", "id" : alarm.notice_url}).text(alarm.notice_content),
					$('<i>').prop({"class" : "closeBtn far fa-window-close", "id" : alarm.notice_num}),
					$("<span class='alarm_read_span'>").text(alarm.notice_read == "Y"? "읽음" : "읽지 않음" ).
					css({"color" : result ? "blue" : "red"})
				);	
				pf_liTags.push(li);
			});//$.each end
			$('#alarmSize').text(resp.readCount);
			$("#alarms").html(pf_liTags);
		},
		error : function(error){
			console.log(error);
		}
	});//ajax end	
}
alarm();
$('#alarm').popover({
   html: true,
   placement : "bottom",
   content: function () {
       return $("#alarms").html();
   }
});

var alarms = $('#alarms');
var alarmModyForm = $('#alarmModyForm');
var notiNum = alarmModyForm.find('input[name="notice_num"]');
var notiUrl = alarmModyForm.find('input[name="notice_url"]');
function alarmBtn(notice_num, notice_url){
	notiNum.val(notice_num);
	notiUrl.val(notice_url);
	alarmModyForm.submit();
}

var alarmDelForm = $('#alarmDelForm');
var noId = alarmDelForm.find('input[name="notice_num"]');
$(document).on('click', '.closeBtn', function(){
	var notice_num = $(this).prop("id");
	noId.val(notice_num);
	var con = confirm("알림을 삭제하시겠습니까?");
	if(con == true){
		alarmDelForm.submit();
	}else{
		return;
	}
});

alarmDelForm.submit(function(event){
	event.preventDefault();
	let form = $(this)[0];
	let formData = new FormData(form);
	let action = $(this).attr('action');
	let method = $(this).attr('method');
	let encType = $(this).attr('encType');
	$.ajax({
		url : action,
		data : formData,
		dataType : "json",
		encType : encType,
	    contentType: false,
		processData: false,
		method : method,
		success : function(resp){
			if(resp.success == true){
				location.reload();
			}else{
				alert("알림함 삭제에 실패했습니다!");
			}
		},
		error : function(error){
			alert(error.status + ", "+ error.responseText);
			location.reload();
		}
	})//ajax end
});//submit end
</script>   

