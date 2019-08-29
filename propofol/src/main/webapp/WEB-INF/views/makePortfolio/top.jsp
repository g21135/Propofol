<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<link href="${cPath}/css/makePortfolio/top.css" rel="stylesheet">
<div id="header">
	<div class="left">
		<a href="${cPath}/managementPort"><i class="fas fa-chevron-left"> 포트폴리오 관리</i></a>
	</div>
	<div class="input-protName">
		<c:if test="${empty pv.port_name}">
			<input id="menuName" class="inputMenuName" type="text" value="${sessionScope.authMember.mem_name}님의 포트폴리오(임시)">
		</c:if>
		<c:if test="${not empty pv.port_name}">
			<input id="menuName" class="inputMenuName" type="text" value="${pv.port_name}">
		</c:if>
	
		<span class="top-underline-animation "></span>
	</div>
	<span id="configSapn" data-toggle="modal" data-target="#configModal">
		<i id="config" class="config fas fa-cog">정보수정</i>
	</span>
	
	<div class="right">
		<a id="preview" href="#"><i class="far fa-window-maximize"> 미리보기</i></a>
		<a id="tempSave" href="#"><i class="far fa-save"> 임시저장</i></a>
		<a href="#"><i class="far fa-share-square"> 홈페이지 반영</i></a>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="configModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width: 650px;top: 20px;">
    <div class="modal-content">
   	 <form id="tempSaveForm" action="${cPath}/makePortfolio/tempSave" method="post" encType="multipart/form-data" >
<!--    	  <input type="hidden" name="method" value="_put">	 -->
   	  <input type="hidden" name="theme_num" value="${theme_num}">	
   	  <input type="hidden" name="port_name">	
   	  <input type="hidden" name="port_num" value="${pv.port_num}">	
   	  <input type="hidden" name="question_tel">
      <input type="hidden" name="question_sns">
	  <input type="hidden" name="question_map">
      <div class="modal-body">
	      <table>
				<tr>
					<td class="config-td1">주소 설정</td>
					<td>
						<span>http://localhost/portfolio/</span>
						<input class="form-control" type="text" name="port_addr" style="width: 36%; display: inline-block;" value="${pv.port_addr}"></td>
					<td rowspan="4">
						<c:if test="${empty pv.port_img}">
							<img class="img-rounded" src="${cPath}/img/notImage.png" style="width: 200px; height: 230px; ">	
						</c:if>
						<c:if test="${not empty pv.port_img}">
							<img class="img-rounded" src="${cPath}/portfolio/${pv.port_img}" style="width: 200px; height: 230px; ">	
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="config-td1">공개 설정</td>
					<td>
						<label><input type="radio" name="port_public" value="Y" ${pv.port_public eq 'Y' ? 'checked': ''}> 공개 </label>
						<label><input type="radio" name="port_public" value="N" style="margin-left: 25px;"${pv.port_public eq 'N' ? 'checked': ''}> 비공개 </label>
					</td>
				</tr>
				<tr>
					<td class="config-td1">포트폴리오 설명</td>
					<td><textarea class="form-control" name="port_explain" style="resize: none;width:90%;">${pv.port_explain}</textarea></td>
				</tr>
				<tr>
					<td class="config-td1">대표이미지</td>
					<td><input type="file" name="port_image" value="${pv.port_img}"></td>
				</tr>
				<c:if test="${question_tel eq 'Y' or pv.question_tel eq 'Y'}">
					<tr>
						<td class="config-td1">전화번호</td>
						<td><input class="form-control" type="text" name="port_tell_number" style="width:90%" value="${pv.port_tell_number}"></td>
					</tr>
				</c:if>
				<c:if test="${question_sns eq 'Y' or pv.question_sns eq 'Y'}">
					<tr>
						<td class="config-td1">SNS 등록</td>
						<td colspan="2">
							<select class="form-control" name="port_sns_name" style="height: 35px; width: 110px; display: inline-block;">
								<option>선택</option>
								<option value="facebook" ${pv.port_sns_name eq 'facebook' ? 'selected': ''}>Facebook</option>
								<option value="instagram" ${pv.port_sns_name eq 'instagram' ? 'selected': ''}>Instagram</option>
							</select>
							<input class="form-control" id="" type="text" name="port_sns_addr" style="width: 75%;display: inline-block;"
							value="${pv.port_sns_addr}">
						</td>
					</tr>
				</c:if>
				<c:if test="${question_map eq 'Y' or pv.question_map eq 'Y'}">
					<tr>
						<td class="config-td1">위치 등록</td>
						<td colspan="2">
						
							<input class="form-control" id="searchMap" type="text" 
							style="margin-top: 15px; width: 264px; display: inline-block;" value="${pv.port_user_addr}">
							<input class="btn btn-success" id="searchBtn" type="button" value="검색" style="height: 34px;">
							
							<div id="map" style="width:100%; height: 300px; margin-top: 10px;"></div>
						    <div class="hAddr">
								<span id="centerAddr"></span>
						    </div>
							<div id="clickLatlng" style="height: 50px;">
							  <div id="resultMap" class="bAddr">${pv.port_user_addr}</div>
							</div>
							<input id="addr" type="hidden" name="port_user_addr" value="${pv.port_user_addr}">
						</td>	
					</tr>
				</c:if>
			</table>
      </div>
      <div class="modal-footer">
        <input type="reset" class="btn btn-default" style="float: left;" value="초기화 ">
        <input type="button" class="btn btn-default" data-dismiss="modal" value="닫기">
        <input id="savePortInfo" type="button" class="btn btn-primary" data-dismiss="modal" value="저장">
      </div>
	</form>
    </div>
  </div>
</div>


<form id="previewForm" action="${cPath}/makePortfolio/preview" method="post" target="_blank">
</form>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e8d766575fccfc436ac9842183cea79&libraries=services"></script>
<script>
$("#configSapn").on('mouseenter', function(event) {
	$(this).css({"color":"white","border": "1px solid white"});
	$("#config").css({"color":"white"});
}).on('mouseleave', function(event) {
	$(this).css({"color":"gray","border": ""});
	$("#config").css({"color":"gray"});
});

var previewForm = $("#previewForm");
var tempSaveForm = $("#tempSaveForm");
var configModal = $("#configModal");
var searchBtn = $("#searchBtn");
var savePortInfo = $("#savePortInfo");

$("#tempSave").on("click",function(){
	$("[name=port_name]").val($("#menuName").val());
	
	if(!$("#layout").length){
		alert("현재 화면에서는 임시저장을 할 수 없습니다.");
		return;
	}
	if(!$("[name=port_name]").val()){
		alert("포트폴리오명을 입력해주세요");
		return;
	}
	if(!$("[name=port_addr]").val()){
		alert("포트폴리오 주소를 정보 수정에서 입력해주세요");
 		return;
	}
	if(!$("[name=public]:checked")){
		alert("공개여부를 정보 수정에서 선택해주세요");
 		return;
	}
	
	successTag.trigger("click");
	modifyTag.trigger("mouseleave");
	
	var pageContent = $("#page #pageView .pageContent");
	
	for(name in CKEDITOR.instances)
	{
	    CKEDITOR.instances[name].destroy(true);
	}
	$("#content").find(".edit").each(function(){ 
		$(this).prop("contenteditable",false);
	});

	pageContent.each(function(i,v) {
		var name = $(this).find("input.inputMenuName").val();	
		var content = $(this).find(".makePage").data("content").html();
		var imgSrc = $(this).find(".makePage").attr("src");
		tempSaveForm.append($("<input>").prop({"class":"tempClass","type":"hidden","name":"tempSaveMenu"}).val(name));
		tempSaveForm.append($("<input>").prop({"class":"tempClass","type":"hidden","name":"tempSaveContent"}).val(content));
		tempSaveForm.append($("<input>").prop({"class":"tempClass","type":"hidden","name":"imgSrc"}).val(imgSrc));
	})
	
	tempSaveForm.find("[name=question_tel]").val("${pv.question_tel}");
	tempSaveForm.find("[name=question_sns]").val("${pv.question_sns}");
	tempSaveForm.find("[name=question_map]").val("${pv.question_map}");

	tempSaveForm.submit();
	tempSaveForm.find(".tempClass").remove();
	
	$("#content").find(".edit").each(function(){ 
		$(this).prop("contenteditable",true);
		
		CKEDITOR.inline($(this).attr("id"),{
			extraPlugins: 'font, sourcedialog, image2, html5video, widget, widgetselection, clipboard, lineutils, youtube, colorbutton, panelbutton',
		    removePlugins: 'image',
		    filebrowserBrowseUrl: '${cPath}/js/ckfinder/ckfinder.html',
		    filebrowserUploadUrl: '${cPath}/ckfinder/connector?command=QuickUpload&type=Files',
		    youtube_controls : true,
		    youtube_responsive : true,
		    allowedContent : true
		    
		})
	});
})

tempSaveForm.on("submit",function(){
	let action = $(this).attr("action");
	let method = $(this).attr("method");
	
	let form = $(this)[0];
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
				$("[name=port_num]").val(resp.pv.port_num);
				alert("임시저장이 완료되었습니다!");
			}else{
				alert("에러발생");
			}
		},
		error : function(error){
			console.log(error);
		}
	})
	return false;
})


$("#preview").on("click",function(){
	if(!$("#layout").length){
		alert("현재 화면에서는 미리보기를 할 수 없습니다.");
		return;
	}
	successTag.trigger("click");
	modifyTag.trigger("mouseleave");
	
	var pageContent = $("#page #pageView .pageContent");
	
	for(name in CKEDITOR.instances)
	{
	    CKEDITOR.instances[name].destroy(true);
	}
	$("#content").find(".edit").each(function(){ 
		$(this).prop("contenteditable",false);
	});

	pageContent.each(function(i,v) {
		var name = $(this).find("input.inputMenuName").val();	
		var content = $(this).find(".makePage").data("content").html();
		previewForm.append($("<input>").prop({"type":"hidden","name":"previewMenu"}).val(name));
		previewForm.append($("<input>").prop({"type":"hidden","name":"previewContent"}).val(content));
	})
	
	previewForm.submit();
	previewForm.empty();
	
	$("#content").find(".edit").each(function(){ 
		$(this).prop("contenteditable",true);
		
		CKEDITOR.inline($(this).attr("id"),{
			extraPlugins: 'font, sourcedialog, image2, html5video, widget, widgetselection, clipboard, lineutils, youtube, colorbutton, panelbutton',
		    removePlugins: 'image',
		    filebrowserBrowseUrl: '${cPath}/js/ckfinder/ckfinder.html',
		    filebrowserUploadUrl: '${cPath}/ckfinder/connector?command=QuickUpload&type=Files',
		    youtube_controls : true,
		    youtube_responsive : true,
		    allowedContent : true
		    
		})
	});
})

var flag = true;
$("#savePortInfo").on("click",function(){
	flag = false;
})
$("[type=reset]").on("click",function(){
	flag = true;
})
$('#configModal').on('shown.bs.modal', function () {
	<c:if test="${question_map eq 'Y' or pv.question_map eq 'Y'}">
	if(flag){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		       center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		       level: 1 // 지도의 확대 레벨
		   };  
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 등록된 주소를 표시하기.
		geocoder.addressSearch("${pv.port_user_addr}", function(result, status) {
	
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
	</c:if>
})

</script>
