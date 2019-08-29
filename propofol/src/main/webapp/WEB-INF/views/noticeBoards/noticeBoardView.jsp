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
		var post_num = $("#post_num").val();
		var deleteForm = $("#deleteForm");

		modifyBtn.on("click", function(){
			location.href = "${cPath}/noticeBoards/update/" + post_num; 
		});
		
		removeBtn.on("click", function(){
			var check = confirm("정말로 삭제하시겠습니까?");
			if(check){
				deleteForm.submit();
			}else{
				return;
			}
		});
	});
</script>
<div id="main_con">
	<!-- 게시물 읽기 시작 { -->
	<article id="notice_v" style="width:100%">
	<input type="hidden" id="post_num" value="${postVO.post_num}">
	    <header>
	        <h2 id="notice_v_title">
	            <span class="notice_v_tit">${postVO.post_name}</span>
	        </h2>
	    </header>
	    <section id="notice_v_info">
	        <h2>페이지 정보</h2>
	        <span class="sound_no">카테고리</span> <strong><span class="notice_member">${postVO.type_name}</span></strong>
	        <span class="sound_no">조회</span><strong><i class="fa fa-eye" aria-hidden="true"></i>${postVO.post_hit}</strong>
	        <strong class="if_notice_date"><span class="sound_no">작성일</span><i class="fa fa-clock-o" aria-hidden="true"></i>${postVO.post_date}</strong>
	    	<section id="bo_v_file">
				<h6>첨부파일</h6>
				<ul>
					<c:forEach var="attach" items="${postVO.attachList}">
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
	        <h2 id="notice_v_atc_title">본문</h2>
	        <!-- 본문 내용 시작 { -->
	        <div id="notice_v_con"><p>${postVO.post_content}</p></div>
			<!-- } 본문 내용 끝 -->
	    </section>
	    <div id="notice_v_top">
	        <ul class="notice_v_com">
				<li><a href="${pageContext.request.contextPath}/noticeBoards" class="list_btn btn"><i class="fa fa-list" aria-hidden="true"></i> 목록</a></li>
			</ul>
			<c:if test="${sessionScope.authMember.mem_id eq 'root'}">
		        <ul class="notice_v_com">
					<li><button class="list_btn btn" id="modifyBtn"><i class="fa fa-copy" aria-hidden="true"></i>수정</button></li>
					<li><button class="list_btn btn" id="removeBtn"><i class="fa fa-trash" aria-hidden="true"></i>삭제</button></li>
				</ul>
			</c:if>
		</div>
		<hr color="#eaeaea">
	</article>
</div>
<!-- 삭제 폼 -->
<form action="${cPath}/noticeBoards/delete" id="deleteForm" method="post">
	<input type="hidden" name="_method" value="delete" />
	<input type="hidden" name="post_num" value="${postVO.post_num}" />
</form>