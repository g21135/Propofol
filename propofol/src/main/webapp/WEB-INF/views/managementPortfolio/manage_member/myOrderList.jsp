<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
	function paging(page) {
		pf_searchForm.find("input[name='page']").val(page);
		pf_searchForm.submit();
	}
	
	function successPfList(resp){
		  var pf_liTags = [];
		  $(resp.dataList).each(function(idx, order){
			  let readVar = order.order_end_date == null ? "미완료" : "완료";
			  let readVarClass = order.order_end_date == null ? "secondary" : "success"
			  let publicVar = order.order_date == null ? "미결제" : "결제";
			  let publicVarClass = order.order_date == null ? "secondary" : "primary";
			  let payVar = order.order_pay == null ? "미승인" : "승인";
			  let payVarClass = order.order_pay == null ? "secondary" : "primary";
			  let li = $("<li>").prop({"class" : "listTblTr listTblTd"})
			  .append(
					$("<div>").prop({"class" : "InlineN td_num", "style":"width: 90px"}).append(
							$("<span>").prop({"class" : "badge badge-"+readVarClass+"", "style" : "margin-right : 5px "}).text(readVar),
							$("<span>").text(order.order_num)
					),
					$("<div>").prop({"class" : "td_sub", "style":"width: 400px"}).append(
					 	    	$("<div>").prop({"class":"no_num"}).append(
					   	    		$("<a>").prop({"href": "#"}).append( //상세조회
					   	    			$("<em>").html(order.orderFormList[0].form_name),
						   	    		$("<span>").prop({"class" : "badge badge-"+publicVarClass+"", "style" : "margin-left : 5px "}).text(publicVar),
						   	    		$("<span>").prop({"class" : "badge badge-"+payVarClass+"", "style" : "margin-left : 5px "}).text(payVar)
					   	 			)
					   	 	    )  
					),
					$("<div>").prop({"class":"Inlinev td_name", "style":"width: 150px"}).append(
								$("<span>").prop({"class":"sv_member"})
										   .text(order.mem_id)
					),
					$("<div>").prop({"class":"Inlinev td_num", "style":"width: 100px"}).append(
							$("<span>").text(order.order_type)	
					),
					$("<div>").prop({"class":"Inlinev td_date", "style":"width: 100px"}).append(
							$("<span>").text(order.order_start_date)
					),
					$("<div>").prop({"class":"Inlinev td_date", "style":"width: 100px"}).append(
							$("<span>").text(order.order_end_date)
					),
					$("<div>").prop({"class":"Inlinev td_date", "style":"width: 100px"}).append(
							$("<span>").text(order.order_date)
					),
					$("<div>").prop({"class":"Inlinev td_button", "style":"width: 180px"}).append(
							$("<button onclick='paymentBtn("+order.order_num+")'>").prop({"type" : "button", "class":"btn btn-light", "style" : "margin : 0 5px"}).text("결제"),	
							$("<button onclick='modifyBtn("+order.order_num+")'>").prop({"type" : "button", "class":"btn btn-secondary", "style" : "margin : 0 5px"}).text("수정"),	
							$("<button onclick='deleteBtn("+order.order_num+")'>").prop({"type" : "button", "class":"btn btn-dark", "style" : "margin : 0 5px"}).text("삭제")	
					)
			 );
		   pf_liTags.push(li);
		   });
		   pf_ulTag.html(pf_liTags);
		   pagingArea.html(resp.pagingHTMLForBS);
	}
	
	function modifyBtn(order_num){
		pf_modifyForm.find("input[name='modify_num']").val(order_num);
		pf_modifyForm.submit();
		pf_modifyForm.find("input[name='modify_num']").val("");
	}
	
	function paymentBtn(order_num){
		pf_paymentForm.find("input[name='payment_num']").val(order_num);
		pf_paymentForm.submit();
		pf_paymentForm.find("input[name='payment_num']").val("");
	}
	
	$(function(){
		pf_searchForm = $('#pf_searchForm');
		pf_searchBth = $('#pf_searchBth');
		pf_modifyForm = $('#pf_modifyForm');
		pf_paymentForm = $('#pf_paymentForm');
		pf_ulTag = $("#pf_gall_ul");
		pagingArea = $("#pagingArea");
        var queryString = $(this).serialize();
        
        $.ajax({
        	url:"${cPath}/order/myOrderList",
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
            	url:"${cPath}/order/myOrderList",
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
        
        pf_modifyForm.on("submit", function(event){
        	event.preventDefault();
        	var queryString = $(this).serialize();
        	console.log(queryString);
        	$.ajax({
            	url:"${cPath}/order/modifyOrder",
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
        
        pf_paymentForm.on("submit", function(event){
        	event.preventDefault();
        	var queryString = $(this).serialize();
        	$.ajax({
            	url:"${cPath}/order/paymentOrder",
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
					<div class="InlineN" style="width: 90px">주문 번호</div>
					<div class="InlineN" style="width: 400px">요구사항</div>
					<div class="Inlinev" style="width: 150px">회원아이디</div>
					<div class="Inlinev" style="width: 100px">주문 타입</div>
					<div class="Inlinev" style="width: 100px">주문일자</div>
					<div class="Inlinev" style="width: 100px">완료일</div>
					<div class="Inlinev" style="width: 100px">결제일</div>
					<div class="Inlinev" style="width: 180px">비고</div>
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
	            <option value="type" ${pagingVO.searchType eq 'type' ? 'selected' : ' '}>주문타입</option>
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
		<input type="hidden" name="page" />
	</form>
	
	<form id="pf_modifyForm">
		<input type="hidden" name="modify_num" />
	</form>
	<form id="pf_paymentForm">
		<input type="hidden" name="payment_num" />
	</form>
</div>