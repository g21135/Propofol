<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
function ${pagingVO.funcName}(page) {
	searchForm = $('#searchForm');
	if(page<=0) return;	
	searchForm.find("input[name='page']").val(page);	
	searchForm.submit();
	searchForm.find("input[name='page']").val("");	
}
	
	$(function() {
		$(".question").on("click", function(){
			suggest_num = $(this).prop("id");
			location.href = "${cPath}/suggest/" + suggest_num;
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
				location.href = "${cPath}/suggest/insert"; 
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
				$(resp.dataList).each(function(idx, suggest){
					let read = suggest.customer_read == 'Y' ? "답변완료" : "미답변";
					let read_B = suggest.customer_read == 'Y' ? "badge badge-success" : "badge badge-secondary";
					let li = $("<li>").prop({"class" : "listTblTr listTblTd"})
									  .append(
											$("<div>").prop({"class" : "InlineN td_num","style":"padding-right:15px; width: 115px;"})
													  .html(suggest.rnum),
											$("<div>").prop({"class" : "td_sub", "style":"width: 75%"}).append(
											 	    	$("<div>").prop({"class":"no_num"}).append(
											 	    			$("<a>").prop({"class":"question","href":"${cPath}/suggest/"+(suggest.customer_num)}).append(
													   	    			$("<em>").html(suggest.customer_question),
													   	    			$("<span>").prop({"class":(read_B)})
													   	    					   .text(read))
											   	 	)  
											   	 ),
											$("<div>").prop({"class":"Inlinev sv_member"})
													  .html(suggest.mem_id),	
											$("<div>").prop({"class":"Inlinev td_date"})
													  .html(suggest.customer_date)	
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
	})
</script>
<div id="notice_top">
	<div id="notice_List_total">
		<div class="listTbl">
		<input name="mem_id" id="member_id" type="hidden" value="${sessionScope.authMember.mem_id}">
			<ul>
				<li class="listTblTr listTblTh">
					<div style="width: 6%;" class="InlineN">번호</div>
					<div style="width: 66%;" class="InlineN">제목</div>
					<div style="width: 5%;" class="Inlinev">작성자</div>
					<div style="width: 8%;" class="Inlinev">날짜</div>
				</li>
			</ul>
			<ul id="ulTag">
				<c:set var="suggestList" value="${pagingVO.dataList}" />
				<c:if test="${not empty suggestList}">
					<c:forEach var="suggest" items="${suggestList}">
						<li class="listTblTr listTblTd" >
							<div class="InlineN td_num" style="padding-right:15px; width: 115px;">
								${suggest.rnum}
							</div>
							<div class="td_sub" style="width: 75%;">
								<div class="no_num" >
									<a class="question" href="${cPath}/suggest/${suggest.customer_num}">
										<em>${suggest.customer_question}</em>&nbsp;&nbsp;
										<c:if test="${empty suggest.customer_answer}">
											<span class="badge badge-secondary">미답변</span>
										</c:if>
										<c:if test="${not empty suggest.customer_answer}">
											<span class="badge badge-success">답변완료</span>
										</c:if>	
									</a>
								</div>
							</div>
							<div class="Inlinev sv_member">
								${suggest.mem_id}
							</div>
							<div class="Inlinev td_date">
								${suggest.customer_date}
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
					<button style="float: right; font-size: 1.0em" id="newBtn" type="button" value="건의사항 작성" class="btn btn-outline-secondary">건의사항 작성</button>
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
		<input type="hidden" name="mem_id" value="${sessionScope.authMember.mem_id}">
		<input type="hidden" name="searchType" value="${pagingVO.searchType}" />
		<input type="hidden" name="searchWord" value="${pagingVO.searchWord}" />
		<input type="hidden" name="page" />
	</form>
	<!-- 페이지 -->
	<div class="notice_page" id="pagingArea">
		${pagingVO.pagingHTMLForBS}
	</div>