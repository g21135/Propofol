<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="<c:url value='/js/ckeditor/ckeditor.js' />"></script>
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
	$(function(){
		$("#lock").change(function(){
			if($("#lock").prop("checked")){
				$("#customer_pass").attr("disabled", false);
			}else{
				$("#customer_pass").attr("disabled", true);
			}
		});
	});
</script>
<span style="font-size: 2.0em;">질문 작성</span>
<section id="notice_w">
	<form id="postForm" method="post" enctype="multipart/form-data" style="width:80%">
	    <input type="hidden" name="customer_num" id="customer_num" value="${customer.customer_num}">
	    <input type="hidden" name="mem_id" value="${sessionScope.authMember.mem_id}">
	    <input type="hidden" name="board_num" value="4">
	
	    <div class="notice_w_ico notice_w_tit notice_write_div">
	        <label for="customer_question" class="no_icon"><i class="fa fa-file"></i></label>
	        <input type="text" name="customer_question" value="${customer.customer_question}" id="customer_question" class="notice_frm_input full_input required" size="50" maxlength="255" placeholder="질문">
	    	<form:errors path="customer_question" element="span" cssClass="error" />
	    </div>
	
		<c:if test="${not empty customer.attachList}">
	         <c:forEach var="attach" items="${customer.attachList}">
	            <span>${attach.att_name}
	            	<input class="delFileBtn" type="image" src="<c:url value='/img/delete.png'/>" data-attnum="${attach.attach_num}" style="width:20px;height:20px;"/>
	            </span>
	         </c:forEach>
		</c:if>
		
	    <div class="notice_write_div">
	        <label for="customer_answer" class="sound_no">내용<strong>필수</strong></label>
	        <div class="wr_content">
				<textarea id="customer_content" name="customer_content" style="width:100%;height:200px" placeholder="내용을 입력해 주세요.">${customer.customer_content}</textarea>
		    	<form:errors path="customer_content" element="span" cssClass="error" />
			</div>
	    </div>
	    
	    <div id="fileArea">
			<input type="file" class="form-control" name="cus_files">
		</div>
		<input class="form-control btn btn-outline-dark" id="addFileUpload"type="button" value="추가">
		
		<div class="pass_div">
			비밀글<input type="checkbox" id="lock"/>
			<input type="password" id="customer_pass" disabled name="customer_pass" placeholder="비밀번호" class="pass_input"/>
		</div> 
		
	    <div class="noticd_btn_confirm notice_write_div">
			<button type="reset" id="cancle_btn" class="no_btn_cancel btn">취소</button>
	        <button type="submit" id="btn_submit" accesskey="s" class="no_btn_submit btn">보내기</button>
	    </div>
	</form>
<c:url var="uploadImageUrl" value="/makePortfolio/uploadImage">
	<c:param name="type" value="Images" />
</c:url>	
</section>
<script type="text/javascript">
	CKEDITOR.replace( 'customer_content', {
		height: 300,
		extraPlugins: 'image2, uploadimage',
	    removePlugins: 'image',
	    filebrowserImageUploadUrl: '${uploadImageUrl}'
	});
	
	$("#cancle_btn").on("click", function() {
		customer_num = $("#customer_num").val();
		location.href = "${cPath}/qna/" + customer_num; 
	});
	
	var fileArea = $("#fileArea");
	var addFileUpload = $("#addFileUpload");
	var postForm = $("#postForm");
	
	var fileInputTag ="<input type='file' class='form-control' name='cus_files'>";
	addFileUpload.on("click", function() {
	   fileArea.append(fileInputTag);
	});
	
	var delFileInput = "<input type='hidden' name='delFiles' value='%V' />";
	$(".delFileBtn").on("click", function() {
		var att_num = $(this).data("attnum");
		postForm.prepend(delFileInput.replace("%V", att_num));
		console.log(att_num);
		$(this).closest("span").remove();
	});
</script>