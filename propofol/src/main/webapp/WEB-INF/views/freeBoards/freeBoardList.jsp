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
				location.href = "${cPath}/freeBoards/insert"; 
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
				$(resp.dataList).each(function(idx, post){
					var badge = "";
					if(post.reply_cnt > 0){
						badge = "";
					}else{
						badge = "hidden";
					}
					var title = "";
                    if(post.post_depth > 1){
                       for(var i = 0; i < post.post_depth; i++){
                          title += "&nbsp;&nbsp;&nbsp;";
                       }
                       title += "ㄴ> Re: "+ post.post_name;
                    }else{
                       title += post.post_name;
                    }
					let li = $("<li>").prop({"class" : "listTblTr listTblTd"})
									  .append(
											$("<div>").prop({"class" : "InlineN td_num"})
													  .html(post.rnum),
											$("<div>").prop({"class" : "td_sub", "style":"width: 70%"}).append(
											 	    	$("<div>").prop({"class":"no_num"}).append(
											   	    		$("<a>").prop({"href":"${cPath}/freeBoards/"+(post.post_num)}).append(
											   	    			$("<em>").html(title+'<span class="badge badge-secondary"'+badge+'>'+post.reply_cnt+'</span>')
											   	 			)
											   	 	)  
											   	 ),
											$("<span>").prop({"class":"no_name", "style":"padding-left: 0px"}),
											$("<div>").prop({"class":"Inlinev td_name"}).append(
														$("<span>").prop({"class":"sv_member"})
																   .text(post.mem_id)
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
					<div style="width: 69%;" class="InlineN">제목</div>
					<div style="width: 10%;" class="Inlinev">작성자</div>
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
							<div class="td_sub" style="width: 70">
								<div class="no_num">
									<c:choose>
										<c:when test="${post.post_report eq 2}">
											재제당한 글입니다.
										</c:when>
										<c:otherwise>
											<a href="${cPath}/freeBoards/${post.post_num}"><em>
											<c:if test="${post.post_depth gt 1 }">
												<c:forEach begin="1" end="${post.post_depth}" varStatus="vs">
													&nbsp;&nbsp;&nbsp;${vs.last?"ㄴ> Re: ":"" }
												</c:forEach>
											</c:if>
											${post.post_name}
											</em>
											<c:if test="${post.reply_cnt gt 0}">
												<span class="badge badge-secondary">${post.reply_cnt}</span>
											</c:if>
											</a>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="Inlinev td_name">
								<span class="sv_member">${post.mem_id}</span>
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
			<c:choose>
				<c:when test="${sessionScope.authMember.mem_id eq 'root'}"></c:when>
				<c:otherwise>
					<button style="float: right; font-size: 1.0em" id="newBtn" type="button" value="글 작성" class="btn btn-outline-secondary">글 작성</button>
				</c:otherwise>
			</c:choose>
		</div>
	 <!-- 게시판 검색 시작 { -->
	    <fieldset id="serch_notice">
	        <select id="searchType" >
	            <option value="all" ${pagingVO.searchType eq 'all' ? 'selected' : ' '}>제목+내용</option>
				<option value="title" ${pagingVO.searchType eq 'title' ? 'selected' : ' '}>제목</option>
				<option value="content" ${pagingVO.searchType eq 'content' ? 'selected' : ' '}>내용</option>
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
	
	<!-- 로그인 후 이용 모달 -->
<div class="modal fade modal-sm" id="loginmodal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content modal-sm">
			<div class="modal-header">
				<h5 class="modal-title">로그인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p>로그인 후 이용 가능합니다.</p>
			</div>
			<div class="modal-footer">
				<a class="dropdown-item" href='' data-toggle="modal" data-target="#myModal">확인</a>
			</div>
		</div>
	</div>
</div>