<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div id="register_form"  class="mp_form">   
<form id="modifyForm" name="modifyForm" action="${cPath }/member/members" method="post" enctype="multipart/form-data">
	<div class="btn_confirm" style="float: left">
			<p>
				<c:choose>
		<c:when test="${empty sessionScope.authMember.mem_image}">
			<img alt="회원프로필" id="foo" src="${cPath }/img/iu5.jpg" style="width: 200px; height: 200px; border-radius: 50%;" >
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
						<img alt="회원프로필" id="foo" src="${cPath }/img/profile/${mv.mem_image }" style="width: 200px; height: 200px; border-radius: 50%;">
					</p>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
		</c:choose>
			</p>
			<div style="margin-left:47px">
				<p><span style="font-size: 1.5em;">${mv.mem_name } 님</span></p>
			</div>
			<div class="filebox" style="margin-left : 42px">
			  <label for="ex_file">프로필 변경</label>
			  <input type="file" id="ex_file" name="mem_img" accept="image/*">
			</div>
			</div>
		<div id="mp_container" style="width : 35%; float : left; margin-left: 62px;">
		<input type="hidden" name="_method" value="put">
			<div>
	        <h2>회원 정보</h2>
		        <ul>
					<li>
						<label for="reg_mb_id" class="sound_only">아이디</label>
						<input type="text" 
							value="${mv.mem_id }" id="reg_mb_id" class="mp_frm_input half_input " maxlength="20"	 disabled>
						<input type="hidden" name="mem_id" value="${mv.mem_id }">
					</li>
		            <li>
		                <label for="reg_mb_password" class="sound_only">비밀번호</label>
		                <input type="password"  id="reg_mb_password_mo"  name="mem_pass" required class="mp_frm_input half_input required" maxlength="20" placeholder="New PassWord"
		                onchange="isChk()">
		                <span id="moPass" style="display : block; color : #ff0000; font-size: 0.7em"></span>
		            </li>
		            <li>
		                <label for="reg_mb_password_re" class="sound_only">비밀번호 확인</label>
		                <input type="password"  id="reg_mb_password_re" required class="mp_frm_input half_input required" maxlength="20" placeholder="PassWord Check"
		                onchange="isChk()">
		                <span id="moRePass" style="display : block; color : #ff0000; font-size : 0.7em"></span>
		            </li>
		            <li>
		                <label for="reg_mb_email" class="sound_only">이메일</label>
		                <input type="email"
		                	value="${sessionScope.authMember.mem_mail }" id="reg_mb_email" name="mem_mail" required class="mp_frm_input half_input" maxlength="20"
		                 >
		            </li>
				</ul>
			</div>
				<div style="float: none;">
						<button type="submit" class="list_btn btn" style="width : 118px; height : 42px" data-toggle="modal" data-target="#leaveModal"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>수정</button>
						<button type="reset" class="list_btn btn" style="width : 118px; height : 42px" data-toggle="modal" data-target="#leaveModal"><i class="fa fa-trash" aria-hidden="true" style="margin-right: 3px"></i>초기화</button>
				</div>
	    </div>
		</form>
</div>
<script>
// 파일 선택시 이미지 태그에 이미지 변경
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#foo').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
$("#ex_file").change(function() {
    readURL(this);
});   
//--------------------------------------------------------------------------------------
    //비밀번호 정규식
    var passReg = /^(?=.*[a-z0-9])(?=.*[!@#$%^*+=-])(?=.*[a-z0-9]).{6,16}$/;
    //이메일 정규식
    var mailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
    var pass = $('#reg_mb_password_mo');	//비밀번호
    var rePass = $('#reg_mb_password_re');	//비밀번호 확인
    var mail = $('#reg_mb_email');	//이메일
    var moPass = $('#moPass');
    var moRePass = $('#moRePass');
    
    moPass.hide();
    moRePass.hide();
    
    function isChk(){
    	if(pass.val().trim().length < 6  || pass.val().trim().length > 17 || pass.val() == "" || !(passReg.test(pass.val()))){
    		moPass.text("비밀번호는 영문 소문자, 숫자, 특수문자(!,@,#,$,%,^,*,+,=,-) 포함한 6자리 이상 16자리 이하로 설정해주세영~");
    		moPass.show();
    		pass.focus();
    	}else{
    		moPass.text("사용가능한 비밀번호 입니당♥");
    		moPass.show();
    	}
    	if (rePass.val() != pass.val()) {
     		moRePass.text("비밀번호가 일치하지 않습니다.");
     		moRePass.show();
     		rePass.focus();
     	}else if(pass.val().trim().length < 6  || pass.val().trim().length > 17 || pass.val() == "" || !(passReg.test(pass.val())) && passChk.val() == pass.val()){
     		moRePass.hide();
     	}else{
    		 moRePass.text("비밀번호가 일치합니당♥");
    		 moRePass.show();
    	 }
    };

 //-----------------------------------------------------------------------------------
	 var modifyForm = $('#modifyForm');
 	 var submit = $('input[type="submit"]');
	 
	 modifyForm.on('submit', function(event){
		 event.preventDefault();
		 if (pass.val().trim().length < 6  || pass.val().trim().length > 17 || pass.val() == "" || !(passReg.test(pass.val()))) {
             alert("비밀번호는 영문 소문자, 숫자, 특수문자(!,@,#,$,%,^,*,+,=,-) 포함한 6자리 이상 16자리 이하로 설정해주세영~");
             pass.focus();
             return false;
	     }
	     if (pass.val() != rePass.val()) {
	         alert("비밀번호가 같지 않습니다.");
	         rePass.focus();
	         return false;
	     }
	     if(mail.val().trim == "" || mail.val().trim().length == 0 || !(mailReg.test(mail.val()))){
	    	 alert("옳바른 이메일 형식이 아닙니다.");
	    	 mail.focus();
	    	 return false;
	     }
	     
		 let form = $(this)[0];
		 let formData = new FormData(form);
		 let action = $(this).attr('action');
		 $.ajax({
			 url : action,
			 data : formData,
			 method : "post",
			 encType:"multipart/form-data",
			 contentType:false,
		     processData:false,
			 dataType : "json",
			 success : function(resp){
				if(resp.success){
					alert("회원님의 정보가 성공적으로 변경되었습니다.");
					location.href = "${cPath}/member/members/${sessionScope.authMember.mem_id}";
				}else{
					alert(resp.errors);
					location.reload();
				}	 
			 },
			 error:function(){
				 
			 }
		 });//ajax end
		 return false;
	 });//modifyForm submit end
	 
	 submit.on('submit', function(){
		 modifyForm.submit();
	 });
</script>
