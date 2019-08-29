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
<span style="font-size: 2.0em;">공지사항 작성</span>
<section id="notice_w">
	<form id="postForm" method="post" enctype="multipart/form-data" style="width:80%">
	    <input type="hidden" name="post_num" value="${post.post_num}">
	    <input type="hidden" name="mem_id" value="${sessionScope.authMember.mem_id}">
	    <input type="hidden" name="board_num" value="1">
	
		<div class="notice_write_div">
	       <label for="type_num" class="no_icon" style="position:absolute;top:1px;left:1px;border-radius:3px 0 0 3px;height:38px;line-height:38px;width:40px;;background: #eee;text-align:center;color:#888"><i class="fa fa-check"></i></label>
	       <select name="post_type" class="notice_frm_input full_input required" style="padding-left:50px">
	            <option value="">카테고리를 선택하세요</option>
				<c:forEach items="${postTypeList}" var="postType">
					<option value="${postType.menuURL}" ${postType.menuURL eq type.tpye_num ? "selected" : " "}>${postType.menu}</option>
				</c:forEach>
	        </select>
	    </div>
	    
	    <div class="notice_w_ico notice_w_tit notice_write_div">
	        <label for="post_name" class="no_icon"><i class="fa fa-file"></i></label>
	        <input type="text" name="post_name" value="${post.post_name}" id="post_name" class="notice_frm_input full_input required" size="50" maxlength="255" placeholder="제목">
	    	<form:errors path="post_name" element="span" cssClass="error" />
	    </div>
	    
		<c:if test="${not empty post.attachList}">
	         <c:forEach var="attach" items="${post.attachList}">
	            <span>${attach.att_name}
	            	<input class="delFileBtn" type="image" src="<c:url value='/img/delete.png'/>" data-attnum="${attach.attach_num}" style="width:20px;height:20px;"/>
	            </span>
	         </c:forEach>
		</c:if>
		
	    <div class="notice_write_div">
	        <label for="post_content" class="sound_no">내용<strong>필수</strong></label>
	        <div class="wr_content">
				<textarea id="post_content" name="post_content" maxlength="65536" style="width:100%;height:200px" placeholder="내용을 입력해 주세요.">${post.post_content}</textarea>
				<form:errors path="post_content" element="span" cssClass="error" />
			</div>
	    </div>
	    
		<div id="fileArea">
			<input type="file" class="form-control" name="post_files">
		</div>
		<input class="form-control btn btn-outline-dark" id="addFileUpload"type="button" value="추가">
	
	    <div class="noticd_btn_confirm notice_write_div">
<!-- 	    	<input type="hidden" name="_method" value="put"> -->
			<button type="reset" id="cancle_btn" class="no_btn_cancel btn">취소</button>
	        <button type="submit" id="btn_submit" accesskey="s" class="no_btn_submit btn">보내기</button>
	    </div>
	</form>
<c:url var="uploadImageUrl" value="/makePortfolio/uploadImage">
	<c:param name="type" value="Images" />
</c:url>	
</section>
<script type="text/javascript">
	CKEDITOR.replace( 'post_content', {
		height: 300,
		extraPlugins: 'image2, uploadimage',
	    removePlugins: 'image',
	    filebrowserImageUploadUrl: '${uploadImageUrl}'
	});
	
	$("#cancle_btn").on("click", function() {
		location.href = "${cPath}/noticeBoards"; 
	})
	
	var fileArea = $("#fileArea");
	var addFileUpload = $("#addFileUpload");
	var postForm = $("#postForm");
	
	var fileInputTag ="<input type='file' class='form-control' name='post_files'>";
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