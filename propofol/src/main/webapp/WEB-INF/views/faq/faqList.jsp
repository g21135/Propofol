<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
	function paging(page) {
		searchForm = $('#searchForm');
		if(page<=0) return;	
		searchForm.find("input[name='page']").val(page);	
		searchForm.submit();
		searchForm.find("input[name='page']").val("");	
	}		

	$(function(){
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
		
		$("#removeBtn").on("click",function(){
			var check = confirm("정말로 삭제하시겠습니까?");
			if(check){
				$("#deleteForm").submit();
			}else{
				return;
			}
		});
		
		searchForm.on("submit",function(){
			var faq_list = $("#faq_list_content");
			var queryString = $(this).serialize();
			$.ajax({
			data : queryString,
			dataType : "json",
			success : function(resp){
				var liTags = [];
				$(resp.dataList).each(function(idx, faq){
					let li = $("<li>").prop({"class" : "hide"})
									  .append($("<dl>").append(
													  		$("<dt>").append($("<div>").prop({"class":"faq_ask"})
																					   .html("Q"),
																  			 $("<div>").prop({"class":"faq_subject"})
																  					   .append($("<a>").prop({"class":"faq_open"})
																		  							   .append($("<span>").prop({"class":"faq_cate_link"})
						   				   		 				   			    						   		          .text(faq.customer_date))
																			  			    		   .html(faq.customer_question)),
																  			 $("<div>").prop({"class":"faq_sh"})
																  					   .append($("<i>").prop({"class":"fa fa-chevron-up", "aria-hidden":"true"}),
																  							   $("<i>").prop({"class":"fa fa-chevron-down", "aria-hidden":"true"}))),
															  $("<dd>").prop({"class":"faq_cont", "style":"display: none;"})
															  		   .append($("<div>").prop({"class":"faq_answer"})
														   				   				 .html("A"),
														   				   	   $("<div>").prop({"class":"faq_cont", "style":"display: none;"})
														   				   		 		 .append($("<p>").append($("<b>").append($("<span>").prop({"style":"font-size: 11pt;"})
													   				   		 				   			    						   		.text(faq.customer_answer))))))
								);
					liTags.push(li);
					});
					faq_list.html(liTags);
					pagingArea.html(resp.pagingHTMLForBS);
				},
				error : function(){
	            	console.log(errorResp.status + ", " + errorResp.responseText);
	            }
	         });
	         return false;
		});
	});
</script>
<div id="faq_container">
	<!-- 게시판 목록 시작 { -->
	<div id="f_list" style="width:100%">
    <div class="faq_table">
		<ul id="faq_list_content" class="faq_list">
			<c:set var="faqList" value="${pagingVO.dataList}" />
			<c:if test="${not empty faqList}">
				<c:forEach var="faq" items="${faqList}">
					<li class="hide">
						<dl>
							<dt>
								<div class="faq_ask">Q</div>
								<div class="faq_subject">
									<a class="faq_open">
										<span class="faq_cate_link">[${faq.customer_date}]</span>
										${faq.customer_question}
									</a>
								</div>
								<div class="faq_sh"> 
									<i class="fa fa-chevron-up" aria-hidden="true"></i>
									<i class="fa fa-chevron-down" aria-hidden="true"></i> 
								</div>
							</dt>
							<dd class="faq_cont" style="display: none;">
								<div class="faq_answer">A</div>
								<div class="faq_cont" style="display: none;">
									<p><b><span style="font-size: 11pt;">${faq.customer_answer}</span></b></p>
								</div>
								<div>
									<c:if test="${sessionScope.authMember.mem_id eq 'root'}">
								        <ul class="notice_v_com">
											<li>
												<button class="list_btn btn" id="modifyBtn">
												<i class="fa fa-copy" aria-hidden="true"></i>
												<a href="${cPath}/faq/update/${faq.customer_num}">수정</a>
												</button>
											</li>
											<li><button class="list_btn btn" id="removeBtn"><i class="fa fa-trash" aria-hidden="true"></i>삭제</button></li>
										</ul>
									</c:if>
								</div>
							</dd>
						</dl>
					</li> 
					<form action="${cPath}/faq/delete" id="deleteForm" method="post">
						<input type="hidden" name="_method" value="delete" />
						<input type="hidden" name="customer_num" value="${faq.customer_num} " />
					</form>
				</c:forEach>
			</c:if>
		</ul>
	</div>
	<c:if test="${sessionScope.authMember.mem_id eq 'root'}">
		<div class="newdiv">
			<ul class="faqNewBtn">
				<li><a href="${cPath}/faq/insert" class="faqNewBtn btn"><i class="fa fa-pencil" aria-hidden="true"></i> FAQ등록</a></li>        
			</ul>
		</div>
	</c:if>
	<!-- 게시판 검색 시작  -->
	    <fieldset id="serch_notice">
	        <select id="searchType" >
	            <option value="all" ${pagingVO.searchType eq 'all' ? 'selected' : ' '}>질문+답변</option>
				<option value="question" ${pagingVO.searchType eq 'question' ? 'selected' : ' '}>질문</option>
				<option value="answer" ${pagingVO.searchType eq 'answer' ? 'selected' : ' '}>답변</option>
	        </select>
	        <label for="stx" class="sound_no">검색어<strong class="sound_no"> 필수</strong></label>
	        <input type="text" value="${pagingVO.searchWord}" required id="searchWord" class="search_input" size="25" maxlength="20" placeholder="검색어를 입력해주세요">
	        <button type="button" value="검색" class="search_btn" id="searchBth"><i class="fa fa-search" aria-hidden="true"></i><span class="sound_no">검색</span></button>
	    </fieldset>
    <!--  게시판 검색 끝 -->     
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
</div>
<script>
	$(function() {
		var faqArticle = $('.faq_list li');
		faqArticle.addClass('hide');
		faqArticle.find('.faq_cont').hide();
		
		$(document).on("click",'.faq_list li a.faq_open',function(){
			var myArticle = $(this).parents('.faq_list li:first');
			if(myArticle.hasClass('hide')){
				myArticle.removeClass('hide').addClass('show');
				myArticle.find('.faq_cont').slideDown(50);
			} else {
				myArticle.removeClass('show').addClass('hide');
				myArticle.find('.faq_cont').slideUp(100);
			}
		})
	})
</script>