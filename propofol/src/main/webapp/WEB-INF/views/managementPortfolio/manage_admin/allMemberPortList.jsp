<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
	function paging(page) {
		pf_searchForm.find("input[name='page']").val(page);
		pf_searchForm.submit();
	}
	
	function successPfList(resp){
		  var pf_liTags = [];
		  $(resp.dataList).each(function(idx, port){
			  let readVar = port.port_read == "Y" ? "확인" : "미확인";
			  let readVarClass = port.port_read == "Y" ? "success" : "secondary"
			  let publicVar = port.port_public == "Y" ? "공개" : "비공개";
			  let publicVarClass = port.port_public == "Y" ? "primary" : "secondary";
			  let li = $("<li>").prop({"class" : "listTblTr listTblTd"})
			  .append(
					$("<div>").prop({"class" : "InlineN td_num", "style":"width: 90px"}).append(
							$("<span>").prop({"class" : "badge badge-"+readVarClass+"", "style" : "margin-right : 5px "}).text(readVar),
							$("<span>").text(port.port_num)
					),
					$("<div>").prop({"class" : "td_sub", "style":"width: 480px"}).append(
					 	    	$("<div>").prop({"class":"no_num"}).append(
					   	    		$("<a>").prop({"href":port.port_addr}).append(
					   	    			$("<em>").html(port.port_name),
						   	    		$("<span>").prop({"class" : "badge badge-"+publicVarClass+""}).text(publicVar)
					   	 			)
					   	 	    )  
					),
					$("<div>").prop({"class":"Inlinev td_name", "style":"width: 580px"}).append(
								$("<span>").prop({"class":"sv_member"})
										   .text(port.mem_id)
					),
					$("<div>").prop({"class":"Inlinev td_num", "style":"width: 80px"}).append(
							$("<span>").text(port.themeList[0].theme_name)	
					),
					$("<div>").prop({"class":"Inlinev td_date", "style":"width: 100px"}).append(
							$("<span>").text(port.port_date)
					),
					$("<div>").prop({"class":"Inlinev td_button", "style":"width: 130px"}).append(
							$("<button onclick='readBtn("+port.port_num+")'>").prop({"type" : "button", "class":"btn btn-light"}).text("확인"),	
							$("<button onclick='benBtn("+port.port_num+")'>").prop({"type" : "button", "class":"btn btn-secondary"}).text("제제")	
					)
			 );
		   pf_liTags.push(li);
		   });
		   pf_ulTag.html(pf_liTags);
		   pagingArea.html(resp.pagingHTMLForBS);
	}
	
	function benBtn(port_num){
		pf_blackForm.find("input[name='black_num']").val(port_num);
		pf_blackForm.submit();
		pf_blackForm.find("input[name='black_num']").val("");
	}
	
	function readBtn(port_num){
		pf_readForm.find("input[name='read_num']").val(port_num);
		pf_readForm.submit();
		pf_readForm.find("input[name='read_num']").val("");
	}
	
	$(function(){
		pf_searchForm = $('#pf_searchForm');
		pf_searchBth = $('#pf_searchBth');
		pf_blackForm = $('#pf_blackForm');
		pf_readForm = $('#pf_readForm');
		pf_ulTag = $("#pf_gall_ul");
		pagingArea = $("#pagingArea");
        var queryString = $(this).serialize();
        
        $.ajax({
        	url:"${cPath}/adminMenagement/allMemberPortList",
        	method : "get",
	        data : queryString,
	        dataType : "json",
	        success : function(resp){
	        	successPfList(resp);
			},
			error : function(){
				console.log(errorResp.status + ", " + errorResp.responseText);
			}
		});
        
        pf_searchForm.on("submit",function(event){
        	event.preventDefault();
        	var queryString = $(this).serialize();
        	console.log(queryString);
        	$.ajax({
            	url:"${cPath}/adminMenagement/allMemberPortList",
            	method : "get",
    	        data : queryString,
    	        dataType : "json",
    	        success : function(resp){
    	        	successPfList(resp);
    			},
    			error : function(){
    				console.log(errorResp.status + ", " + errorResp.responseText);
    			}
    		});
        });
        
        pf_searchBth.on("click", function(){
        	var pf_searchType = $("#pf_searchType");
    		var pf_searchWord = $("#pf_searchWord");
    		pf_searchForm.find("input[name='pf_searchType']").val(pf_searchType.val());
    		pf_searchForm.find("input[name='pf_searchWord']").val(pf_searchWord.val());
    		pf_searchForm.submit();
        })
        
        pf_blackForm.on("submit", function(event){
        	event.preventDefault();
        	var queryString = $(this).serialize();
        	console.log(queryString);
        	$.ajax({
            	url:"${cPath}/adminMenagement/blackPort",
            	method : "get",
    	        data : queryString,
    	        dataType : "json",
    	        success : function(resp){
    	        	alert(resp.message);
    	        	pf_searchForm.submit();
    			},
    			error : function(){
    				console.log(errorResp.status + ", " + errorResp.responseText);
    			}
    		});
        });
        
        pf_readForm.on("submit", function(event){
        	event.preventDefault();
        	var queryString = $(this).serialize();
        	$.ajax({
            	url:"${cPath}/adminMenagement/readPort",
            	method : "get",
    	        data : queryString,
    	        dataType : "json",
    	        success : function(resp){
    	        	alert(resp.message);
    	        	pf_searchForm.submit();
    			},
    			error : function(){
    				console.log(errorResp.status + ", " + errorResp.responseText);
    			}
    		});
        });
	})
</script>

<div id="notice_top">
	<div id="notice_List_total">
		<div class="listTbl">
			<ul>
				<li class="listTblTr listTblTh">
					<div class="InlineN" style="width: 90px">번호</div>
					<div class="InlineN" style="width: 480px">포트폴리오이름</div>
					<div class="Inlinev" style="width: 580px">회원아이디</div>
					<div class="Inlinev" style="width: 80px">테마</div>
					<div class="Inlinev" style="width: 100px">제작일</div>
					<div class="Inlinev" style="width: 130px">비고</div>
				</li>
			</ul>
			<ul id="pf_gall_ul" class="pf_gall_row">
				
			</ul>
		</div>
	</div>

	
	<!-- 게시판 검색 시작 { -->
	
	<div id="pf_sch">
			<select id="searchType" >
                <option value="all" ${pagingVO.searchType eq 'all' ? 'selected' : ' '}>전체</option>
	            <option value="theme" ${pagingVO.searchType eq 'theme' ? 'selected' : ' '}>테마</option>
	            <option value="userId" ${pagingVO.searchType eq 'userId' ? 'selected' : ' '}>회원아이디</option>
           </select>
		   <input type="text" value="${pagingVO.searchWord}" required id="pf_searchWord" class="sch_input" size="25" maxlength="20" placeholder="검색어를 입력해주세요">
           <button type="button" value="검색" class="sch_btn" id="pf_searchBth"><i class="fa fa-search" aria-hidden="true"></i></button>
	</div>
	<!-- } 게시판 검색 끝 -->

	<!-- 페이지 -->
	<div class="pg_wrap" id="pagingArea">
	</div>


	<form id="pf_searchForm">
		<input type="hidden" name="pf_searchType" value="${pagingVO.searchType}" />
		<input type="hidden" name="pf_searchWord" value="${pagingVO.searchWord}" />
		<input type="hidden" name="page" value="${pagingVO.currentPage }"/>
	</form>
	
	<form id="pf_blackForm">
		<input type="hidden" name="black_num" />
	</form>
	<form id="pf_readForm">
		<input type="hidden" name="read_num" />
	</form>
</div>