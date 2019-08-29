<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	function paging(page) {
		searchForm = $('#searchForm');
		if(page<=0) return;	
		searchForm.find("input[name='page']").val(page);	
		searchForm.submit();
		searchForm.find("input[name='page']").val("");	
	}

	$(function() {
		$(document).on("click",".question",function(){
			passForm = $("#passForm");
			q_num = $(this).prop("id");
			sava_pass = $(this).find("input[name='sava_pass']").val();
			passForm.find("input[name='customer_num']").val(q_num);
			if(mem_id == "root"){
				location.href = "${cPath}/qna/" + q_num;
			}else{
				if(!sava_pass){
					location.href = "${cPath}/qna/" + q_num;
				}else{
					$("#passwordModal").modal("show");
				}
			}
		});
		
		var pagingArea = $("#pagingArea");
		var searchForm = $("#searchForm");
		var searchType = $("#searchType");
		var searchWord = $("#searchWord");
		var searchBth = $("#searchBth");
		
		searchBth.on("click", function(){
			searchForm.find("input[name='searchType']").val(searchType.val());
			searchForm.find("input[name='searchWord']").val(searchWord.val());
			searchForm.submit();
		}); 
			
		searchForm.on("submit",function(){
			var ulTag = $("#ulTag");
			var queryString = $(this).serialize();
			$.ajax({
			data : queryString,
			dataType : "json",
			success : function(resp){
				var liTags = [];
				$(resp.dataList).each(function(idx, qna){
					let pass = qna.customer_pass == null ? "공개글" : "비밀글";
					let pass_B = qna.customer_pass == null ? "badge badge-primary" : "badge badge-secondary";
					let read = qna.customer_read == 'Y' ? "답변완료" : "미답변";
					let read_B = qna.customer_read == 'Y' ? "badge badge-success" : "badge badge-secondary";
					let li = $("<li>").prop({"class" : "listTblTr listTblTd"})
									  .append(
											$("<div>").prop({"class" : "InlineN td_num", "style":"padding-right:15px;"})
													  .append($("<span>").prop({"class":(pass_B)})
								   	    				    	   		 .text(pass)).append(qna.rnum),
											$("<div>").prop({"class" : "td_sub", "style":"width: 75%;"}).append(
											 	    	$("<div>").prop({"class":"no_num"}).append(
											   	    		$("<button>").prop({"class":"question", "style":"cursor: pointer;", "id":qna.customer_num})
											   	    					 .text(qna.customer_question)		
											   	    					.append(
														   	    			$("<input>").prop({"name":"sava_pass","type":"hidden","value":qna.customer_pass}),
														   	    			$("<span>").prop({"class":(read_B)})
														   	    					   .text(read))
											   	 	)  
											   	 ),
											$("<div>").prop({"class":"Inlinev sv_member"})
													  .html(qna.mem_id),	
											$("<div>").prop({"class":"Inlinev td_date"})
													  .html(qna.customer_date)	
						);
					liTags.push(li);
					});
					ulTag.html(liTags);
					pagingArea.html(resp.pagingHTMLForBS);
				},
				error : function(){
	            	console.log(errorResp.status + ", " + errorResp.responseText);
	            }
	         });
	         return false;
		});
		
		var mem_id = $("#member_id").val();
		$("#newBtn").on("click", function(){
			if(!mem_id){
				var check = confirm("로그인 후 이용 가능합니다");
				if(check){
					$("#myModal").modal("show");					
				}else{
					return;
				}
			}else{
				location.href = "${cPath}/qna/question"; 
			}
		});
	});
</script>
<c:if test="${not empty sessionScope.message}">
	<div class="alert alert-danger alert-dismissible" role="alert">
	  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
	  	<span aria-hidden="true">&times;</span>
	  </button>
	  <strong>${message}</strong>
	  <c:remove var="message" scope="session" />
	</div>
</c:if>
<div id="notice_top">
	<div id="notice_List_total">
		<div class="listTbl">
			<input name="mem_id" id="member_id" type="hidden" value="${sessionScope.authMember.mem_id}">
			<ul>
				<li class="listTblTr listTblTh">
					<div style="width: 6%;" class="InlineN">번호</div>
					<div style="width: 50%;" class="InlineN">제목</div>
					<div style="width: 5%;" class="InlineN">작성자</div>
					<div style="width: 8%;" class="Inlinev">날짜</div>
				</li>
			</ul>
			<ul id="ulTag">
				<c:set var="qnaList" value="${pagingVO.dataList}" />
				<c:if test="${not empty qnaList}">
					<c:forEach var="qna" items="${qnaList}">
						<li class="listTblTr listTblTd" >
							<div class="InlineN td_num" style="padding-right:15px;">
								<c:if test="${not empty qna.customer_pass}">
									<span class="badge badge-secondary">비밀글</span>
								</c:if>
								<c:if test="${empty qna.customer_pass}">
									<span class="badge badge-primary">공개글</span>
								</c:if>
								${qna.rnum}
							</div>
							<div class="td_sub" style="width: 75%;">
								<div class="no_num" >
									<button style="cursor: pointer;" class="question" id="${qna.customer_num}">
										${qna.customer_question}
										<c:if test="${empty qna.customer_answer}">
											<span class="badge badge-secondary">미답변</span>
										</c:if>
										<c:if test="${not empty qna.customer_answer}">
											<span class="badge badge-success">답변완료</span>
										</c:if>	
									<input name="sava_pass" type="hidden" value="${qna.customer_pass}" />  
									</button>
								</div>
							</div>
							<div class="Inlinev sv_member">
								${qna.mem_id}
							</div>
							<div class="Inlinev td_date">
								${qna.customer_date}
							</div>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		<div>	
			<c:choose>
				<c:when test="${sessionScope.authMember.mem_id eq 'root'}"></c:when>
				<c:otherwise>
					<button style="float: right; font-size: 1.0em" id="newBtn" type="button" value="질문 작성" class="btn btn-outline-secondary">질문 작성</button>
				</c:otherwise>
			</c:choose>
		</div>
	 <!-- 게시판 검색 시작 { -->
	    <fieldset id="serch_notice">
	        <select id="searchType" >
	            <option value="all" ${pagingVO.searchType eq 'all' ? 'selected' : ' '}>제목+내용</option>
				<option value="question" ${pagingVO.searchType eq 'question' ? 'selected' : ' '}>제목</option>
				<option value="answer" ${pagingVO.searchType eq 'answer' ? 'selected' : ' '}>내용</option>
				<option value="member" ${pagingVO.searchType eq 'member' ? 'selected' : ' '}>회원ID</option>
	        </select>
	        <label for="stx" class="sound_no">검색어<strong class="sound_no"> 필수</strong></label>
	        <input type="text" value="${pagingVO.searchWord}" required id="searchWord" class="search_input" size="25" maxlength="20" placeholder="검색어를 입력해주세요">
	        <button type="button" value="검색" class="search_btn" id="searchBth"><i class="fa fa-search" aria-hidden="true"></i><span class="sound_no">검색</span></button>
	    </fieldset>
    	<!-- } 게시판 검색 끝 -->   
	</div>
	<!-- 게시판 목록 끝 -->
</div>
	<form id="searchForm">
		<input type="hidden" name="searchType" value="${pagingVO.searchType}" />
		<input type="hidden" name="searchWord" value="${pagingVO.searchWord}" />
		<input type="hidden" name="page" />
	</form>
	<!-- 페이지 -->
	<div class="notice_page" id="pagingArea">
		${pagingVO.pagingHTMLForBS}
	</div>

<!-- 비밀번호 모달 -->
<div class="modal fade modal-sm" id="passwordModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content modal-sm">
			<div class="modal-header">
				<h5 class="modal-title">비밀글입니다!!</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form action="${cPath}/qna/pass" id="passForm" method="post">
				<input name="customer_num" id="customer_num" type="hidden">
				<div class="modal-body">
					<p>비밀번호를 입력해주세요.</p>
					<input type="password" id="customer_pass" name="customer_pass" value="">				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary">확인</button>
				</div>
			</form>
		</div>
	</div>
</div>