<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="notice_top">
	<div id="notice_List_total">
		<div class="listTbl">
			<ul>
				<li class="listTblTr listTblTh">
					<div class="InlineN" style="width: 90px">이름</div>
					<div class="InlineN" style="width: 400px">프로필</div>
					<div class="InlineN" style="width: 90px">아이디</div>
					<div class="Inlinev" style="width: 500px">이메일</div>
					<div class="Inlinev" style="width: 80px">회원등급</div>
				</li>
			</ul>
			<ul class="mng_list">
			<c:if test="${not empty memberList.dataList}">
				<c:forEach var="memList" items="${memberList.dataList}">
					<li class="listTblTr listTblTd spanParent">
					     <div class="InlineN" style="width: 90px">
					     	<span class="mng_bo_cate_link">
								${memList.mem_name }
							</span>
							<div class="mng_answer hide" style="margin-top:10px;">
								<form name="managerModifyForm" action="${cPath }/member/manager" method="post">
									<input type="hidden" name="_method" value="put">
									<input type="hidden" name="mem_id">
										<c:choose>
											<c:when test="${memberList.role eq 1}">
												<div class="notice_write_div" style="margin-left: 6px">
											       <label for="type_num" class="no_icon" style="position:absolute;top:1px;left:1px;border-radius:3px 0 0 3px;height:38px;line-height:38px;width:27px;;background: #eee;text-align:center;color:#888"><i class="fa fa-check"></i></label>
											       <select name="managerGradeType" class="notice_frm_input full_input required managerSelect" style="padding-left:25px; width : 116px">
											            <option value="2">관리자</option>
														<option value="3">일반회원</option>
														<option value="4">블랙리스트</option>
											        </select>
											    </div>
											</c:when>
											<c:otherwise>
												<div class="notice_write_div" style="margin-left: 6px">
											       <label for="type_num" class="no_icon" style="position:absolute;top:1px;left:1px;border-radius:3px 0 0 3px;height:38px;line-height:38px;width:27px;;background: #eee;text-align:center;color:#888"><i class="fa fa-check"></i></label>
											       <select name="managerGradeType" class="notice_frm_input full_input required managerSelect" style="padding-left:25px; width : 116px">
														<option value="3">일반회원</option>
														<option value="4">블랙리스트</option>
											        </select>
											    </div>
											</c:otherwise>
										</c:choose>
									<div style="float: left; margin-top:5px">
										 <ul class="notice_v_com">
											<li style="width : 60px"><button class="list_btn btn" type="submit" style="width : 118px; height : 42px" data-toggle="modal" data-target="#passModal"><i class="fa fa-copy" aria-hidden="true" style="margin-right: 3px"></i>회원정보수정</button></li>
										</ul>
									</div>
								</form>
							</div>
						 </div>
						 <div class="InlineN" style="width: 400px">
							<a class="mng_open">
							<c:choose>
								<c:when test="${empty memList.mem_image}">
									<img alt="회원프로필" src="${cPath }/img/iu5.jpg" style="width: 130px; height: 130px; border-radius: 50%;" >
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${memList.login_type == 1 }">
											<img alt="회원프로필" src="${memList.mem_image}" style="width: 130px; height: 130px; border-radius: 50%;">
										</c:when>
										<c:when test="${memList.login_type == 2 }">
											<img alt="회원프로필" src="${memList.mem_image}" style="width: 130px; height: 130px; border-radius: 50%;">
										</c:when>
										<c:otherwise>
											<img alt="회원프로필" src="${cPath }/img/profile/${memList.mem_image }" style="width: 130px; height: 130px; border-radius: 50%;">
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							</a>
						  </div>
						  <div class="InlineN whosMem" style="width: 90px">
							  <span class="mng_bo_cate_link memID">
							  	${memList.mem_id}
							  </span>
						  </div>
						  <div class="InlineN" style="width: 500px">
							  <span class="mng_bo_cate_link">
								${memList.mem_mail}
							  </span>
						  </div>
						  <div class="InlineN" style="width: 80px">
							  <span class="mng_bo_cate_link">
								${memList.gr_name}
							 </span>
						 </div>
					</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
	<!-- 회원 검색  -->
	<div id="pf_sch">
		<c:choose>
			<c:when test="${memberList.role eq 1 }">
				<select id="searchType" >
	                <option value="all" ${memberList.searchType eq 'all' ? 'selected' : ' '}>전체</option>
		            <option value="admin" ${memberList.searchType eq 'admin' ? 'selected' : ' '}>관리자</option>
		            <option value="userId" ${memberList.searchType eq 'userId' ? 'selected' : ' '}>일반회원</option>
		            <option value="black" ${memberList.searchType eq 'black' ? 'selected' : ' '}>블랙리스트</option>
	           </select>
			</c:when>
			<c:otherwise>
				<select id="searchType">
	                <option value="all" ${memberList.searchType eq 'all' ? 'selected' : ' '}>전체</option>
		            <option value="userId" ${memberList.searchType eq 'userId' ? 'selected' : ' '}>일반회원</option>
		            <option value="black" ${memberList.searchType eq 'black' ? 'selected' : ' '}>블랙리스트</option>
	            </select>
			</c:otherwise>
		</c:choose>
   		<input type="text" value="${memberList.searchWord}" required id="pf_searchWord" class="sch_input" size="25" maxlength="20" placeholder="검색어를 입력해주세요">
        <button type="button" value="검색" class="sch_btn" id="mem_searchBth"><i class="fa fa-search" aria-hidden="true"></i></button>
	</div>
	<!-- 페이지 -->
	<div class="pg_wrap" id="pagingArea">
		${memberList.pagingHTMLForBS }
	</div>
	<form name="mem_searchForm" id="mem_searchForm" action="${cPath }/member/manager/${sessionScope.authMember.mem_id }">
		<input type="hidden" name="pf_searchType" value="${memberList.searchType }">
		<input type="hidden" name="pf_searchWord" value="${memberList.searchWord }">
		<input type="hidden" name="page">
	</form>
</div>

<script>
var mngAnswer = $('.spanParent div.mng_answer');
mngAnswer.hide();

//페이징
function paging(page) {
	mem_searchForm.find("input[name='page']").val(page);
	mem_searchForm.submit();
	mem_searchForm.find("input[name='page']").val("");
}

var mem_searchBth = $('#mem_searchBth');
var pagingArea = $("#pagingArea");
var mem_searchForm = $('#mem_searchForm');
var mem_searchBth = $('#mem_searchBth');

//검색 및 페이징
mem_searchBth.on('click', function(){
	var pf_searchType = $("#searchType");
	var pf_searchWord = $("#pf_searchWord");
	console.log(pf_searchType.val());
	mem_searchForm.find("input[name='pf_searchType']").val(pf_searchType.val());
	mem_searchForm.find("input[name='pf_searchWord']").val(pf_searchWord.val());
	mem_searchForm.submit();
});

var spanParent = $('.spanParent');
var managerModifyForm = $('form[name="managerModifyForm"]');
spanParent.on('click', function(){
	Article = $(this).children('div:first');
	myArticle = Article.children('div.mng_answer');
	var managerSelect = $(".managerSelect");
	managerSelect.on('click', function(e){
		e.stopPropagation()
	})
	if(myArticle.hasClass('hide')){
		myArticle.removeClass('hide').addClass('show');
		myArticle.show();
	}else{
		myArticle.removeClass('show').addClass('hide');
		myArticle.hide();
	}
	
	var whosMem = $(this).children('div.whosMem');
	var member = whosMem.children('span.memID');
	var memId = member.text();
	console.log(memId);
	managerModifyForm.find('input[name="mem_id"]').val(memId);
});

managerModifyForm.on('submit', function(event){
	event.preventDefault();
	let form = $(this)[0];
	let formData = new FormData(form);
	let action = $(this).attr('action');
	$.ajax({
		url : action,
		data : formData,
		dataType : "json",
		contentType: false,
		processData: false,
		method : "post",
		success : function(resp){
			if(resp.success){
				alert(resp.results);
			}else{
				alert(resp.results);
			}
		},
		error : function(error){
			console.log(error);
		}
	})//ajax end
	location.reload();
});//modify submit end
</script>
