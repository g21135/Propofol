<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${not empty message}">
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
			<ul>
				<li class="listTblTr listTblTh">
					<div class="InlineN" style="width: 120px; padding-left: 20px;">신고당한 회원</div>
					<div class="InlineN" style="width: 250px">신고 게시글</div>
					<div class="InlineN" style="width: 100px">신고 사유</div>
					<div class="Inlinev" style="width: 120px">신고한 회원</div>
					<div class="Inlinev" style="width: 150px">신고일</div>
				</li>
			</ul>
			<ul class="mng_list">
				<c:if test="${not empty pagingVO.dataList}">
					<c:forEach var="reportList" items="${pagingVO.dataList}">
						<li class="listTblTr listTblTd spanParent" onclick="reportLi(${reportList.report_num})">
							<div class="InlineN" style="width: 120px; padding-left: 20px;">
								<span class="mng_bo_cate_link">${reportList.mem_id_to}</span>
							</div>
							<div class="InlineN" style="width: 250px">
								<span id="spanTag" class="mng_bo_cate_link memID">${reportList.post_name}</span>
							</div>
							<div class="InlineN whosMem" style="width: 100px">
								<span class="mng_bo_cate_link memID">${reportList.reason_content}</span>
							</div>
							<div class="InlineN" style="width: 120px">
								<span class="mng_bo_cate_link">${reportList.mem_id_from}</span>
							</div>
							<div class="InlineN" style="width: 150px">
								<span class="mng_bo_cate_link">${reportList.report_date}</span>
							</div>
						</li>
						<form id="${reportList.report_num}" action="${cPath}/manager/report" method="post">
							<input type="hidden" name="report_num" value="${reportList.report_num }"/>
						</form>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
	<!-- 페이지 -->
	<div class="notice_page" id="pagingArea">
		${pagingVO.pagingHTMLForBS}
	</div>
</div>
	<form id="searchForm">
		<input type="hidden" name="page" />
	</form>
	
<!-- 신고 글 모달 -->
<div class="modal fade" id="postModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div style="border-bottom: 1px solid #e1e2e3">
				<div class="modal-header"><i class="fa fa-pencil-square-o">  게시글 내용</i></div>
				<div id="post_input" style="margin: 20px;"></div>
			</div>
			<div style="border-bottom: 1px solid #e1e2e3">
				<div class="modal-header"><i class="fa fa-times-rectangle">  신고 내용</i></div>
				<div id="report_input" style="margin: 20px;"></div>
			</div>
			<div>
				<div class="modal-footer">
					<button class="list_btn btn" id="modifyBtn" style=" background: #e1e2e3; width: 100px;"><i class="fa fa-times-rectangle" aria-hidden="true"></i>글 재제</button>
 					<button class="list_btn btn" id="removeBtn" style=" background: #e1e2e3; width: 100px;"><i class="fa fa-trash" aria-hidden="true"></i>글 삭제</button>
				</div>
			</div>
			<form action="${cPath}/manager/report/delete" id="removeReport" method="post">
				<span id="post_input"></span>
				<input type="hidden" name="post_num" />
				<span id="report_input"></span>
				<input type="hidden" name="report_num"/>
			</form>
			<form action="${cPath}/manager/report/update" id="updateForm" method="post">
				<input type="hidden" name="post_num" />
				<input type="hidden" name="report_num" />
			</form>
		</div>
	</div>
</div>
<script>
	function paging(page) {
		searchForm = $('#searchForm');
		if(page<=0) return;	
		searchForm.find("input[name='page']").val(page);	
		searchForm.submit();
		searchForm.find("input[name='page']").val("");	
	}
	var postForm = null;
	
	function reportLi(report_num) {
		postForm = $("#" + report_num + "");
		postForm.on('submit', function(event){
			event.preventDefault();
			let form = $(this)[0];
			let formData = new FormData(form);
			let action = $(this).attr('action');
			let method = $(this).attr('method');
			$.ajax({
				url : action,
				data : formData,
				dataType : "json",
				contentType: false,
				processData: false,
				method : method,
				success : function(resp){
					$("#post_input").html(resp.post.post_content);
	 				$("input[name='post_num']").val(resp.post.post_num);
	 				$("#report_input").html(resp.report.report_content);
	 				$("input[name='report_num']").val(resp.report.report_num);
	 				$("#postModal").modal("show");
				},
				error : function(error){
					console.log(error);
				}
			})//ajax end
			return false;
		});//modify submit end
	};
	
	var mng_list = $('.mng_list');
	var spanParent = $('.spanParent');
	mng_list.on('click', spanParent, function(){
		postForm.submit();
	});
	
	$("#removeBtn").on("click", function() {
		$("#removeReport").submit();
	});
	
	$("#removeReport").on("submit", function() {
		event.preventDefault();
		let form = $(this)[0];
		let formData = new FormData(form);
		let action = $(this).attr('action');
		let method = $(this).attr('method');
		$.ajax({
			url : action,
			data : formData,
			dataType : "json",
			contentType: false,
			processData: false,
			method : method,
			success : function(resp){
				$('#postModal').modal("hide");
				alert(resp.message);
			},
			error : function(error){
				console.log(error);
			}
		})//ajax end
		return false;
	});
	
	$("#modifyBtn").on("click", function() {
		$("#updateForm").submit();
	});
	
	$("#updateForm").on("submit", function() {
		event.preventDefault();
		let form = $(this)[0];
		let formData = new FormData(form);
		let action = $(this).attr('action');
		let method = $(this).attr('method');
		$.ajax({
			url : action,
			data : formData,
			dataType : "json",
			contentType: false,
			processData: false,
			method : method,
			success : function(resp){
				$('#postModal').modal("hide");
				alert(resp.message);
			},
			error : function(error){
				console.log(error);
			}
		})//ajax end
		return false;
	});
</script>