<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 좋아요 폼 -->
<form method="post" id="likeForm" action="${cPath}/sucPortfolio">
	<input name="port_num" type="hidden" />
	<input name="mem_id" type="hidden" value="${sessionScope.authMember.mem_id}" />
</form>

<form method="post" id="deleteForm" action="${cPath}/sucPortfolio">
	<input type="hidden" name="_method" value="delete" />
	<input name="port_num" type="hidden" />
	<input name="mem_id" type="hidden" value="${sessionScope.authMember.mem_id}" />
</form>

<script>
	function paging(page) {
		pf_searchForm.find("input[name='page']").val(page);
		pf_searchForm.submit();
		pf_searchForm.find("input[name='page']").val("");
	}
	
	function successPfList(resp){
		  var pf_liTags = [];
		  $(resp.dataList).each(function(idx, port){
			  	var like_num = port.like_num == 0 ? "좋아요" : "좋아요 취소";
				var like_func = port.like_num == 0 ? "like("+port.port_num+")" : "deleteLike("+port.port_num+")";
				var heart = port.like_num == 0 ? "fa fa-heart" : "fa fa-heart-o";
		     let li = $("<li>").prop({"class" : "pf_gall_li col-gn-3 gallWST"})
		                 .append(
		                     $("<div>").prop({"class" : "pf_gall_box"}).append(
		                    	$("<div>").prop({"class" : "pf_gall_chk"})	.append(
		                    		$("<span>").prop({"class" : "pf_sound_only"})	
		                    	),
		                    	$("<div>").prop({"class" : "pf_gall_con"}).append(
		                    		$("<div>").prop({"class" : "pf_gall_boxa"}).append(
		                    			$("<a>").prop({"href" : port.port_addr }).append(
		                    				$("<em>").prop({"class" : "pf_iconPs pf_tit"}).append(
		                    					$("<i>").prop({"class" : "fa fa-bullhorn pf_icoNotice"}).css({background:"none"}),
			                    				$("<span>").text(port.port_addr).css({color:"white"})
		                    				),
		                    				$("<i>").prop({"class" : "pf_imgAr"}).append(
		                    					$("<img>").attr({src : "${cPath}/img/"+ port.port_img} ).css({width:"300px", height:"250px"})	
		                    				),
		                    				$("<em>").prop({"class" : "pf_gall_info"}).append(
		                    					$("<span>").prop({"class" : "pf_sound_only"}).text(port.themeList[0].theme_name),
		                    					$("<i>").prop({"class" : "fa fa-hashtag", "aria-hidden" : "true"}),
		                    					$("<span>").text(port.themeList[0].theme_name),
		                    					$("<br>"),
		                    					$("<span>").prop({"class" : "pf_gall_date"}).append(
		                    						$("<span>").prop({"class" : "pf_sound_only"}).text(port.port_date),
		                    						$("<i>").prop({"class" : "fa fa-hashtag", "aria-hidden" : "true"}),
		                    						$("<span>").text(port.port_date)
		                    					),
		                    					$("<u>").append(
		                    						$("<span>").prop({"class" : "pf_sound_only"}).text(port.mem_id),
		                    						$("<span>").text(port.mem_id)
		                    					),
		                    					$("<u>").append(
		                    						$("<i>").prop({"class" : "fa fa-heart", "style":"color:red;"}).text(port.port_like)	
		                    					)
		                    				) //</em>
		                    			) //</a>
		                    		), // </div>	
		                    		$("<div>").prop({"class" : "pf_gall_text_href"}).append(
				                    		$("<span>").prop({"class" : "pf_tit"}).append(
				                    			$("<span>").text(port.port_name),
				                    			$("<br>"),
				                    			$("<button>").prop({"type" : "button", "class" : "btn btn-light", "id":"likeBtn" + port.port_num + ""})
				                    							.attr({"onclick" : like_func})
				                    						 .append(
				                    					$("<i>").prop({"class" : heart})
				                    							.text(like_num)	
				                    			)
			                    		) // </span>
			                    	) // </div>
		                     ) // </div>
		             ) // </div>
		      ); // </li>
		   pf_liTags.push(li);
		   });
		   pf_ulTag.html(pf_liTags);
		   pg_wrap.html(resp.pagingHTMLForBS);
	}
	
	function like(port_num){
		var mem_id = $("#member_id").val();
		var likeBtn=$("#likeBtn"+port_num+""); 
			if(!mem_id) {
				var check = confirm("로그인 후 이용 가능합니다");
				if(check){
					$("#myModal").modal("show");					
				}else{
					return;
				}
			}else{
				$("[name=port_num]", "#likeForm").val(port_num);
			    $("#likeForm").submit();
			}
	 };
	 
	function deleteLike(port_num){
		var mem_id = $("#member_id").val();
		var likeBtn=$("#likeBtn"+port_num+""); 
			if(!mem_id) {
				var check = confirm("로그인 후 이용 가능합니다");
				if(check){
					$("#myModal").modal("show");					
				}else{
					return;
				}
			}else{
				$("[name=port_num]", "#deleteForm").val(port_num);
			    $("#deleteForm").submit();
			}
	 };
	
	$(function(){
		pf_searchForm = $('#pf_searchForm');
		pf_searchBth = $('#pf_searchBth');
		pf_ulTag = $("#pf_gall_ul");
		pg_wrap = $("#pg_wrap");
        var queryString = $(this).serialize();
        
        $.ajax({
        	url:"${cPath}/sucPortfolio",
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
        	$.ajax({
            	url:"${cPath}/sucPortfolio",
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
    		var mem_id = $("#mem_id");
    		pf_searchForm.find("input[name='pf_searchType']").val(pf_searchType.val());
    		pf_searchForm.find("input[name='pf_searchWord']").val(pf_searchWord.val());
    		pf_searchForm.find("input[name='mem_id']").val(mem_id.val());
    		pf_searchForm.submit();
        })
        
        var likeForm = $("#likeForm"); 
        var deleteForm = $("#deleteForm"); 
        
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
				pf_searchForm.submit();
   	          },
   	          error : function(errorResp) {
   	             console.log(errorResp.status + ", "
   	                   + errorResp.responseText)
   	          }
   	       });
   	       return false;
   	    } // commonHandler end
    	likeForm.on("submit", commonHandler); 
    	deleteForm.on("submit", commonHandler); 
	})
</script>

<div id="pfWrap">
	<input name="mem_id" id="member_id" type="hidden" value="${sessionScope.authMember.mem_id}">
	<div id="pf_container">

		<!-- 게시판 목록 시작 { -->
		<div id="pf_gall" style="width: 100%">


			<!-- 게시판 페이지 정보 및 버튼 시작 { -->
<!-- 			<div id="bo_btn_top"> -->
<!-- 				<div id="bo_list_total"> -->
<!-- 					<span><i class="fa fa-file-o"></i> Total 16 /</span> 1 page -->
<!-- 				</div> -->

<!-- 				<ul class="btn_bo_user"> -->
<!-- 					<li><a href="./rss.php?bo_table=gallery" class="btn_b01 btn"><i -->
<!-- 							class="fa fa-rss" aria-hidden="true"></i> RSS</a></li> -->
<!-- 				</ul> -->
<!-- 			</div> -->
			<!-- } 게시판 페이지 정보 및 버튼 끝 -->
			
			<ul id="pf_gall_ul" class="pf_gall_row">
				
			</ul>
			
			<!-- 게시판 검색 시작 { -->
			
			<div id="pf_sch">
					<select id="pf_searchType" >
		                <option value="all" ${pagingVO.searchType eq 'all' ? 'selected' : ' '}>전체</option>
			            <option value="theme" ${pagingVO.searchType eq 'theme' ? 'selected' : ' '}>테마</option>
			            <option value="userId" ${pagingVO.searchType eq 'userId' ? 'selected' : ' '}>회원아이디</option>
		           </select>
					<label for="stx" class="pf_sound_only">검색어
					<strong	class="pf_sound_only"> 필수</strong></label> 
					<input type="text" value="${pagingVO.searchWord}" required id="pf_searchWord" class="sch_input" size="25" maxlength="20" placeholder="검색어를 입력해주세요">
           			<button type="button" value="검색" class="sch_btn" id="pf_searchBth"><i class="fa fa-search" aria-hidden="true"></i><span class="sound_only">검색</span></button>
			</div>
			<!-- } 게시판 검색 끝 -->
		
			<!-- 페이지 -->
			<div class="pg_wrap" id="pg_wrap">
			</div>
		</div>
		<!-- } 게시판 목록 끝 -->
</div>
<!-- // #container 닫음 -->

	<form id="pf_searchForm">
		<input type="hidden" name="pf_searchType" value="${pagingVO.searchType}" />
		<input type="hidden" name="pf_searchWord" value="${pagingVO.searchWord}" />
		<input type="hidden" name="page" />
	</form>
</div>