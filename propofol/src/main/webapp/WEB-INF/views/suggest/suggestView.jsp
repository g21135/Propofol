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
		var IngBtn = $("#IngBtn");
		var customer_num = $("#customer_num").val();

		modifyBtn.on("click", function(){
			location.href = "${cPath}/suggest/update/" + customer_num; 
		});
		
		removeBtn.on("click", function(){
			var check = confirm("정말로 삭제하시겠습니까?");
			if(check){
				$("#deleteForm").submit();
			}else{
				return;
			}
		});
		
		IngBtn.on("click", function(){
			$("#IngModal").modal("show"); 
		});
		
		answerBtn.on("click", function(){
			$("#answerModal").modal("show"); 
		});
	});
</script>
<div id="main_con">
	<article id="notice_v" style="width:100%">
	<input type="hidden" id="customer_num" value="${suggest.customer_num}">
	    <header>
	        <h2 id="notice_v_title">
	            <span class="notice_v_tit">${suggest.customer_question}</span>
	        </h2>
	    </header>
	    <section id="notice_v_info">
	        <h2>페이지 정보</h2>
	        <span class="sound_no">작성자</span> <strong><span class="mem_id">${suggest.mem_id}</span></strong>
	        <strong class="if_notice_date"><span class="sound_no">작성일</span><i class="fa fa-clock-o" aria-hidden="true"></i>${suggest.customer_date}</strong>
	    	<section id="bo_v_file">
				<h6>첨부파일</h6>
				<ul>
					<c:forEach var="attach" items="${suggest.attachList}">
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
	        <h2 id="notice_v_atc_title">건의 내용</h2>
	        <div id="notice_v_con"><p>${suggest.customer_content}</p></div>
	    </section>
			<!-- 답변 여부 -->
	        <c:if test="${empty suggest.customer_answer}">
			    <section id="notice_v_info">
			    </section>
			    <div id="notice_v_con"><p>아직 답변이 없습니다.</p></div>
	        </c:if> 
	        <c:if test="${not empty suggest.customer_answer}">
	        	<section id="notice_v_info">
	        		<strong><span class="mem_id">답변</span></strong>
	        		<span class="sound_no">작성자</span> <strong><span class="mem_id">관리자</span></strong>
			        <strong class="if_notice_date"><span class="sound_no">작성일</span><i class="fa fa-clock-o" aria-hidden="true"></i>${suggest.customer_answer_date}</strong>
			    </section>
			    <section id="notice_v_atc">
			        <h2 id="notice_v_atc_title">진행상황</h2>
			        <div id="notice_v_con">
			        	<p>${suggest.customer_answer}</p>
			        </div>
			    </section>
	        </c:if> 
			<div id="notice_v_top">
				<ul class="notice_v_com">
					<li><a href="${cPath}/suggest" class="list_btn btn"><i class="fa fa-list" aria-hidden="true"></i> 목록</a></li>
				</ul>
			<c:if test="${sessionScope.authMember.mem_id eq suggest.mem_id}">
				<ul class="notice_v_com">
					<c:if test="${empty suggest.customer_check}">
						<li><button class="list_btn btn" id="modifyBtn"><i class="fa fa-copy" aria-hidden="true"></i>수정</button></li>
					</c:if>
					<li><button class="list_btn btn" id="removeBtn"><i class="fa fa-trash" aria-hidden="true"></i>삭제</button></li>
				</ul>
			</c:if>
			<c:if test="${sessionScope.authMember.mem_id eq 'root'}">
				<ul class="notice_v_com">
					<li><button class="list_btn btn" id="answerBtn"><i class="fa fa-trash" aria-hidden="true"></i>${not empty suggest.customer_answer ? '답변수정' : '답변달기'}</button></li>
				</ul>
				<ul class="notice_v_com">
					<li><button class="list_btn btn" id="IngBtn"><i class="fa fa-trash" aria-hidden="true"></i>진행상황 전달</button></li>
				</ul>
			</c:if>
		</div>
		<hr color="#eaeaea">
	</article>
</div>
<!-- 삭제 폼 -->
<form action="${cPath}/suggest/delete" id="deleteForm" method="post">
	<input type="hidden" name="_method" value="delete" />
	<input type="hidden" name="customer_num" value="${suggest.customer_num}" />
</form>

<!-- 진행상황 폼 -->
<div class="modal fade modal-sm" id="IngModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content modal-sm">
			<div class="modal-header">
				<h5 class="modal-title">진행상황 전달</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div style="text-align: center;">
				<form action="${cPath}/suggest/ing" id="ingForm" method="post">
					<input type="hidden" name="customer_num" value="${suggest.customer_num}" />
					<input type="hidden" name="mem_id" value="${suggest.mem_id}" />
					<select name="customer_check">
						<option value="진행중입니다.">진행중입니다.</option>
						<option value="확인했습니다.">확인했습니다.</option>
						<option value="의견 반영했습니다.">의견 반영했습니다.</option>
					</select>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
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
				<form action="${cPath}/suggest/answer" id="answerForm" method="post">
					<input type="hidden" name="customer_num" value="${suggest.customer_num}" />
					<input type="hidden" name="customer_question" value="${suggest.customer_question}" />
					<input type="hidden" name="mem_id" value="${suggest.mem_id}" />
					<textarea id="customer_answer" name="customer_answer" maxlength="65536" style="width:80%;height:200px" placeholder="답변을 입력해 주세요.">${suggest.customer_answer}</textarea>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
