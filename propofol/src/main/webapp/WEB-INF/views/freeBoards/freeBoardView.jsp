<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
		var BoardReplyBtn = $("#BoardReplyBtn");
		var post_num = $("#post_num").val();
		var BoarddeleteForm = $("#BoarddeleteForm");

		modifyBtn.on("click", function(){
			location.href = "${cPath}/freeBoards/update/" + post_num; 
		});
		
		removeBtn.on("click", function(){
			var check = confirm("정말로 삭제하시겠습니까?");
			if(check){
				BoarddeleteForm.submit();
			}else{
				return;
			}
		});
		
		var mem_id = $("#member_id").val();
		BoardReplyBtn.on("click", function(){
			if(!mem_id){
				var check = confirm("로그인 후 이용 가능합니다");
				if(check){
					$("#myModal").modal("show");					
				}else{
					return;
				}
			}else{
				location.href = "${cPath}/freeBoards/reply/" + post_num; 
			}
		});
	});
</script>
<div id="main_con">
	<input name="mem_id" id="member_id" type="hidden" value="${sessionScope.authMember.mem_id}">
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
	        <span class="sound_no">작성자</span> <strong><span class="notice_member"><a id="userBtn" tabindex="0" data-toggle="popover" data-trigger="focus">${postVO.mem_id}</a></span></strong>
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
				<li><a href="${cPath}/freeBoards" class="list_btn btn"><i class="fa fa-list" aria-hidden="true"></i> 목록</a></li>
				<li><a id="BoardReplyBtn" class="list_btn btn"><i class="fa fa-reply" aria-hidden="true"></i> 답글 달기</a></li>
			</ul>
			<c:if test="${sessionScope.authMember.mem_id eq postVO.mem_id}">
		        <ul class="notice_v_com">
					<li><button class="list_btn btn" id="modifyBtn"><i class="fa fa-copy" aria-hidden="true"></i>수정</button></li>
					<li><button class="list_btn btn" id="removeBtn"><i class="fa fa-trash" aria-hidden="true"></i>삭제</button></li>
				</ul>
			</c:if>
		</div>
		<br>
		<!--댓글 작성 폼 -->
		<section id="notice_top_info">
			<form id="replyForm" action="${cPath}/reply/insert" method="post" class="form-inline">
				<input type="hidden" name="post_num" value="${postVO.post_num}"/>
				<input type="hidden" name="mem_id" id="loginMember" value="${sessionScope.authMember.mem_id}"/>
				<input type="hidden" name="reply_num" />
				<div class="form-group">
					<textarea name="reply_content" rows="3" cols="95"></textarea>&nbsp;&nbsp;&nbsp;
					<input type="button" id="replyBtn" class="btn btn-outline-dark" value="댓글 작성" />
				</div>
			</form>
	    </section>
	    <section>
			<div>
				<div id="listBody">
		      	</div>
		      	<div class="reply_page" id="pagingArea" style="border-top:1px solid #dddddd; padding: 10px;">
				</div>
			</div> 
	    </section>
	</article>
</div>

<!-- 댓글 목록 폼 -->
<form id="boardReplyForm" action="<c:url value='/freeBoards/reply/${postVO.post_num}'/>"  >
<%-- 	<input type="hidden" name="post_num" value="${postVO.post_num}" /> --%>
</form>

<!-- 신고 폼 -->
<form method="post" id="reportForm" action="<c:url value='/report/${postVO.mem_id}'/>">
	<input type="hidden" name="post_num" value="${postVO.post_num}" />
</form>

<!-- 댓글 목록 폼 -->
<form id="searchForm" action="<c:url value='/reply/replyList'/>">
	<input type="hidden" name="post_num" value="${postVO.post_num}" />
	<input type="hidden" name="page" />
</form>

<!-- 댓글 삭제 폼 -->
<form method="post" id="deleteForm" action="<c:url value='/reply/delete'/>">
	<input type="hidden" name="post_num" value="${postVO.post_num}"/>
	<input type="hidden" name="reply_content" value="${reply.reply_content}" />
	<input type="hidden" name="reply_num"  />
</form>
   
<!-- 댓글 수정 폼 -->
<form method="post" id="updateForm" action="<c:url value='/reply/update'/>">
	<input type="hidden" name="post_num" value="${postVO.post_num}"/>
	<input type="hidden" class="reply_content" name="reply_content"/>
	<input type="hidden" name="reply_num"/>
</form>
   
<!-- 게시글 삭제 폼 -->
<form action="${cPath}/freeBoards/delete" id="BoarddeleteForm" method="post">
	<input type="hidden" name="_method" value="delete" />
	<input type="hidden" name="post_num" value="${postVO.post_num}" />
</form>

<script>
	var mem_id = $("#loginMember").val();
	$('#userBtn').popover({
	   html: true,
	   placement : "bottom",
	    content: function () {
	        return '<a id="report" href="#">신고하기</a>';
	    }
	});
	$(document).on("click","#report",function(){
		if(!mem_id){
			var check = confirm("로그인 후 이용 가능합니다");
			if(check){
				$("#myModal").modal("show");					
			}else{
				return;
			}
		}else{
			$("#reportForm").submit();
		}	
	});

	function paging(page){
	    if(page<=0) return;
	    searchForm.find("input[name='page']").val(page);
	    searchForm.submit();
	    searchForm.find("input[name='page']").val("");
	 }
	 
	 function replyDelete(reply_num){
		 var check = confirm("정말로 삭제하시겠습니까?");
			if(check){
			    $("[name=reply_num]", "#deleteForm").val(reply_num);
			    $("#deleteForm").submit();
			}else{
				return;
			}		 
	 }
	 
	 function replyUpdate(reply_num){
		var replyInput = $("#replyInput"+reply_num+"")
		var updatereplybutton=$("#updatereplybutton"+reply_num+"");  //수정버튼
		replyInput.removeAttr("disabled");
		replyInput.css('border-bottom', '1px solid black');
		updatereplybutton.on("click", function(){
			$("[name=reply_num]", "#updateForm").val(reply_num);
			reply_content = replyInput.val();
			$("#updateForm .reply_content").val(reply_content);
		    $("#updateForm").submit();
		})
	 }

	$(function(){
		var mem_id = $("#loginMember").val();
		$("#replyBtn").on("click", function(){
			if(!mem_id){
				var check = confirm("로그인 후 이용 가능합니다");
				if(check){
					$("#myModal").modal("show");					
				}else{
					return;
				}
			}else{
				$("#replyForm").submit();
			}
		});		
		
		searchForm = $("#searchForm"); // 댓글 페이징 폼
	    var listBody = $("#listBody");
	    var pagingArea = $("#pagingArea");
	    var mem_id = $("#loginMember").val();
	    var abc = function(event){
			event.preventDefault();
			var action = $(this).attr("action");
			var queryString = $(this).serialize();
			$.ajax({
				url : action,
				data : queryString,
				dataType : "json",
				success : function(resp) {
					let replyList = resp.dataList;
					var divTags = [];
					if(replyList && replyList.length > 0){
					$(replyList).each(function(idx, reply){
						dispaly = (reply.mem_id == mem_id ? "inline-block;" : "none;");
	                   let div = $("<div>").prop({"id":"maindiv", "style": "border-top:1px solid #dddddd; padding: 10px;"})
	                   					   .append(
	                         $("<div>").prop({"style":"width:65%; display:inline-block;"}).append(
	                        		 													$("<input>").prop({"id":"replyInput"+reply.reply_num+"", 
	                        		 																	   "disabled":" ",
	                        		 																	   "type":"text",
	                        		 																	   "style":"width:95%; border:0px; background:white;",
	                        		 																	   "value":reply.reply_content})),
	                         $("<div>").prop({"style":"width:10%; display:inline-block;"}).text(reply.mem_id),
	                         $("<div>").prop({"style":"width:13%; display:inline-block;"}).text(reply.reply_date), 
	                         $("<div>").prop({"style":"width:11%; display:"+dispaly+""}).append(
	                            $("<button>").prop({"class":"list_btn btn", "id":"updatereplybutton" + reply.reply_num + "","style":"margin-right:5px;"})
				                            			 .attr({"onclick" : "replyUpdate("+reply.reply_num+")"})
							                             .text("수정"),
	                            $("<button>").prop({"class":"list_btn btn", "id":"modifyBtn"})
				                            			 .attr({"onclick" : "replyDelete(" + reply.reply_num + ");"})
							                             .text("삭제"))
	                      );
	                      divTags.push(div)
	                });
	                listBody.html(divTags);
	             }else{
	 				divTags.push(
	                   $("<div>").prop({"style": "border-top:1px solid #dddddd; padding: 10px;"}).text("댓글 없음.")
	                );
	             }
				listBody.html(divTags);
				pagingArea.html(resp.pagingHTMLForBS);
	          },
	          error : function(errorResp) {
	             console.log(errorResp.status + ", "
	                   + errorResp.responseText)
	          }
	       }); // ajax end
	       return false;
	    }; // submit handler end
    
    searchForm.on('submit', abc);
    
    searchForm.trigger("submit");   //이벤트 발생 
 
    var viewReply = $("#viewReply"); //삭제 버튼
    var replyForm = $("#replyForm"); //댓글 등록 폼
    var deleteForm = $("#deleteForm"); //댓글 삭제 폼
    var updateForm = $("#updateForm"); //댓글 수정 폼

    
    viewReply.on("click", function(){
       $(this).hide();
       paging(1); 
    });
    
    // 댓글 등록과 삭제에서 공통 사용할 핸들러
    var commonHandler = function(event){
       var action = $(this).attr("action");
       var method = $(this).attr("method");
       var queryString = $(this).serialize();
       $.ajax({
          url:action,
          data : queryString,
          method : method,
          dataType : "json",
          success : function(resp) {
             //alert(resp.success);
             if(resp.success){
                viewReply.trigger("click");
                replyForm[0].reset();
             }else{
                alert(resp.message);
             }
          },
          error : function(errorResp) {
             console.log(errorResp.status + ", "
                   + errorResp.responseText)
          }
       });
       paging(1);
       return false;
    } // commonHandler end
    
    // 비동기 댓글 등록
    replyForm.on("submit", commonHandler); 
    // 비동기 댓글 삭제
    deleteForm.on("submit", commonHandler);
    // 비동기 댓글 수정
    updateForm.on("submit", commonHandler);
 }); 
</script>