<%@page import="kr.or.ddit.Pay.service.PayServiceImpl"%>
<%@page import="kr.or.ddit.Pay.service.IPayService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<c:if test="${not empty msg}">
	alert("${msg}");
	<c:remove var="msg" scope="session"/>
</c:if>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


    <script>
    	
	//파라미터 값(가격) 가져오기 
    function getParam(sname) {

        var params = location.search.substr(location.search.indexOf("?") + 1);
        //디코딩
        params = decodeURI(params);
        
        var sval = "";
        params = params.split("&");

        for (var i = 0; i < params.length; i++) {
            temp = params[i].split("=");
            if ([temp[0]] == sname) { sval = temp[1]; }
        }
        return sval;
    }
	
    $(function(){
        var IMP = window.IMP; // 생략가능
        var params = getParam("price");
        var months = getParam("month");
        var rank =   getParam("rank");
        IMP.init('imp19887480'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'html5_inicis',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : 'Propofol 추가 결제',
            amount : params,
            buyer_email : '${sessionScope.authMember.mem_mail}',
            buyer_name : '${sessionScope.authMember.mem_name}',
            buyer_tel : '${sessionScope.authMember.mem_tel}',
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        
                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
                msg = '결제가 완료되었습니다.\n결제금액은 : '+rsp.paid_amount+'입니다.';
                updateMemberShip.submit();
                alert(msg);
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
                 alert("주문을 취소하셨습니다.");
                 location.href = "<c:url value='/'/>"
            }
        });
        
        
        var updateMemberShip = $('#updateMemberShip');
        updateMemberShip.on('submit', function(){
        	updateMemberShip.find('input[name="mem_membership"]').val(months);
        	updateMemberShip.find('input[name="mem_rank"]').val(rank);
        	updateMemberShip.find('input[name="mem_price"]').val(params);
        });
        
    });
    </script>
<form id="updateMemberShip" action="${cPath }/resultPayment">
	<input type="hidden" name="mem_id" value="${sessionScope.authMember.mem_id}">
	<input type="hidden" name="mem_membership">
	<input type="hidden" name="mem_rank">
	<input type="hidden" name="mem_price"> 
	
</form>