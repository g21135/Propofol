<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

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
             <a id="topOrderBtn" class="dropdown-item" href="" data-toggle="modal" data-target="#orderFormModal">주문제작</a>
           </div>
       </li>
       <li class="nav-item dropdown">
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
             aria-haspopup="true" aria-expanded="false">COUMMUNITY</a>
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
             <a class="dropdown-item" href="<c:url value='/jobnews'/>">취업뉴스</a>
             <a class="dropdown-item" href="<c:url value='/recruit'/>">채용공고</a>
             <a class="dropdown-item" href="<c:url value='/infoSharing'/>">정보공유</a>
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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e8d766575fccfc436ac9842183cea79&libraries=services"></script>
<link href="${cPath}/css/makePortfolio/top.css" rel="stylesheet">
<link href="${cPath}/css/portfolio/myPort.css" rel="stylesheet">

<c:if test="${not empty sessionScope.authMember}">

<!-- ckeditor / ckfinder -->
<script src="<c:url value='/js/ckeditor/ckeditor.js'/>"></script>
<script src="<c:url value='/js/ckfinder/ckfinder.js'/>"></script>
<!-- Modal -->
<form id="orderForm" action="${cPath}/makePortfolio/order" method="post" encType="multipart/form-data" >

	<div class="modal fade" id="orderFormModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog" style="width: 705px; top: -73px; overflow: auto;">
	    <div class="modal-content">
	   	  <input type="hidden" name="question_tel">
	      <input type="hidden" name="question_sns">
		  <input type="hidden" name="question_map">
	      <div class="modal-body">
	      	 <div id="orderTable">
		      <table>
					<tr>
						<td class="config-td1">포트폴리오 이름</td>
						<td>
							<input class="form-control" type="text" name="port_name" style="width: 90%; display: inline-block;">
						</td>
						<td rowspan="5">
								<img id="foo" class="img-rounded" src="${cPath}/img/notImage.png" style="width: 200px; height: 230px; ">	
						</td>
					</tr>
					<tr>
						<td class="config-td1">주소 설정</td>
						<td>
							<span>localhost/portfolio/</span>
							<input class="form-control" type="text" name="port_addr" style="width: 43%; display: inline-block;" value="${pv.port_addr}"></td>
					</tr>
					<tr>
						<td class="config-td1">공개 설정</td>
						<td>
							<label><input type="radio" name="port_public" value="Y"> 공개 </label>
							<label><input type="radio" name="port_public" value="N" style="margin-left: 25px;"> 비공개 </label>
						</td>
					</tr>
					<tr>
						<td class="config-td1">포트폴리오 설명</td>
						<td><textarea class="form-control" name="port_explain" style="resize: none;width:90%;">${pv.port_explain}</textarea></td>
					</tr>
					<tr>
						<td class="config-td1">대표이미지</td>
						<td><input id="port_image" type="file" name="port_image"></td>
					</tr>
						<tr id="content1" style="display: none">
							<td class="config-td1">전화번호</td>
							<td><input class="form-control" type="text" name="port_tell_number" style="width:90%" value="${pv.port_tell_number}"></td>
						</tr>
						<tr id="content2" style="display: none">
							<td class="config-td1">SNS 등록</td>
							<td colspan="2">
								<select class="form-control" name="port_sns_name" style="height: 35px; width: 110px; display: inline-block;">
									<option>선택</option>
									<option value="facebook">Facebook</option>
									<option value="instagram">Instagram</option>
								</select>
								<input class="form-control" id="" type="text" name="port_sns_addr" style="width: 75%;display: inline-block;">
								
							</td>
						</tr>
						<tr id="content3" style="display: none">
							<td class="config-td1">위치 등록</td>
							<td colspan="2">
							
								<input class="form-control" id="searchMap" type="text" 
								style="margin-top: 15px; width: 264px; display: inline-block;">
								<input class="btn btn-success" id="searchBtn" type="button" value="검색" style="height: 34px;">
								
								<div id="map" style="width:100%; height: 300px; margin-top: 10px;"></div>
							    <div class="hAddr">
									<span id="centerAddr"></span>
							    </div>
								<div id="clickLatlng" style="height: 50px;">
								  <div id="resultMap" class="bAddr"></div>
								</div>
								<input id="addr" type="hidden" name="port_user_addr">
							</td>	
						</tr>
				</table>
				</div>
				 <div id="orderCK" style="display: none">
				      <span style="margin-left: 13px;  font-size: 18px; font-weight: bold;">
				   		   첨부파일  <i class="fas fa-folder-plus" style="margin-left: 8px;" ></i>
				      </span>
				      <div id="ckfinder-widget">
				      </div>
				      <span  style="margin-left: 13px;  font-size: 18px; font-weight: bold;">
				  		   요구사항  <i class="fas fa-comment-medical" style="margin-left: 8px;"></i>
		      		  </span>
				      <textarea name="port_requirement" id="editor">
				      </textarea>
	      		</div>
	      </div>
	      <div class="modal-footer">
	        <input id="addOrderForm" class="btn btn-success" value="추가 양식">
	      	<label for='radio1' class='labelClass'>전화번호<input id="check1"  type="checkbox" ></label>
			<label for='radio2' class='labelClass'>sns<input id="check2" type="checkbox"></label>
			<label for='radio3' class='labelClass'>위치<input id="check3" type="checkbox"></label>
	        <input id="orderBtn" type="submit" class="btn btn-primary" style="display: none" <%-- onclick="location.href='${cPath}/addPayment?price=100&rank=주문제작'" --%>value="결제"/>
	      </div>
	    </div>
	  </div>
	</div>
</form>
</c:if>

<script type="text/javascript">
$("#orderForm").on("submit",function(){
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
			if(resp.success){
				alert("결제가 완료되었습니다.");
			}else{
				alert("실패");
			}
		},
		error:function(error){
			console.log(error);
		}
	})
	return false;
})


$("#addOrderForm").on("click",function(){
	if($("#orderCK").css("display") == "none"){
		$("#orderCK").show(300);
		$("#orderTable").hide(300);
		$("#orderBtn").show(300);
		$(".labelClass").hide(300);
		$(this).val("돌아가기");
	}else{
		$("#orderCK").hide(300);
		$("#orderTable").show(300);
		$("#orderBtn").hide(300);
		$(".labelClass").show(300);
		$(this).val("추가 양식");
	}
})
<c:if test="${not empty sessionScope.authMember and sessionScope.authMember.mem_id ne 'root'}">
CKFinder.widget( 'ckfinder-widget', {
	width: '100%',
    height: "350px"
});

CKEDITOR.replace( 'editor' ,{
  	 	height: "350px",
		extraPlugins: 'font, sourcedialog, widget, widgetselection, clipboard, lineutils, colorbutton, panelbutton',
	    allowedContent : true
});
</c:if>

<c:if test="${empty sessionScope.authMember}">
$("#topOrderBtn").on("click",function(){
	alert("로그인을 해주세요");
	$("#myModal").modal("show");
})
</c:if>
<c:if test="${sessionScope.authMember.mem_id eq 'root'}">
$("#topOrderBtn").on("click",function(){
	alert("관리자는 접근 불가");
	return false;
})
</c:if>

function mapfunc(){
	if(document.getElementById('map') != null){
    	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	    mapOption = {
    	       center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
    	       level: 1 // 지도의 확대 레벨
    	   };  
    	// 지도를 생성합니다    
    	var map = new kakao.maps.Map(mapContainer, mapOption); 
    	
    	// 주소-좌표 변환 객체를 생성합니다
    	var geocoder = new kakao.maps.services.Geocoder();
     	
    	var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    	    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
    	
    	// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
    	searchAddrFromCoords(map.getCenter(), displayCenterInfo);
    	
    	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
    	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
    	    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
    	        if (status === kakao.maps.services.Status.OK) {
    	            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
    	            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
    	            
    	            var content = '<div class="bAddr">' + detailAddr + '</div>';
    	          
    	            // 마커를 클릭한 위치에 표시합니다 
    	            marker.setPosition(mouseEvent.latLng);
    	            marker.setMap(map);
    	
    	            // 인포윈도우에 클릭한 위치에 대한 상세 주소정보를 표시합니다
    	            infowindow.setContent(content);
    	            infowindow.open(map, marker);

    	    		// 클릭한 위도, 경도 정보를 가져옵니다 
    	    	    var latlng = mouseEvent.latLng; 
    	    	    
    	    	    // 마커 위치를 클릭한 위치로 옮깁니다
    	    	    marker.setPosition(latlng);
    	    	    
		            $("#addr").val(result[0].address.address_name);
		    	    $("#resultMap").html(content); 
    	        }   
    	    });
    	});
    	
    	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
    	kakao.maps.event.addListener(map, 'idle', function() {
    	    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
    	});
    	
    	function searchAddrFromCoords(coords, callback) {
    	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
    	}
    	
    	function searchDetailAddrFromCoords(coords, callback) {
    	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
    	}
    	
    	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
    	function displayCenterInfo(result, status) {
    	    if (status === kakao.maps.services.Status.OK) {
    	        var infoDiv = document.getElementById('centerAddr');
    	
    	        for(var i = 0; i < result.length; i++) {
    	            if (result[i].region_type === 'H') {
    	                infoDiv.innerHTML = result[i].address_name;
    	                break;
    	            }
    	        }
    	    }    
    	}
    	
    	$("#searchBtn").on("click",function(){
    		var searchText = $("#searchMap").val();
    		
    		var ps = new kakao.maps.services.Places(); 
    		ps.keywordSearch(searchText, placesSearchCB); 
    	})
    	
    	function placesSearchCB (data, status, pagination) {
    	    if (status === kakao.maps.services.Status.OK) {

    	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
    	        // LatLngBounds 객체에 좌표를 추가합니다
    	        var bounds = new kakao.maps.LatLngBounds();

    	        for (var i=0; i<data.length; i++) {
    	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
    	        }       

    	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    	        map.setBounds(bounds);
    	    } 
    	}
	}
}
$(document).on("click","#check1",function(){
	
	var orderForm = $("#orderForm");
	if($("#content1").css("display") == "none"){
		$("#content1").show(function(){
			orderForm.find("[name=question_tel]").val("Y");
		});
	}else{
		$("#content1").hide(function(){
			orderForm.find("[name=question_tel]").val("N");
			orderForm.find("[name=port_tell_number]").val("");
		});
	}
})
$(document).on("click","#check2",function(){
	var orderForm = $("#orderForm");
	if($("#content2").css("display") == "none"){
		$("#content2").show(function(){
			orderForm.find("[name=port_sns_name] option:eq(0)").prop("selected",true);
			orderForm.find("[name=question_sns]").val("Y");
		});
	}else{
		$("#content2").hide(function(){
			orderForm.find("[name=question_sns]").val("N");
			orderForm.find("[name=port_sns_name]").val("");
			orderForm.find("[name=port_sns_addr]").val("");
		});
	}
})

$(document).on("click","#check3",function(){
	var orderForm = $("#orderForm");
	if($("#content3").css("display") == "none"){
		$("#content3").show(function(){
			mapfunc();
			orderForm.find("[name=question_map]").val("Y");
		});
	}else{
		$("#content3").hide(function(){
			orderForm.find("[name=question_map]").val("N");
			orderForm.find("[name=port_user_addr]").val("");
			orderForm.find("#searchMap").val("");
			orderForm.find("#resultMap").empty();
		});
	}
})

$("#orderFormModal").on("hide.bs.modal",function(){
	var orderForm = $("#orderForm");
	orderForm[0].reset();
	$("#content1").hide(function(){
		orderForm.find("[name=question_tel]").val("N");
		orderForm.find("[name=port_tell_number]").val("");
	});
	$("#content2").hide(function(){
		orderForm.find("[name=question_sns]").val("N");
		orderForm.find("[name=port_sns_name]").val("");
		orderForm.find("[name=port_sns_addr]").val("");
	});
	$("#content3").hide(function(){
		orderForm.find("[name=question_map]").val("N");
		orderForm.find("[name=port_user_addr]").val("");
		orderForm.find("#searchMap").val("");
		orderForm.find("#resultMap").empty();
	});
});

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#foo').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

$(document).on("change","#port_image",function() {
	readURL(this);
});   

//-----------------------------------------------------

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
					makeModal.modal("show");
			}else{
					alert("이미 포트폴리오가 존재합니다. 추가 결제가 필요합니다.");
					location.href = "<c:url value='/PayList'/>"
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
			$(resp.alarmList).each(function(idx, alarm){
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

 $("#orderBtn").on("click",function(){
	 
    var IMP = window.IMP; // 생략가능
    IMP.init('imp19887480'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
    var msg;
    
    IMP.request_pay({
        pg : 'html5_inicis',
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(),
        name : 'Propofol 추가 결제',
        amount : 100,
        buyer_email : '${sessionScope.authMember.mem_mail}',
        buyer_name : '${sessionScope.authMember.mem_name}',
        buyer_tel : '${sessionScope.authMember.mem_tel}',
    }, function(rsp) {
        if ( rsp.success ) {
            //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
            jQuery.ajax({
                url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                type: 'POST',
                dataType: 'json',
                data: {
                    imp_uid : rsp.imp_uid
                    //기타 필요한 데이터가 있으면 추가 전달
                }
            }).done(function(data) {
                //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                if ( everythings_fine ) {
                    msg = '결제가 완료되었습니다.';
                    msg += '\n고유ID : ' + rsp.imp_uid;
                    msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                    msg += '\결제 금액 : ' + rsp.paid_amount;
                    msg += '카드 승인번호 : ' + rsp.apply_num;
                    
                    alert(msg);
                } else {
                    //[3] 아직 제대로 결제가 되지 않았습니다.
                    //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                }
            });
            //성공시 이동할 페이지
            msg = '결제가 완료되었습니다.\n결제금액은 : '+rsp.paid_amount+'입니다.';
            alert(msg);
            $("#orderForm").submit();
        } else {
            msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
            //실패시 이동할 페이지
             alert("주문을 취소하셨습니다.");
        }
    })
 })

</script>   

