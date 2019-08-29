<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${not empty message}">
	<div class="alert alert-danger alert-dismissible" role="alert">
	  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
	  	<span aria-hidden="true">&times;</span>
	  </button>
	  <strong>${message}</strong>
	  <c:remove var="message" scope="session" />
	</div>
</c:if>
<script>
	$(function() {
		var modifyBtn = $("#modifyBtn");
		var removeBtn = $("#removeBtn");
		var answerBtn = $("#answerBtn");
		var customer_num = $("#customer_num").val();

		modifyBtn.on("click", function(){
			location.href = "${cPath}/qna/question/" + customer_num; 
		});
		
		removeBtn.on("click", function(){
			var check = confirm("정말로 삭제하시겠습니까?");
			if(check){
				deleteForm.submit();
			}else{
				return;
			}
		});
		
		answerBtn.on("click", function(){
			$("#answerModal").modal("show"); 
		});
	});
</script>
<div id="main_con">
	<article id="notice_v" style="width:100%">
	<input type="hidden" id="customer_num" value="${qna.customer_num}">
	    <header>
	        <h2 id="notice_v_title">
	            <span class="notice_v_tit">${qna.customer_question}</span>
	        </h2>
	    </header>
	    <section id="notice_v_info">
	        <h2>페이지 정보</h2>
	        <span class="sound_no">작성자</span> <strong><span class="mem_id">${qna.mem_id}</span></strong>
				<!-- 비밀번호 여부 -->
	        	<c:if test="${not empty qna.customer_pass}">
			       <strong><i class="fa fa-eye-slash" aria-hidden="true"></i>비밀글</strong>
	        	</c:if>
	        	<c:if test="${empty qna.customer_pass}">
		        	<i class="fa fa-eye" aria-hidden="true"></i>공개글</strong>
	        	</c:if>
	        <strong class="if_notice_date"><span class="sound_no">작성일</span><i class="fa fa-clock-o" aria-hidden="true"></i>${qna.customer_date}</strong>
	    	<section id="bo_v_file">
				<h6>첨부파일</h6>
				<ul>
					<c:forEach var="attach" items="${qna.attachList}">
				    	<c:url value='/noticeBoards/download' var="downloadURL">
							<c:param name="attach" value="${attach.attach_num}"/>
						</c:url>
				    	<c:if test="${not empty attach.attach_num}">
							<li>
								<i class="fa fa-download" aria-hidden="true"></i>
								<a href="${downloadURL}" class="view_file_download">
				                    <strong>${attach.att_name}</strong>
								</a>
							<span class="bo_v_file_cnt">${attach.att_fancysize} | ${attach.att_download} 회 다운로드</span>
						</li>
				    	</c:if>
					</c:forEach>
				</ul>
			</section>
	    </section>
	    <section id="notice_v_atc">
	        <h2 id="notice_v_atc_title">질문</h2>
	        <div id="notice_v_con"><p>${qna.customer_content}</p></div>
	    </section>
			<!-- 답변 여부 -->
	        <c:if test="${empty qna.customer_answer}">
			    <section id="notice_v_info">
			    </section>
			    <div id="notice_v_con"><p>아직 답변이 없습니다.</p></div>
	        </c:if> 
	        <c:if test="${not empty qna.customer_answer}">
	        	<section id="notice_v_info">
	        		<strong><span class="mem_id">답변</span></strong>
	        		<span class="sound_no">작성자</span> <strong><span class="mem_id">관리자</span></strong>
			        <strong class="if_notice_date"><span class="sound_no">작성일</span><i class="fa fa-clock-o" aria-hidden="true"></i>${qna.customer_answer_date}</strong>
			    </section>
			    <section id="notice_v_atc">
			        <h2 id="notice_v_atc_title">답변</h2>
			        <div id="notice_v_con"><p>${qna.customer_answer}</p></div>
			    </section>
	        </c:if> 
	    <div id="notice_v_top">
	        <ul class="notice_v_com">
				<li><a href="${pageContext.request.contextPath}/qna" class="list_btn btn"><i class="fa fa-list" aria-hidden="true"></i> 목록</a></li>
			</ul>
			<c:if test="${sessionScope.authMember.mem_id eq qna.mem_id}">
		        <ul class="notice_v_com">
		        	<c:if test="${empty qna.customer_answer}">
						<li><button class="list_btn btn" id="modifyBtn"><i class="fa fa-copy" aria-hidden="true"></i>수정</button></li>
		        	</c:if>
					<li><button class="list_btn btn" id="removeBtn"><i class="fa fa-trash" aria-hidden="true"></i>삭제</button></li>
				</ul>
			</c:if>
			<c:if test="${sessionScope.authMember.mem_id eq 'root'}">
		        <ul class="notice_v_com">
					<li><button class="list_btn btn" id="answerBtn"><i class="fa fa-trash" aria-hidden="true"></i>${not empty qna.customer_answer ? '답변수정' : '답변달기'}</button></li>
				</ul>
			</c:if>
		</div>
		<hr color="#eaeaea">
	</article>
</div>
<!-- 삭제 폼 -->
<form action="${cPath}/qna/delete" id="deleteForm" method="post">
	<input type="hidden" name="_method" value="delete" />
	<input type="hidden" name="customer_num" value="${qna.customer_num}" />
</form>
<!-- 답변작성 폼 -->
<div class="modal fade" id="answerModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">답변 작성</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div style="text-align: center;">
				<form action="${cPath}/qna/answer" id="answerForm" method="post">
					<input type="hidden" name="customer_question" value="${qna.customer_question}" />
					<input type="hidden" name="mem_id" value="${qna.mem_id}" />
					<input type="hidden" name="customer_num" value="${qna.customer_num}" />
					<textarea id="customer_answer" name="customer_answer" maxlength="65536" style="width:80%;height:200px" placeholder="답변을 입력해 주세요.">${qna.customer_answer}</textarea>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>