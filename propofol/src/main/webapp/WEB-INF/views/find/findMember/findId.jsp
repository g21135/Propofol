<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="box6"  style="padding: 10px">
	<h3 style="margin-bottom: 30px">아이디 찾기</h3>
	<!-- 이메일 영역 -->
	<div class="InlineN selected email">
		<label for="r_pn1" class="mng_bo_cate_link" style="font-weight: bold">본인확인 이메일로 인증</label>
		<div id="div_email" class="box_inn_sub InlineN">
			<p class="dsc">본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
				<form action='<c:url value="/find/findMember/searching"/>' method="post" id="findUserId">
					<div class="userInfo_div">	
						<label class="mng_bo_cate_link userInfo_label">이름</label>
						<input type="text" name="mem_name" class="inpt more" required="required" placeholder="Your Name">
					</div>
					<div class="userInfo_div">
						<label class="mng_bo_cate_link userInfo_label">이메일</label>
						<input type="text" name="mem_mail" class="inpt more" required="required" placeholder="Your Email">
						<div style="display: inline-table; margin-left: -6px;">
							<button class="list_btn btn" style="width : 118px; height : 33px; margin-left: 15px;"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>인증번호 받기</button>
						</div>
					</div>
				</form>
				<form action="<c:url value='/find/findMember/mailChk'/>" method="post" id="mailChkForm">
					<div class="userInfo_div">
						<label for="t_ct1" class="mng_bo_cate_link userInfo_label">인증번호 입력</label>
						<input type="hidden" name="mem_name" >
						<input type="hidden" name="mem_mail" >
						<input type="password" name="confirmNum" class="inpt more" required="required" placeholder="인증번호를 입력해 주세요">
						<div style="display: inline-table; margin-left: -6px;">
							<button class="list_btn btn" style="width : 118px; height : 33px; margin-left: 15px;"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>확인</button>
						</div>
					</div>
				</form>
				<div class="userInfo_div" id="time">
				</div>
				<div class="userInfo_div">인증번호가 오지 않나요?
					<a class="example" tabindex="0" data-toggle="popover"
						 data-trigger="focus" title="확인해주세요" 
						 data-content="Propofol이 발송한 메일이 스팸메일로 분류된 것은 아닌지 확인해주세요. 스팸 메일함에도 없다면, 다시 한 번 '인증번호 받기'를 눌러주세요.">도움말</a>
				</div>
				<div class="userInfo_div results" >
					<label class="mng_bo_cate_link userInfo_label" id="resultText" style="width: 300px"></label>
				</div>		
		</div>		
	</div>
	<!-- 이메일 영역 -->
</div>
<script>
$('.example').popover();

//-------------------------------------------------------------------
var findUserId = $('#findUserId');
findUserId.on('submit', function(event){
	event.preventDefault();
	
	let form = $(this)[0];
	let formData = new FormData(form);
	let action = $(this).attr('action');
	let method = $(this).attr('method');
	
	$.ajax({
		url : action,
		data : formData,
		dataType : "json",
		contentType: false,
		processData: false,
		method : method,
		success : function(resp){
			if(!resp.duplicated){//아이디 없음 
				alert(resp.message);
			}else{//아이디있 음
				if(!resp.mailChk){// 이메일 없음
					alert(resp.message);
				}else{//이메일 있음
					alert(resp.message);
					expireTime(180, !resp.mailChk);	
				}
			}		
		},
		error : function(error){
			console.log(error);
		}
	});//ajax end
});//submit end

//-----------------------------------------------------------
var timer = $('#time');
timer.hide();

function timeFormat(time){
	var min = Math.floor(time/60);
	var sec = time % 60;
	return min + " : " + sec;
}
var timeJob;

function stopTimer(){
	clearInterval(timeJob);
	timer.hide();
}

function expireTime(time){
	timer.show();
	timeJob =setInterval(function(){
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
//---------------------------------------------------------------------
var results = $('.results');
results.hide();
var resultsText = $('#resultText');
//---------------------------------------------------------------------

var memId = findUserId.find("input[name='mem_name']");
var memMail = findUserId.find("input[name='mem_mail']");

var mailChkForm = $("#mailChkForm");
mailChkForm.on("submit", function(event) {
	event.preventDefault();
	$(this).find('input[name="mem_name"]').val(memId.val());
	$(this).find('input[name="mem_mail"]').val(memMail.val());
	
	let form = $(this)[0];
	let formData = new FormData(form);
	let action = $(this).attr('action');
	let method = $(this).attr('method');
	
	$.ajax({
		url : action,
		data : formData,
		dataType : "json",
		contentType: false,
		processData: false,
		method : method,
		success : function(resp){
			if(resp.chk == true){
				stopTimer();
				resultsText.text(resp.ID);
				results.show();
			}else{
				alert(resp.message);
				location.reload();
			}
		},
		error : function(error){
			console.log(error);
		}
	});//ajax end
});
</script>
