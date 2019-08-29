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
<span style="font-size: 2.0em;">신고하기 작성</span>
<section id="notice_w">
	<form id="postForm" action="${cPath}/report" method="post" enctype="multipart/form-data" style="width:80%">
	    <input type="hidden" name="mem_id_from" value="${sessionScope.authMember.mem_id}">
	    <input type="hidden" name="post_num" value="${post_num}">
		<div class="notice_write_div">
	       <label for="type_num" class="no_icon" style="position:absolute;top:1px;left:1px;border-radius:3px 0 0 3px;height:38px;line-height:38px;width:40px;;background: #eee;text-align:center;color:#888"><i class="fa fa-check"></i></label>
	       <select name="reason_num" class="notice_frm_input full_input required" style="padding-left:50px">
	            <option value="">카테고리를 선택하세요</option>
				<c:forEach items="${reportTypeList}" var="reportType">
					<option value="${reportType.menuURL}">${reportType.menu}</option>
				</c:forEach>
	        </select>
	    </div>
	    
	    <div class="notice_w_ico notice_w_tit notice_write_div">
	        <label for="mem_id_to" style="width: 100px;">신고할 회원</label>
	        <input type="text" name="mem_id_to" readonly="readonly" value="${mem_id_to}" id="post_name" style="padding-left: 110px;" class="notice_frm_input full_input required" size="50" maxlength="255" placeholder="제목">
	    	<form:errors path="mem_id_to" element="span" cssClass="error" />
	    </div>
	    
	    <div class="notice_write_div">
	        <label for="report_content" class="sound_no">내용<strong>필수</strong></label>
	        <div class="wr_content">
				<textarea id="report_content" name="report_content" maxlength="65536" style="width:100%;height:150px" placeholder="내용을 입력해 주세요."></textarea>
				<form:errors path="report_content" element="span" cssClass="error" />
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
	CKEDITOR.replace( 'report_content', {
		height: 300,
		extraPlugins: 'image2, uploadimage',
	    removePlugins: 'image',
	    filebrowserImageUploadUrl: '${uploadImageUrl}'
	});
	
	$("#cancle_btn").on("click", function() {
		location.href = "${cPath}/freeBoards"; 
	})
</script>