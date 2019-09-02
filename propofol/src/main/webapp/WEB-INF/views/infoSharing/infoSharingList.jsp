<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${cPath}/css/infoSharing.css">
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
				location.href = "${cPath}/infoSharing/insert"; 
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
					$(resp.dataList).each(function(idx, info){
						alert(info.post_image);
						let li = $("<li>").append(
								(info.post_image != null ?
									$("<a>").prop({"href":"${cPath}/infoSharing/" + info.post_num,"class":"list_img"})
									        .append($("<img>").prop({"src":"${cPath}/img/infoSharing/" + info.post_image})):""),
								
								$("<a>").prop({"href":"${cPath}/infoSharing/" + info.post_num, "class":"bo_tit"})
										.append($("<span>").prop({"class":"sound_only"}),
												$("<strong>").text(info.post_name),
												$("<em>").html(info.post_content)),
								$("<u>").append($("<span>").append($("<span>").prop({"class":"sv_member"})
														   .text(info.mem_id)),
												$("<span>").append($("<i>").prop({"class":"fa fa-eye"}))
														   .text(info.post_hit),
											    $("<span>").append($("i").prop({"class":"fa fa-clock-o"}))
											    		   .text(info.post_date))	
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
	<div class="webzineList">
	<input name="mem_id" id="member_id" type="hidden" value="${sessionScope.authMember.mem_id}">
		<ul id="ulTag">
			<c:set var="infoList" value="${pagingVO.dataList}" />
			<c:if test="${not empty infoList}">
				<c:forEach var="info" items="${infoList}">
			 		<li>
						<c:if test="${not empty info.post_image}">
							<a href="${cPath}/infoSharing/${info.post_num}" class="list_img"><img src="${cPath}/img/infoSharing/${info.post_image}"></a>
						</c:if>
						<a href="${cPath}/infoSharing/${info.post_num}" class="bo_tit">
							<span class="sound_only">6</span><strong>${info.post_name}</strong>
							<em>${info.post_content}</em>
						</a>
						<u>
							<span class="sv_member">${info.mem_id}</span>
							<span><i class="fa fa-eye"></i> ${info.post_hit}</span>
							<span><i class="fa fa-clock-o"></i>${info.post_date}</span>
						</u>
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
	<form id="searchForm">
		<input type="hidden" name="searchType" value="${pagingVO.searchType}" />
		<input type="hidden" name="searchWord" value="${pagingVO.searchWord}" />
		<input type="hidden" name="page" />
	</form>
	<!-- 페이지 -->
	<div class="notice_page" id="pagingArea">
		${pagingVO.pagingHTMLForBS}
	</div>