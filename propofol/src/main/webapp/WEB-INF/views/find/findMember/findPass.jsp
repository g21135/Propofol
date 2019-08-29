<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
<c:if test="${not empty message}">
	alert("${message}");
	<c:remove var="message" scope="session"/>
</c:if>
</script>
<div class="box6"  style="padding: 10px">
	<h3 style="margin-bottom: 30px">비밀번호  찾기</h3>
	<!-- 휴대전화 영역 -->
	<div class="InlineN selected">
		<input type="radio" id="r_pn1" class="input_rd" name="certification" checked="checked" value="phone" onclick="selectType('phone')">
		<label for="r_pn1" class="mng_bo_cate_link" style="font-weight: bold">회원정보에 등록한 휴대전화로 인증</label>
		<div id="div_phone" class="box_inn_sub InlineN">
			<p class="dsc">회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야, 인증번호를 받을 수 있습니다.</p>
				<form id="findUserPw" action="<c:url value='/find/findMember/phone'/>" method="post">
					<div class="userInfo_div">	
						<label class="mng_bo_cate_link userInfo_label">아이디</label>
						<input type="text" name="user" id="user" class="inpt more" required="required" placeholder="Your Name">
					</div>
					<div class="userInfo_div">
						<label class="mng_bo_cate_link userInfo_label">휴대전화</label>
						<input type="tel" name="mem_tel" class="inpt more" required="required" placeholder="Your PhoneNumber">
						<div style="display: inline-table; margin-left: -6px;">
							<button class="list_btn btn" style="width : 118px; height : 33px; margin-left: 15px;"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>인증번호 받기</button>
						</div>
					</div>
				</form>
				
				<form id="sendConfirm" action="<c:url value='/find/findMember/check'/>" method="post">
					<div class="userInfo_div">
						<label for="t_ct1" class="mng_bo_cate_link userInfo_label">인증번호 입력</label>
						<input type="password" name="confirmNum" id="confirmNum" class="inpt more" required="required" placeholder="인증번호 6자리 숫자 입력">
						<div style="display: inline-table; margin-left: -6px;">
							<button class="list_btn btn" style="width : 118px; height : 33px; margin-left: 15px;"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>확인</button>
						</div>
					</div>
				</form>
				<div class="userInfo_div" class="time">
				</div>
				<div class="userInfo_div">인증번호가 오지 않나요?
					<a class="example" tabindex="0" data-toggle="popover"
						 data-trigger="focus" title="확인해주세요" 
						 data-content="1588 번호가 스팸 문자로 등록되어 있는 것은 아닌지 확인해주세요. 스팸 문자로 등록되어 있지 않다면, 다시 한 번 '인증번호 받기'를 눌러주세요.">도움말</a>
				</div>
<!-- 				<button type="button" id="test">테스트</button>		 -->
			<div class="userInfo_div results" >
				<label class="mng_bo_cate_link userInfo_label" id="resultText"></label>
				<div style="display: inline-table; margin-left: -6px;">
					<button class="list_btn btn" style="width : 130px; height : 33px; margin-left: 15px;" data-toggle="modal" data-target="#modifyPassModal"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>비밀번호 변경하기</button>
				</div>
			</div>		
		</div>		
	</div>
	<!-- 휴대전화 영역 -->
	
	<!-- 이메일 영역 -->
	<div class="InlineN selected email">
		<input type="radio" id="r_pn1" class="input_rd" name="certification" value="email" onclick="selectType('email')">
		<label for="r_pn1" class="mng_bo_cate_link" style="font-weight: bold">본인확인 이메일로 인증</label>
		<div id="div_email" class="box_inn_sub InlineN">
			<p class="dsc">본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
			<form id="findUserPwMail" action="<c:url value="/find/findMember/mail"/>" method="post">
				<div class="userInfo_div">	
					<label class="mng_bo_cate_link userInfo_label">아이디</label>
					<input type="text" name="user" class="inpt more" required="required" placeholder="Your Name">
				</div>
				<div class="userInfo_div">
					<label class="mng_bo_cate_link userInfo_label">이메일</label>
					<input type="text" name="mem_mail" class="inpt more" required="required" placeholder="Your Email">
					<div style="display: inline-table; margin-left: -6px;">
						<button class="list_btn btn" style="width : 118px; height : 33px; margin-left: 15px;"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>인증번호 받기</button>
					</div>
				</div>
			</form>
			<form action="<c:url value='/find/findMember/mailChk'/>" method="post" id="mailConfirm">
				<div class="userInfo_div">
					<label for="t_ct1" class="mng_bo_cate_link userInfo_label">인증번호 입력</label>
					<input type="password" name="confirmNum" class="inpt more" required="required" placeholder="인증번호를 입력해 주세요">
					<div style="display: inline-table; margin-left: -6px;">
						<button class="list_btn btn" style="width : 118px; height : 33px; margin-left: 15px;"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>확인</button>
					</div>
				</div>
			</form>
			<div class="userInfo_div time">
			</div>
			<div class="userInfo_div">인증번호가 오지 않나요?
				<a class="example" tabindex="0" data-toggle="popover"
					 data-trigger="focus" title="확인해주세요" 
					 data-content="Propofol이 발송한 메일이 스팸메일로 분류된 것은 아닌지 확인해주세요. 스팸 메일함에도 없다면, 다시 한 번 '인증번호 받기'를 눌러주세요.">도움말</a>
			</div>	
			<div class="userInfo_div results" >
				<label class="mng_bo_cate_link userInfo_label" id="resultTexts"></label>
				<div style="display: inline-table; margin-left: -6px;">
					<button class="list_btn btn" style="width : 130px; height : 33px; margin-left: 15px;" data-toggle="modal" data-target="#modifyPassModal"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>비밀번호 변경하기</button>
				</div>
			</div>		
		</div>		
	</div>
	<!-- 이메일 영역 -->
</div>

<!-- modal -->
<div class="modal fade modal-sm" id="modifyPassModal" role="dialog">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content modal-sm">
      <div class="modal-header">
        <h5 class="modal-title">비밀번호 변경♥</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="modifyPassForm" method="post" action="<c:url value='/find/findMember'/>">
	     	<input type="hidden" name="_method" value="put"/>
	     	<input type="hidden" name="user"/>
    	<div class="modal-body">
        	<table class="table table-border">
				<tr>
					<th>
						<label>비밀번호 입력<input type="password" name="mem_pass" id="modifyPass" class="form-control"  onchange="isSameMody()"/></label>
						<div><label class="mng_bo_cate_link userInfo_label" id="modyChk" style="width: 200px"></label></div>
					</th>
				</tr>
				<tr>
					<th>
						<label>비밀번호 재확인<input type="password" id="modifyPassRe" class="form-control" onchange="isSameMody()"/></label>
						<div><label class="mng_bo_cate_link userInfo_label" id="modyChkRe" style="width: 200px"></label></div>
					</th>
				</tr>
			</table>
	      </div>
	      <div class="modal-footer">
	      	<input type="submit" value="변경" class="mp_btn_submit">
	        <button type="button" class="mp_btn_cancel" data-dismiss="modal">닫기</button>
	      </div>	
      </form>
    </div>
  </div>
</div>


<script>
$('#div_email').hide();
$('.example').popover();

var results = $('.results');
results.hide();
var resultsText = $('#resultText');
var resultTexts = $('#resultTexts');

//------------------------------------------------------------------------------------
function selectType(type){
	if(type == "phone"){
		$('#div_phone').show();
	}else{
		$('#div_phone').hide();
	}
	if(type == "email"){
		$('#div_email').show();
	}else{
		$('#div_email').hide();
	}
};
//------------------------------------------------------------------------------------
var findUserId = $('#findUserPw');
findUserId.on('submit', function(event){
	event.preventDefault();
	
	let form = $(this)[0];
	let formData = new FormData(form);
	let action = $(this).attr('action');
	let method = $(this).attr('method');
	console.log(action);
	$.ajax({
		url : action,
		data : formData,
		dataType : "json",
		contentType: false,
		processData: false,
		method : method,
		success : function(resp){
			if(resp.empty){//id가 비었다
				alert(resp.message);
			}else{//id가 안 비었다
				if(!resp.duplicated){//회원이 없다
					alert(resp.message);
				}else{//회원이 있다
					if(resp.empty){//전화번호가 비었다.
						alert(resp.message);
					}else{//전화번호가 있다.
						if(resp.telChk){
							alert(resp.message);
							expireTime(180);
						}else{
							alert(resp.message);
						}
					}
				}
			}
		},
		error : function(error){
			console.log(error);
		}
	});//ajax end
});//submit end

//-----------------------------------------------------------------------------------
var sendConfirm = $('#sendConfirm');
var confirmNum = $('#confirmNum');

sendConfirm.on('submit', function(event){
	event.preventDefault();
	
	let form = $(this)[0];
	let formData = new FormData(form);
	let action = $(this).attr('action');
	let method = $(this).attr('method');
	console.log(action);
	console.log(confirmNum);
	$.ajax({
		url : action,
		data : formData,
		dataType : "json",
		contentType: false,
		processData: false,
		method : method,
		success : function(resp){
			if(resp.chk == true){
				resultsText.text(resp.message);
				results.show();
			}else{
				alert(resp.message);
			}
		},
		error : function(error){
			console.log(error);
		}
	})//ajax end
})//submit end

//-----------------------------------------------------------------------------------
var modifyPassForm = $('#modifyPassForm');
var passReg = /^(?=.*[a-z0-9])(?=.*[!@#$%^*+=-])(?=.*[a-z0-9]).{6,16}$/;

var modifyPass = $('#modifyPass');
var modifyPassRe = $('#modifyPassRe');

var modyChk = $('#modyChk');
var modyChkRe = $('#modyChkRe');

modyChk.hide();
modyChkRe.hide();

function isSameMody(){
	if (modifyPass.val().trim().length < 6  || modifyPass.val().trim().length > 17 || modifyPass.val() == "" || !(passReg.test(modifyPass.val()))) {
		modyChk.text("비밀번호는 영문 소문자, 숫자, 특수문자(!,@,#,$,%,^,*,+,=,-) 포함한 6자리 이상 16자리 이하로 설정해주세영~");
		modyChk.show();
		modifyPass.focus();
    }else{
    	modyChk.text("사용가능한 비밀번호 입니당♥");
    	modyChk.show();
    }
	
 	if (modifyPass.val() != modifyPassRe.val()) {
 		modyChkRe.text("비밀번호가 일치하지 않습니다.");
 		modyChkRe.show();
 		modifyPassRe.focus();
 	}else if(modifyPass.val().trim().length < 6  || modifyPass.val().trim().length > 17 || modifyPass.val() == "" || !(passReg.test(modifyPass.val())) && modifyPassRe.val() == pass.val()){
 		modyChkRe.hide();
 	}else{
 		modyChkRe.text("비밀번호가 일치합니당♥");
 		modyChkRe.show();
	 }
};

var user = $('#user');
modifyPassForm.on('submit', function(){
	var userIds = findUserPwMail.find('input[name=user]');
	var userId = modifyPassForm.find('input[name=user]');
	
	if(user.val().trim().length > 0){
		userId.val(user.val());
	}else{
		userId.val(userIds.val());
	}
	
	if (modifyPass.val().trim().length < 6  || modifyPass.val().trim().length > 17 || modifyPass.val() == "" || !(passReg.test(modifyPass.val()))){
		alert("비밀번호는 영문 소문자, 숫자, 특수문자(!,@,#,$,%,^,*,+,=,-) 포함한 6자리 이상 16자리 이하로 설정해주세영~");
		return false;
	}
	if (modifyPass.val() != modifyPassRe.val()){
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
});
//---------------------------------------------------------------------------------------
var timer = $('.time');
timer.hide();

function timeFormat(time){
	var min = Math.floor(time/60);
	var sec = time % 60;
	return min + " : " + sec;
}

function expireTime(time){
	timer.show();
	var timeJob =setInterval(function(){
		if(time != 0){
			timer.html(timeFormat(time));
			time--;
		}else{
			<c:if test="${not empty confirm}">
				<c:remove var="confirm" scope="session"/>
			</c:if>
			clearInterval(timeJob);
			alert("인증시간이 만료되었습니다. 인증번호를 다시 받아주세요!");
			timer.hide();
			location.reload();
		}
	}, 1000);
};

function expireTimes(time){
	timer.show();
	var timeJob =setInterval(function(){
		if(time != 0){
			timer.html(timeFormat(time));
			time--;
		}else{
			<c:if test="${not empty mailConfirm}">
				<c:remove var="mailConfirm" scope="session"/>
			</c:if>
			clearInterval(timeJob);
			alert("인증시간이 만료되었습니다. 인증번호를 다시 받아주세요!");
			timer.hide();
			location.reload();
		}
	}, 1000);
};
//------------------------------------------------------------------------------------------

var findUserPwMail = $("#findUserPwMail");

findUserPwMail.on("submit", function(event) {
	
	let form = $(this)[0];
	let formData = new FormData(form);
	let action = $(this).attr("action");
	let method = $(this).attr("method");
	$.ajax({
		url : action,
		data : formData,
		dataType : "json",
		method  : method,
		contentType: false,
		processData: false,
		success : function(resp) {
			if(resp.duplicated == false){//아이디 없음 
				alert(resp.message);
			}else{//아이디있 음
				if(resp.mailChk == false){// 이메일 없음
					alert(resp.message);
				}else{//이메일 있음
					alert(resp.message);
					expireTimes(180);	
				}
			}		
		},
		error : function(error) {
			console.log(error);
		}
	});
	return false;
});
//-------------------------------------------------------

var mailConfirm = $("#mailConfirm");
mailConfirm.on("submit", function(event) {
	event.preventDefault();
	let form = $(this)[0];
	let formData = new FormData(form);
	let action = $(this).attr("action");
	let method = $(this).attr("method");
	
	$.ajax({
		url : action,
		data : formData,
		dataType : "json",
		method  : method,
		contentType: false,
		processData: false,
		success : function(resp) {
			if(resp.chk == false){
				alert(resp.message);
			}else{
				resultTexts.text(resp.message);
				results.show();
			}
		},
		error : function(error) {
			console.log(error);
		}
	});//ajax end
});//submit end

</script>
