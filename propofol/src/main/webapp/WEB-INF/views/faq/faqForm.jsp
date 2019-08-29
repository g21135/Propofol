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
<span style="font-size: 2.0em;">자주 묻는 질문 작성</span>
<section id="notice_w">
	<form id="postForm" method="post" enctype="multipart/form-data" style="width:80%">
	    <input type="hidden" name="customer_num" value="${customer.customer_num}">
	    <input type="hidden" name="mem_id" value="${sessionScope.authMember.mem_id}">
	    <input type="hidden" name="board_num" value="5">
	
	    <div class="notice_w_ico notice_w_tit notice_write_div">
	        <label for="customer_question" class="no_icon"><i class="fa fa-file"></i></label>
	        <input type="text" name="customer_question" value="${customer.customer_question}" id="customer_question" class="notice_frm_input full_input required" size="50" maxlength="255" placeholder="제목">
	   		<form:errors path="customer_question" element="span" cssClass="error" />
	    </div>
	
	    <div class="notice_write_div">
	        <label for="customer_answer" class="sound_no">내용<strong>필수</strong></label>
	        <div class="wr_content">
				<textarea id="customer_answer" name="customer_answer" maxlength="65536" style="width:100%;height:200px" placeholder="내용을 입력해 주세요.">${customer.customer_answer}</textarea>
				<form:errors path="customer_answer" element="span" cssClass="error" />
			</div>
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
	CKEDITOR.replace( 'customer_answer', {
		height: 300,
		extraPlugins: 'image2, uploadimage',
	    removePlugins: 'image',
	    filebrowserImageUploadUrl: '${uploadImageUrl}'
	});
	
	$("#cancle_btn").on("click", function() {
		location.href = "${cPath}/faq"; 
	})
</script>