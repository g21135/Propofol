<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<style>
	
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e8d766575fccfc436ac9842183cea79&libraries=services"></script>
<link href="${cPath}/css/makePortfolio/top.css" rel="stylesheet">
<link href="${cPath}/css/portfolio/myPort.css" rel="stylesheet">

<script>
function mapfunc(){
	if(document.getElementById('map') != null){
    	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	    mapOption = {
    	       center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
    	       level: 1 // 지도의 확대 레벨
    	   };  
    	// 지도를 생성합니다    
    	var map = new kakao.maps.Map(mapContainer, mapOption); 
    	
    	// 주소-좌표 변환 객체를 생성합니다
    	var geocoder = new kakao.maps.services.Geocoder();
    	
    	if($("#addr").val().length >0){
	    		
	    	// 등록된 주소를 표시하기.
	    	geocoder.addressSearch($("#addr").val(), function(result, status) {
	
	    	    // 정상적으로 검색이 완료됐으면 
	    	     if (status === kakao.maps.services.Status.OK) {
	
	    	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	    	        // 결과값으로 받은 위치를 마커로 표시합니다
	    	        var marker = new kakao.maps.Marker({
	    	            map: map,
	    	            position: coords
	    	        });
	
	    	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	    	        var infowindow = new kakao.maps.InfoWindow({
	    	            content: '<div style="width:150px;text-align:center;padding:6px 0;">기존등록주소</div>'
	    	        });
	    	        infowindow.open(map, marker);
	
	    	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    	        map.setCenter(coords);
	    	    } 
	    	}); 
    	}
    	
    	var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    	    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
    	
    	// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
    	searchAddrFromCoords(map.getCenter(), displayCenterInfo);
    	
    	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
    	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
    	    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
    	        if (status === kakao.maps.services.Status.OK) {
    	            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
    	            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
    	            
    	            var content = '<div class="bAddr">' + detailAddr + '</div>';
    	          
    	            // 마커를 클릭한 위치에 표시합니다 
    	            marker.setPosition(mouseEvent.latLng);
    	            marker.setMap(map);
    	
    	            // 인포윈도우에 클릭한 위치에 대한 상세 주소정보를 표시합니다
    	            infowindow.setContent(content);
    	            infowindow.open(map, marker);

    	    		// 클릭한 위도, 경도 정보를 가져옵니다 
    	    	    var latlng = mouseEvent.latLng; 
    	    	    
    	    	    // 마커 위치를 클릭한 위치로 옮깁니다
    	    	    marker.setPosition(latlng);
    	    	    
		            $("#addr").val(result[0].address.address_name);
		    	    $("#resultMap").html(content); 
    	        }   
    	    });
    	});
    	
    	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
    	kakao.maps.event.addListener(map, 'idle', function() {
    	    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
    	});
    	
    	function searchAddrFromCoords(coords, callback) {
    	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
    	}
    	
    	function searchDetailAddrFromCoords(coords, callback) {
    	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
    	}
    	
    	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
    	function displayCenterInfo(result, status) {
    	    if (status === kakao.maps.services.Status.OK) {
    	        var infoDiv = document.getElementById('centerAddr');
    	
    	        for(var i = 0; i < result.length; i++) {
    	            if (result[i].region_type === 'H') {
    	                infoDiv.innerHTML = result[i].address_name;
    	                break;
    	            }
    	        }
    	    }    
    	}
    	
    	$("#searchBtn").on("click",function(){
    		var searchText = $("#searchMap").val();
    		
    		var ps = new kakao.maps.services.Places(); 
    		ps.keywordSearch(searchText, placesSearchCB); 
    	})
    	
    	function placesSearchCB (data, status, pagination) {
    	    if (status === kakao.maps.services.Status.OK) {

    	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
    	        // LatLngBounds 객체에 좌표를 추가합니다
    	        var bounds = new kakao.maps.LatLngBounds();

    	        for (var i=0; i<data.length; i++) {
    	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
    	        }       

    	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    	        map.setBounds(bounds);
    	    } 
    	}
	}
}
function paging(page) {
	pf_searchForm.find("input[name='page']").val(page);
	pf_searchForm.submit();
}

function successPfList(resp){
	  var pf_divs = [];
	  
	  var addDiv = $("<div>").prop({"id":"pf_sideDiv"}).append(
	  		$("<div>").prop({"class":""}).append(
	  			$("<div>").prop({"class":""}).append(
	  				$("<a data-toggle='modal' data-target='#makeModal'>").prop({"href" : "#"}).append(
	  						$("<img class='img-a img-fluid'>").attr({src : "${cPath }/img/portfolio/newPort.png"} ).css({width:"150px", height:"200px"})		
	  				)	
	  			)
	  		)
	  )
	  pf_divs.push(addDiv)
	  $(resp.dataList).each(function(idx, port){
		  var port_ban = (port.port_ban == "Y"? true : false);
		  let div = $("<div>").prop({"class" : "col-md-4", "style" : "padding:10px 10px"})
		   .append(
			$("<div>").prop({"class" : "card-box-a card-shadow"}).append(
				$("<div>").prop({"class" : "img-box-a"}).append(
					$("<img class='img-a img-fluid'>").attr({src : "${cPath}/img/portfolio/" + port.port_img} ).css({width:"400px", height:"500px"}),
					(port_ban ?
							$("<h2>").text("제재").css({background : "red", color : "white", position: "absolute", top: "8%", left: "15%", transform: "translate( -50%, -50% )", padding: "5px"}) : ""		
					)
				),
				$("<div>").prop({"class" : "card-overlay"}).append(
					$("<div>").prop({"class":"card-overlay-a-content"}).append(
		   	    		$("<div>").prop({"class":"card-header-a"}).append(
		   	    			$("<h2>").prop({"class" : "card-title-a"}).html(port.port_name),
		   	    			$("<br>")
		   	 			),
						$("<div>").prop({"class":"card-body-a"}).append(
							$("<div>").prop({"class":"price-box d-flex"}).append(
								$("<a onclick='updateBtn("+port.port_num+")'>").prop({"href":"#"}).append(
									$("<sapn>").prop({"class":"price-b"}).text("수정")		
								),
								$("<a onclick='deleteBtn("+port.port_num+")'>").prop({"href":"#"}).append(
									$("<sapn>").prop({"class":"price-b"}).text("삭제")		
								)
							),
							$("<br>"),
							$("<a>").prop({"href":port.port_addr, "class" : "link-a"}).text("포트폴리오 조회").append(
								$("<span>").prop({"class" : "ion-ios-arrow-forward"})		
							)
						),
						$("<div>").prop({"class":"card-footer-b"}).append(
							$("<ul>").prop({"class":"card-info d-flex justify-content-around"}).append(
								$("<li>").append(
									$("<h4>").prop({"class" : "card-info-title"}).text("정보수정"),
									$("<button onclick='configBtn("+port.port_num+")'>").prop({"type" : "button", "class" : "btn btn-secondary", "style" : "padding: 2px 15px; margin-top: -3px"}).text("수정")
								),
								$("<li>").append(
									$("<h4>").prop({"class" : "card-info-title"}).text("PPT변환"),
									$("<button>").prop({"type" : "button", "class" : "btn btn-secondary", "style" : "padding: 2px 15px; margin-top: -3px"}).text("변환")
								),
								$("<li>").append(
									$("<h4>").prop({"class" : "card-info-title"}).text("PDF변환"),
									$("<button>").prop({"type" : "button", "class" : "btn btn-secondary", "style" : "padding: 2px 15px; margin-top: -3px"}).text("변환")
								)
							)	
						)
					)  
				)
			)
		);
		  pf_divs.push(div);
	   });
	  pf_div.html(pf_divs);
	  pagingArea.html(resp.pagingHTMLForBS);
}

function modalAjax(port){
	var question_tel = (port.question_tel == "Y" ? "checked" : "");
	var question_sns = (port.question_sns == "Y" ? "checked" : "");
	var question_map = (port.question_map == "Y" ? "checked" : "");
	var Ychecked = (port.port_public == "Y"? "checked" : "");
	var Nchecked = (port.port_public == "N"? "checked" : "");
	var div = $('<div>').prop({"id":"portInfoModal","class" : "modal-content", "style" : "width : 680px; top:20px;"}).append(
		$('<form>').prop({"id" : "saveForm", "action" : "${cPath}/makePortfolio/updatePortInfo", "method" : "post"}).append(
			$('<input type="hidden" name="port_num" value="'+port.port_num+'">'),
			$('<input type="hidden" name="question_tel" value="'+port.question_tel+'">'),
			$('<input type="hidden" name="question_sns" value="'+port.question_sns+'">'),
			$('<input type="hidden" name="question_map" value="'+port.question_map+'">'),
			$('<div class="modal-body">').append(
				$('<table>').append(
					$('<tr>').append(
						$('<td class="config-td1">').text("포트폴리오 이름"),
						$('<td>').append(
							$('<input class="form-control" type="text" name="port_name" style="width: 90%; display: inline-block;">').prop({"value" : port.port_name})
						),
						$('<td rowspan="5">').append( 
								$('<img id="foo" class="img-rounded">').attr({src : "${cPath }/img/portfolio/"+port.port_img} ).css({width:"200px", height:"270px","border-radius": "8px"})	
						)
					),
					$('<tr>').append(
						$('<td class="config-td1">').text("주소 설정"),
						$('<td>').append(
							$('<span>').text("localhost/portfolio/")	,
							$('<input class="form-control" type="text" name="port_addr" style="width: 43%; display: inline-block;">').prop({"value" : port.port_addr})
						)
					),
					$('<tr>').append(
						$('<td class="config-td1">').text("공개 설정"),
						$('<td>').append(
							$('<label>').append(
								$('<input type="radio" name="port_public" value="Y" '+Ychecked+'>')	,
								$('<span>').text("공개")
							),
							$('<label>').append(
								$('<input type="radio" name="port_public" value="N" style="margin-left: 25px;" '+Nchecked+'>'),
								$('<span>').text("비공개")
							)
						)
					),
					$('<tr>').append(
						$('<td class="config-td1">').text("포트폴리오 설명"),
						$('<td>').append(
							$('<textarea class="form-control" name="port_explain" style="resize: none; width:90%;">').text(port.port_explain)		
						)
					),
					$('<tr>').append(
						$('<td class="config-td1">').text("대표이미지"),
						$('<td>').append(
							$('<input id="port_image" type="file" name="port_image">')		
						)
					),
						$('<tr id="content1" style="'+(port.question_tel == "Y"? "":"display:none;")+'">').append(
							$('<td class="config-td1">').text("전화번호"),
							$('<td>').append(
								$('<input class="form-control" type="text" name="port_tell_number" style="width:90%">').val(port.port_tell_number)
						)
					),
					$('<tr id="content2" style="'+(port.question_sns == "Y"? "":"display:none;")+'">').append(
						$('<td class="config-td1">').text("SNS 등록"),
						$('<td colspan="2">').append(
							$('<select class="form-control" name="port_sns_name" style="height: 35px; width: 125px; display: inline-block;">').append(
								$('<option>').text("선택"),
								$("<option value='facebook'"+(port.port_sns_name=='facebook'?'selected': '')+">Facebook</option>"),
								$("<option value='instagram'"+(port.port_sns_name=='instagram'?'selected': '')+">Instagram</option>")
							),
							$('<input class="form-control" type="text" name="port_sns_addr" style="width: 75%;display: inline-block;">)').prop({"value" : port.port_sns_addr})
						)
					),
						$('<tr id="content3" style="'+(port.question_map == "Y"? "":"display:none;")+'">').append(
							$('<td class="config-td1">').text("위치 등록"),
							$('<td colspan="2">').append(
								$('<input class="form-control" id="searchMap" type="text" style="margin-top: 15px; width: 264px; display: inline-block;">').prop({"value" : port.port_user_addr}),
								$('<input class="btn btn-success" id="searchBtn" type="button" value="검색" style="height: 34px;">'),
								$('<div id="map" style="width:100%; height: 300px; margin-top: 10px;">'),
								$('<div class="hAddr">').append(
									$('<span id="centerAddr">')	
								),
								$('<div id="clickLatlng" style="height: 50px;">').append(
									$("<div>").prop({"id":"resultMap"}).css("hight","50px").html(port.port_user_addr)	
								),
								$('<input id="addr" type="hidden" name="port_user_addr">').prop({"value" : port.port_user_addr})
							)
					)	
				) // table
			), // div
			$('<div class="modal-footer">').append(
				$("<label for='radio1' class='labelClass'>").text("전화번호").append($('<input id="check1" class="checkClass" '+ question_tel +' type="checkbox" >')),
				$("<label for='radio2' class='labelClass'>").text("sns").append($('<input id="check2" class="checkClass" '+ question_sns +' type="checkbox">')),
				$("<label for='radio3' class='labelClass'>").text("위치").append($('<input id="check3" class="checkClass"  '+ question_map +'  type="checkbox">')),
				$('<input type="button" class="btn btn-default" data-dismiss="modal" value="닫기">'),
				$('<input id="savePortInfo" type="button" class="btn btn-primary"  data-dismiss="modal" value="저장">')
			)
		)//form		
	);	
	modal_content.html(div);
    configModal.on('shown.bs.modal', function () {
    	if(port.question_map == "Y"){
	    	mapfunc();
    	}
    })
}
$(document).on("click","#check1",function(){
	
	var saveForm = $("#saveForm");
	if($("#content1").css("display") == "none"){
		$("#content1").show(function(){
			saveForm.find("[name=question_tel]").val("Y");
		});
	}else{
		$("#content1").hide(function(){
			saveForm.find("[name=question_tel]").val("N");
			saveForm.find("[name=port_tell_number]").val("");
		});
	}
})
$(document).on("click","#check2",function(){
	var saveForm = $("#saveForm");
	if($("#content2").css("display") == "none"){
		$("#content2").show(function(){
			saveForm.find("[name=port_sns_name] option:eq(0)").prop("selected",true);
			saveForm.find("[name=question_sns]").val("Y");
		});
	}else{
		$("#content2").hide(function(){
			saveForm.find("[name=question_sns]").val("N");
			saveForm.find("[name=port_sns_name]").val("");
			saveForm.find("[name=port_sns_addr]").val("");
		});
	}
})

$(document).on("click","#check3",function(){
	var saveForm = $("#saveForm");
	if($("#content3").css("display") == "none"){
		$("#content3").show(function(){
			mapfunc();
			saveForm.find("[name=question_map]").val("Y");
		});
	}else{
		$("#content3").hide(function(){
			saveForm.find("[name=question_map]").val("N");
			saveForm.find("[name=port_user_addr]").val("");
			saveForm.find("#searchMap").val("");
			saveForm.find("#resultMap").empty();
		});
	}
})


function updateBtn(port_num){
	pf_updateForm.find("input[name='update_num']").val(port_num);
	pf_updateForm.submit();
	pf_updateForm.find("input[name='update_num']").val("");
}

function deleteBtn(port_num){
	pf_deleteForm.find("input[name='delete_num']").val(port_num);
	var check = confirm("정말로 삭제하시겠습니까?");
	if(check){
		pf_deleteForm.submit();
	}else{
		return;
	}
	pf_deleteForm.find("input[name='delete_num']").val("");
}

function publicSettingBtn(port_num, port_public){
	pf_publicSettingForm.find("input[name='port_num']").val(port_num);
	pf_publicSettingForm.find("input[name='port_public']").val(port_public == "Y" ? "N" : "Y");
	var str = (port_public == "Y" ? "공개" : "비공개");
	var check = confirm("현재 " + str + " 설정입니다. 변경 하시겠습니까?");
	if(check){
		pf_publicSettingForm.submit();
	}else{
		return;
	}
	pf_publicSettingForm.find("input[name='publicSetting_num']").val("")z;
}

function configBtn(port_num){
	configForm.find("input[name='config_num']").val(port_num);
	configForm.submit();
	configForm.find("input[name='config_num']").val("");
}

$(function(){
	pf_searchForm = $('#pf_searchForm');
	pf_searchBth = $('#pf_searchBth');
	pf_div = $("#pf_div");
	pf_updateForm = $("#pf_updateForm");
	pf_deleteForm = $("#pf_deleteForm");
	pf_publicSettingForm = $("#pf_publicSettingForm");
	configForm = $("#configForm");
	
	pagingArea = $("#pagingArea");
	
	modal_content = $("#modal_content");
    configModal = $("#configModal");
    
	makeModal = $("#makeModal");	
	makeModal2 = $("#makeModal2");	
	makeBeforeForm = $("#makeBeforeForm");
	themeContent = $(".themeContent");
	themeImg = $(".themeImg");
	theme_num =$("[name=theme_num]");
	
	makeModal.on("hide.bs.modal",function(){
		var q1 =$("[name=q1]:checked");
		var q2 =$("[name=q2]:checked");
		var q3 =$("[name=q3]:checked");
		var question1 = $("[name=question1]");
		var question2 = $("[name=question2]");
		var question3 = $("[name=question3]");
		question1.val(q1.val());
		q1.prop('checked', false);
		question2.val(q2.val());
		q2.prop('checked', false);
		question3.val(q3.val());
		q3.prop('checked', false);
	});

	makeModal2.on("hide.bs.modal",function(){
		makeBeforeForm[0].reset();
		themeContent.css("border","");
		theme_num.val(1);
	});
	
	themeContent.on("click",function(){
		themeContent.css("border","");
		$(this).css("border","solid 3px gray");
		var tn = $(this).find(themeImg).attr("id");
		theme_num.val(tn);
	}) 
	
    var queryString = $(this).serialize();
    
    $.ajax({
    	url:"${cPath}/memberMenagement/myPortList",
    	method : "get",
        data : queryString,
        dataType : "json",
        success : function(resp){
        	successPfList(resp);
		},
		error : function(errorResp){
			console.log(errorResp.status + ", " + errorResp.responseText);
		}
	});
    
    pf_deleteForm.on("submit", function(event){
    	event.preventDefault();
    	var queryString = $(this).serialize();
		var data = $(this).find("[name=delete_num]").val();
    	$.ajax({
        	url:"${cPath}/makePortfolio/deletePort",
        	method : "post",
	        data : {"delete_num":data},
	        dataType : "json",
	        success : function(resp){
	        	if(resp.success){
	        		alert("삭제 완료!");
	        	}else{
	        		alert("삭제 실패!");
	        	}
	        	
	        	pf_searchForm.submit();
			},
			error : function(errorResp ){
				console.log(errorResp.status + ", " + errorResp.responseText);
			}
		});
    });
    
    pf_publicSettingForm.on("submit", function(event){
    	event.preventDefault();
    	var queryString = $(this).serialize();
    	$.ajax({
        	url:"${cPath}/memberMenagement/publicSetting",
        	method : "get",
	        data : queryString,
	        dataType : "json",
	        success : function(resp){
	        	alert(resp.message);
	        	pf_searchForm.submit();
			},
			error : function(errorResp){
				console.log(errorResp.status + ", " + errorResp.responseText);
			}
		});
    });
    
    configForm.on("submit", function(event){
    	event.preventDefault();
    	var queryString = $(this).serialize();
    	$.ajax({
        	url:"${cPath}/memberMenagement/config",
        	method : "get",
	        data : queryString,
	        dataType : "json",
	        success : function(resp){
	        	modalAjax(resp);
	        	configModal.modal("show");
	        },
			error : function(errorResp){
				console.log(errorResp.status + ", " + errorResp.responseText);
			}
		});
    });
    
}); //$(function(){}) close

$(document).on("click","#savePortInfo",function(){
	var saveForm = $("#saveForm");
	let action = saveForm.attr("action");
	let method = saveForm.attr("method");
	
	let form = saveForm[0];
	let formData = new FormData(form);
	
	$.ajax({
		url : action, 
		method : method,
		dataType : "json",
		data : formData,
		enctype: "multipart/form-data",
		processData: false,
        contentType: false,
		success : function(resp){
			if(resp.success){
				alert("저장이 완료되었습니다!");
				pf_searchForm.submit();
			}else{
				alert("에러발생");
			}
		},
		error : function(error){
			console.log(error);
		}
	})
})
</script>

<div class="container">
	<br>
	<div class="row" id="pf_div">
		
	</div>
	<br>
	
	<!-- 페이지 -->
	<div class="pg_wrap" id="pagingArea">
	</div>

	
	<form id="pf_updateForm" action="${cPath}/makePortfolio/update" method="post">
		<input type="hidden" name="update_num" />
	</form>
	
	<form id="pf_deleteForm">
		<input type="hidden" name="delete_num" />
	</form>
	
	<form id="configForm">
		<input type="hidden" name="config_num" />
	</form>
	
	<form id="pf_publicSettingForm">
		<input type="hidden" name="port_num" />
		<input type="hidden" name="port_public" />
	</form>
	
</div>

<link href="${cPath}/css/makePortfolio/before.css" rel="stylesheet"/>

<div class="modal fade" id="configModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" id="modal_content">
  </div>
</div>
	
<form id="makeBeforeForm" action="<c:url value='/makePortfolio'/>" method="post">
	<!-- Modal -->
	<div class="modal fade" id="makeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog" style="top: 12%; left: -6%;">
	    <div class="modal-content" style="width: 800px">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      </div>
	      <div class="content" class="modal-body">
	      <img class="more beforeMain" src="${cPath}/img/makePortfolio/recommend.jpg" style="float: left;">
	    	  <div style="display: inline-block;">
			      <div class="text">
				      <p>1. 자신의 연락처와 이메일 주소를 표기하시나요?</p>
				      <label><input type="radio" name="q_tel" value="Y"/> 네  </label> &nbsp;&nbsp;
				      <label><input type="radio" name="q_tel" value="N"/> 아니오 </label>
			      </div>
			      <div class="text">
				      <p>2. 자신의 SNS계정(페이스 북,인스타)을 표기하시나요?</p>
				      <label><input type="radio" name="q_sns" value="Y"/> 네 </label> &nbsp;&nbsp;
				      <label><input type="radio" name="q_sns" value="N"/> 아니오 </label>
			      </div>
			      <div class="text">
				      <p>3. 자신의 위치를 지도를 통해 표기하시나요?</p>
				      <label><input type="radio" name="q_map" value="Y"/> 네 </label> &nbsp;&nbsp;
				      <label><input type="radio" name="q_map" value="N"/> 아니오 </label>
			      </div>
			      <input type="hidden" name="question_map"/>
			      <input type="hidden" name="question_tel"/>
			      <input type="hidden" name="question_sns"/>
		      </div>
	      </div> 
	      <div class="modal-footer">
	        <button data-toggle="modal" data-target="#makeModal2" type="button" class="btn btn-primary" onclick="makeModal.modal('hide');">다음</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="modal fade" id="makeModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog" style="width: 800px; top: 12%; left: -6%;">
	    <div class="modal-content" style="width: 800px">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      </div>
	      <div class="content" class="modal-body">
	      <img class="more beforeMain" src="${cPath}/img/makePortfolio/theme.jpg">
			  <div id="divide">	
				<c:if test="${not empty themeList}">
					<c:forEach var="item" items="${themeList}" varStatus="vs">
						<c:if test="${0 eq vs.count%5}">
							<br>
						</c:if>
						<div class="themeContent">
							<img class="themeImg" id="${item.theme_num}" src="${cPath}/img/makePortfolio/theme/${item.theme_img}">
							<span class="themeName">${item.theme_name}</span> 
						</div>
					</c:forEach>
				</c:if>
				<input type="hidden" name="theme_num" value="1">
		      </div>
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-primary">제작</button>
	      </div>
	    </div>
	  </div>
	</div>
</form>
<script>
var makeModal = $("#makeModal");	
var makeModal2 = $("#makeModal2");	
var makeBeforeForm = $("#makeBeforeForm");	
var themeContent = $(".themeContent");
var theme_num =$("[name=theme_num]");

makeModal.on("hide.bs.modal",function(){
	var q_map =$("[name=q_map]:checked");
	var q_tel =$("[name=q_tel]:checked");
	var q_sns =$("[name=q_sns]:checked");
	var question_map = $("[name=question_map]");
	var question_tel = $("[name=question_tel]");
	var question_sns = $("[name=question_sns]");
	question_map.val(q_map.val());
	q_map.prop('checked', false);
	question_tel.val(q_tel.val());
	q_tel.prop('checked', false);
	question_sns.val(q_sns.val());
	q_sns.prop('checked', false);
});

makeModal2.on("hide.bs.modal",function(){
	makeBeforeForm[0].reset();
	themeContent.css("border","");
	theme_num.val(1);
});

//파일 선택시 이미지 태그에 이미지 변경
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#foo').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
$(document).on("change","#port_image",function() {
	readURL(this);
});   
</script>
