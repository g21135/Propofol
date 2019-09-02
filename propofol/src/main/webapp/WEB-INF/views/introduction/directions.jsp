<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e47331fab056de7af5b414c10baee266&libraries=services"></script>

<div id="ctWrap">

	<div id="container">


<article id="ctt" class="ctt_map">
<div id="mapIntro" style="width:80%;height:350px;"></div>

<div style="padding-top: 15px;">
<h3 class="h3_title">Propofol 오시는 길</h3>

<div class="cont_text_info">
	<h2>Propofol</h2>
	<ul>
		<li>Address : 대전광역시 대흥동 500 2층 203호</li>
		<li>Tel : 070-7558-6420 / Fax : 050-4156-1305</li>
		<li>E-mail : cs@@propofol.co.kr</li>
	</ul>
</div>
</div>
</article>
</div>
    </div>
<script>
	var mapContainer = document.getElementById('mapIntro'), // 지도의 중심좌표
	mapOption = {
		center : new kakao.maps.LatLng(36.324848,127.419948), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	//지도에 마커를 표시합니다 
	var marker = new kakao.maps.Marker({
		map : map,
		position : new kakao.maps.LatLng(36.324848,127.419948)
	});

	//커스텀 오버레이에 표시할 컨텐츠 입니다
	//커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
	//별도의 이벤트 메소드를 제공하지 않습니다 
	var content = '<div class="wrap">'
			+ '    <div class="info">'
			+ '        <div class="title">'
			+ '            호텔델루나'
			+ '            <div class="close" onclick="closeOverlay()" title="닫기"></div>'
			+ '        </div>'
			+ '        <div class="body">'
			+ '            <div class="img">'
			+ '                <img src="${cPath}/img/introduction/company.jpg" width="73" height="70">'
			+ '           </div>'
			+ '            <div class="desc">'
			+ '                <div class="ellipsis">대전광역시 대흥동 500 2층 203호</div>'
			+ '                <div class="jibun ellipsis">(우) 34940 (지번) 영평동 2181</div>'
			+ '                <div><a href="https://map.kakao.com/link/map/대덕인재개발원,36.324848,127.419948" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/대덕인재개발원,36.324848,127.419948" style="color:blue" target="_blank">길찾기</a></div>'
			+ '            </div>' + '        </div>' + '    </div>' + '</div>';

	//마커 위에 커스텀오버레이를 표시합니다
	//마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
	var overlay = new kakao.maps.CustomOverlay({
		content : content,
		map : map,
		position : marker.getPosition()
	});

	//마커를 클릭했을 때 커스텀 오버레이를 표시합니다
	kakao.maps.event.addListener(marker, 'click', function() {
		overlay.setMap(map);
	});

	//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
	function closeOverlay() {
		overlay.setMap(null);
	}
</script>