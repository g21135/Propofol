<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
	function paging(page) {
		searchForm = $('#searchForm');
		if(page<=0) return;	
		searchForm.find("input[name='page']").val(page);	
		searchForm.submit();
		searchForm.find("input[name='page']").val("");	
	}
	
	$(function() {
		$("#newBtn").on("click", function(){
			location.href = "${cPath}/noticeBoards/insert"; 
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
				$(resp.dataList).each(function(idx, post){
					let li = $("<li>").prop({"class" : "listTblTr listTblTd"})
									  .append(
											$("<div>").prop({"class" : "InlineN td_num"})
													  .html(post.rnum),
											$("<div>").prop({"class" : "td_sub", "style":"padding-left: 0px"}).append(
											 	    	$("<div>").prop({"class":"no_num"}).append(
											   	    		$("<a>").prop({"href":"${cPath}/noticeBoards/"+(post.post_num)}).append(
											   	    			$("<em>").html(post.post_name)
											   	 			)
											   	 	)  
											   	 ),
											$("<span>").prop({"class":"no_name", "style":"padding-left: 0px"}),
											$("<div>").prop({"class":"Inlinev td_name"}).append(
														$("<span>").prop({"class":"sv_member"})
																   .text(post.type_name)
												),
											$("<div>").prop({"class":"Inlinev td_num"}).append(
													$("<i>").prop({"class":"fa fa-eye"})
												).html(post.post_hit),
											$("<div>").prop({"class":"Inlinev td_date"}).append(
													$("<i>").prop({"class":"fa fa-clock-o"})
												).html(post.post_date)	
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
	});
</script>
<div id="notice_top">
	<div id="notice_List_total">
		<div class="listTbl">
<!-- 		<div class="radioDiv"> -->
<!-- 			<input type="radio" value="notice">공지&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 			<input type="radio" value="error">오류&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 			<input type="radio" value="improvement">개선  -->
<!-- 		</div> -->
			<ul>
				<li class="listTblTr listTblTh">
					<div style="width: 6%;" class="InlineN">번호</div>
					<div style="width: 69%;" class="InlineN">제목</div>
					<div style="width: 10%;" class="Inlinev">카테고리</div>
					<div style="width: 5%;" class="Inlinev">조회</div>
					<div class="Inlinev">날짜</div>
				</li>
			</ul>
			<ul id="ulTag">
				<c:set var="postList" value="${pagingVO.dataList}" />
				<c:if test="${not empty postList}">
					<c:forEach var="post" items="${postList}">
						<li class="listTblTr listTblTd">
							<div class="InlineN td_num">${post.rnum}</div>
							<div class="td_sub" style="padding-left: 0px">
								<div class="no_num">
									<a href="${cPath}/noticeBoards/${post.post_num}"><em>${post.post_name}</em></a>
								</div>
							</div>
							<span class="no_name" style="padding-left: 0px"></span>
							<div class="Inlinev td_name">
								<span class="sv_member">${post.type_name}</span>
							</div>
							<div class="Inlinev td_num">
								<i class="fa fa-eye"></i>${post.post_hit}
							</div>
							<div class="Inlinev td_date">
								<i class="fa fa-clock-o"></i>${post.post_date}
							</div>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		<div>
<%-- 			<c:if test="${sessionScope.authMember.gr_num ne 3}"></c:if> --%>
			<c:if test="${sessionScope.authMember.mem_id eq 'root'}">
		        <button style="float: right; font-size: 1.0em" id="newBtn" type="button" value="공지사항 작성" class="btn btn-outline-secondary">공지사항 작성</button>
			</c:if>
		</div>
	 <!-- 게시판 검색 시작 { -->
	    <fieldset id="serch_notice">
	        <select id="searchType" >
	            <option value="all" ${pagingVO.searchType eq 'all' ? 'selected' : ' '}>제목+내용</option>
				<option value="title" ${pagingVO.searchType eq 'title' ? 'selected' : ' '}>제목</option>
				<option value="content" ${pagingVO.searchType eq 'content' ? 'selected' : ' '}>내용</option>
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