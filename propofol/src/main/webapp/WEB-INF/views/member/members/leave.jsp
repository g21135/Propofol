<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
<c:if test="${not empty message}">
	alert("${message}");
</c:if>
</script>
<div id="mpWrap" style="height: 400px">
	<div id="mp_container" style="display : block; float: none">
		<div class="mp_section" style="display: block">
		    <h3 class="mp_title"><span class="txt">탈퇴신청안내</span></h3>
		    <ul class="description">
		        <li class="list"><strong>1. 회원탈퇴</strong>
		            <ul class="depth2">
		                <li class="depth2_list"><span class="ic sp"></span>회원은 언제든지 Propofol[프로포폴] 고객센터(010-5596-2160)로 요청하거나 직접 Propofol[프로포폴] 홈에 접속하여 회원계정의 탈퇴를 신청할 수 있으며, 회사는 관련 법령 등이 정하는 바에 따라 이를 지체없이 처리합니다.</li>
		                <li class="depth2_list"><span class="ic sp"></span>회원 계정의 탈퇴가 완료되는 경우, 관련 법령 및 개인정보처리방침에 따라 보유하는 회원의 정보를 제외한 모든 정보 및<br><em>회원 계정에 등록된 홈페이지 및 게시물 등의 정보 일체는 지체없이 삭제</em>됩니다.</li>
		                <li class="depth2_list"><span class="ic sp"></span>회원 계정의 탈퇴가 완료된 회원은 더 이상 Propofol[프로포폴] 홈 및 Propofol[프로포폴] 서비스를 이용하실 수 없습니다.</li>
		            </ul>
		        </li>
		        <li class="list"><strong>2. 회원 탈퇴와 재가입 제한</strong>
		            <ul class="depth2">
		                <li class="depth2_list"><span class="ic sp"></span>회원 탈퇴를 하신 경우 탈퇴한 회원 정보로는 원칙적으로 <em>탈퇴일로부터 30일간 다시 회원으로 가입하실 수 없습니다.</em></li>
		                <li class="depth2_list"><span class="ic sp"></span>회사는 안정적인 서비스 운영 등을 위해 다음의 경우 탈퇴 또는 직권 해지일로부터 6개월간 회원 가입을 제한할 수 있습니다.
		                    <ul class="depth3">
		                        <li class="depth3_list">- 약관 및 서비스 운영정책 위반으로 직권해지된 이력이 있는 경우</li>
		                        <li class="depth3_list">- 약관 및 서비스 운영정책 위반으로 서비스 이용정지된 상태에서 탈퇴한 이력이 있는 경우</li>
		                        <li class="depth3_list">- 약관 및 광고운영정책에 중대하게 어긋나는 행동을 한 후 자진하여 탈퇴한 이력이 있는 경우</li>
		                    </ul>
		                </li>
		            </ul>
		        </li>
		    </ul>
		</div>
		<div class="mp_section" style="display: block">
        	<h3 class="mp_title">
        		<span class="mp_txt">가입자 정보</span>
       		</h3>
       		<table class="mp_form_default">
	        	<tbody>
	        		<tr>
			            <th scope="row">
			            	<div class="required">아이디</div>
		            	</th>
			            <td>
			                <span class="mp_txt">${sessionScope.authMember.mem_id }</span>
			            </td>
			        </tr>
	        		<tr>
			            <th scope="row">
			            	<div class="required">이메일</div>
		            	</th>
			            <td>
			                <span class="mp_txt">${sessionScope.authMember.mem_mail }</span>
			            </td>
			        </tr>
		        </tbody>
		    </table>
		</div>
		<div style="display: block">
			<button class="list_btn btn" id="goPage" style="width : 118px; height : 42px" data-toggle="modal" data-target="#leaveModal"><i class="fa fa-trash" aria-hidden="true" style="margin-right: 3px"></i>회원탈퇴</button>
		</div>
	</div>
</div>


<div class="modal fade modal-sm" id="leaveModal" role="dialog">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content modal-sm">
      <div class="modal-header">
        <h5 class="modal-title">탈퇴를 원하시면 비밀번호를 입력하세요♥</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
	  <form id="deleteForm" method="post" action="${cPath }/member/members" enctype="multipart/form-data">
		 	<input type="hidden" name="_method" value="delete">
		 	<input type="hidden" name="mem_id" value="${sessionScope.authMember.mem_id }">
		 	<input type="hidden" name="chk" value="Y">
    	<div class="modal-body">
        	<table class="table table-border">
				<tr>
					<th><label>비밀번호<input type="password" name="mem_pass" id="delPass" class="form-control" /></label></th>
				</tr>
			</table>
	      </div><br><br>
	      <div class="modal-footer" style="float:left">
		    <input type="submit" value="회원탈퇴" class="mp_btn_submit">
	        <button type="button" class="mp_btn_cancel" data-dismiss="modal">닫기</button>
	      </div>	
      </form>
    </div>
  </div>
</div>

<script>
	var deleteForm = $('#deleteForm');
	var pass = $('#delPass');
	deleteForm.on('submit', function(){
		if(pass.val().trim() == "" || pass.val().trim().length == 0){
			alert("비밀번호를 입력해주세요");
			return false;
		}
	});//deleteForm end
</script>