<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${cPath}/css/community/recruit.css" rel="stylesheet">

<div id="recruitDiv">
	<form>
	<table class="type09">
    <thead>
    <tr>
        <th colspan="2" scope="cols">채용공고</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th scope="row">증시종류</th>
        <td><input class="magic-radio" type="radio" name="Stocktype" id="kospi" value="kospi"><label for="kospi"> 코스피 </label> &nbsp;&nbsp;
			<input class="magic-radio" type="radio" name="Stocktype" id="kosdaq" value="kosdaq"><label for="kosdaq"> 코스닥 </label>&nbsp;&nbsp;
			<input class="magic-radio" type="radio" name="Stocktype" id="nasdaq" value="nasdaq"><label for="nasdaq"> 나스닥 </label>
		</td>
    </tr>
    <tr>
        <th scope="row">지역</th>
        <td>
        <select id="firstArea" name="choices-single-defaul" placeholder = "대분류">
				<option value="" disabled selected hidden>도&nbsp;/&nbsp;시</option>
				<option value="">전체</option>
				<c:forEach var="firstAreaMap" items="${firstAreaList }">
					<option value="${firstAreaMap['far_code'] }">${firstAreaMap.far_name }</option>
				</c:forEach>
		</select>
		<select id="secondArea" name="choices-single-defaul">
				<option value="" disabled selected hidden>시&nbsp;/&nbsp;군&nbsp;/&nbsp;구 </option>
				<option value="">전체</option>
				<c:forEach var="secondAreaMap" items="${secondAreaList }">
					<option value="${secondAreaMap['sar_code'] }"
						class="${secondAreaMap.far_code }">${secondAreaMap.sar_name }</option>
				</c:forEach>
				
				
		</select>
		</td>
    </tr>
    <tr>
        <th scope="row">직업</th>
        <td>
        <select id="occupation" name="choices-single-defaul">
				<option value="" disabled selected hidden>대분류</option>
				<option value=''>전체</option>
				<c:forEach var="occupationMap" items="${occupationList }">
					<option value="${occupationMap['oc_code'] }">${occupationMap.oc_name }</option>
				</c:forEach>
			</select> 
			
			<select id="industry" name="choices-single-defaul">
				<option value="" disabled selected hidden>소분류</option>
				<option value="">전체</option>
				<c:forEach var="industryMap" items="${industryList }">
					<option value="${industryMap['in_code'] }"
						class="${industryMap.oc_code }">${industryMap.in_name }</option>
				</c:forEach>
		</select>
		</td>
    </tr>
    
     <tr>
        <th scope="row">학력</th>
        <td>
       <select id="academic" name="choices-single-defaul">
				<option value=''>전체</option>
				<c:forEach var="academicMap" items="${academicList }">
					<option value="${academicMap['ac_code'] }">${academicMap.ac_name }</option>
				</c:forEach>
		</select> 
		</td>
    </tr>
    
    <tr>
        <th scope="row">고용형태</th>
        <td>
        <select id="servicetype" name="choices-single-defaul">
				<option value=''>전체</option>
				<c:forEach var="servicetypeMap" items="${servicetypeList }">
					<option value="${servicetypeMap['st_code'] }">${servicetypeMap.st_name }</option>
				</c:forEach>
		</select> 
		</td>
    </tr>
    
    <tr>
        <td colspan="2">
        <input style="width: 300px;" id="search" type="text" placeholder="키워드 or 기업명 검색 " />
		<button id="serach" type="button">검색</button>
		</td>
    </tr>
    </tbody>
</table>
		
		<div id="floatMenu">
			<input id="todayrecruitment" class="imgBtn" type="button" style="background: url('${cPath}/img/commuinty/todayrecruitment.jpg')" />
			<input id="inturn" class="imgBtn" type="button" style="background: url('${cPath}/img/commuinty/inturn.jpg')"/>
		</div>
		
	</form>
</div>
<div id="result">
</div>
	<!-- 페이지 -->
	<div id="pagingArea">
		${pagingVO.pagingHTMLForBS}
	</div>


<script type="text/javascript">
	var result= $("#result");
	var firstArea = $("#firstArea");
	var secondArea = $("#secondArea");
	var occupation = $("#occupation");
	var industry = $("#industry");
	var pagingArea = $("#pagingArea");
	//페이징

	
	//검색 키워드
		 keywords = $("#search").val();
		
		//상장여부
		 stock = $("input[name='Stocktype']:checked").val();
		
		//근무지 loc_cd = loc_mcd + loc_bcd
		//1차 근무지
		loc_mcd = $("#firstArea option:selected").val();
		//2c 근무지 
		 loc_bcd = $("#secondArea option:selected").val();
		
		//산업 + 직종 1 + 101
		 fjob_category = $("#occupation option:selected").val();
		
		 sjob_category = $("#industry option:selected").val();
		
		//학력
		 edu_lv = $("#academic option:selected").val();
		
		//고용형태
		 job_type = $("#servicetype option:selected").val();
		
		
		
		$.ajax({
		   url : "RestTemplateEx",
		   type: "get",
		   data:{
			   keywords : keywords,
			   stock : stock,
			   loc_bcd : loc_bcd,
			   sjob_category : sjob_category,
			   edu_lv : edu_lv,
			   job_type : job_type
		   },
 		   dataType: "xml",
		   success : function(resp){
				var img = [];
				let dv = $("<div>").prop({"class" : "table-job-list"});
				let dv2 = $("<div>").prop({"class" : "table-wrap"}).append(
								$("<div>").prop({"class" : "table-header"}).append(
									$("<div>").prop({"class" : "table-row"}).append(
										$("<div>").prop({"class" : "table-cell cell-status"}).text("회사명"),
										$("<div>").prop({"class" : "table-cell cell-position"}).text("채용제목 / 연봉 / 근무지역"),
										$("<div>").prop({"class" : "table-cell cell-status"}).text("학력 / 경력"),
										$("<div>").prop({"class" : "table-cell cell-status"}).text("고용형태"),
										$("<div>").prop({"class" : "table-cell cell-status"}).text("등록일"),
										$("<div>").prop({"class" : "table-cell cell-status"}).text("마감일")
									 )			
								)
						   )
							
				let eachDv = $("<div>").prop({"class" : "table-body"});
										
				$($(resp).find("jobs").find("job")).each(function(idx, job){
					var posttime = $($(resp).find("jobs").find("job")[idx]).find("posting-date").text().substr(0,10);
					var expirtime = $($(resp).find("jobs").find("job")[idx]).find("expiration-date").text().substr(0,10);
					var jobtype = $($(resp).find("jobs").find("job")[idx]).find("position>job-type").text().substr(0,7);
					var yearmoney = $($(resp).find("jobs").find("job")[idx]).find("salary").text();
					eachDv.append(
						$("<div>").prop({"class" : "table-row"}).append(
							$("<div>").prop({"class" : "table-cell cell-section"}).text($($(resp).find("jobs").find("job")[idx]).find("company>name").text()),
							$("<div>").prop({"class" : "table-cell cell-section"}).html("<a href ='"+$($(resp).find("jobs").find("job")[idx]).find("url").text()+"'>"+$($(resp).find("jobs").find("job")[idx]).find("position>title").text()+"<br>"+"<img src='${cPath}/img/commuinty/money.jpg'>&nbsp;"+yearmoney+"&nbsp;&nbsp;"+$($(resp).find("jobs").find("job")[idx]).find("position>location").text()+"</a>"),
							$("<div>").prop({"class" : "table-cell cell-section"}).html($($(resp).find("jobs").find("job")[idx]).find("position>required-education-level").text()+"<br>"+$($(resp).find("jobs").find("job")[idx]).find("position>experience-level").text()),
							$("<div>").prop({"class" : "table-cell cell-section"}).text(jobtype),
							$("<div>").prop({"class" : "table-cell cell-section"}).text(posttime),
							$("<div>").prop({"class" : "table-cell cell-section"}).text(expirtime)
						)
					)
				});
				dv2.append(eachDv)
				dv.append(dv2);
				img.push(dv);
				result.html(img);
		   },
		   errors : function(error){
			   console.log(error);
		   }
	})
	//스크립트로 값만 비교해서 실행 
	
	firstArea.on("change", function() {
		var far_code = $(this).val();
		secondArea.find("option:not(:first)").hide();
		secondArea.find("option." + far_code).show();
	});
	
	occupation.on("change", function() {
		var oc_code = $(this).val();
		industry.find("option:not(:first)").hide();
		industry.find("option." + oc_code).show();
	});
	
	
	$("#inturn").on("click", function() {
		$.ajax({
			   url : "RestTemplateInturn",
			   type: "get",
	 		   dataType: "xml",
			   success : function(resp){
					var img = [];
					let dv = $("<div>").prop({"class" : "table-job-list"});
					let dv2 = $("<div>").prop({"class" : "table-wrap"}).append(
									$("<div>").prop({"class" : "table-header"}).append(
										$("<div>").prop({"class" : "table-row"}).append(
											$("<div>").prop({"class" : "table-cell cell-status"}).text("회사명"),
											$("<div>").prop({"class" : "table-cell cell-position"}).text("채용제목 / 연봉 / 근무지역"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("학력 / 경력"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("고용형태"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("등록일"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("마감일")
										 )			
									)
							   )
								
					let eachDv = $("<div>").prop({"class" : "table-body"});
											
					$($(resp).find("jobs").find("job")).each(function(idx, job){
						var posttime = $($(resp).find("jobs").find("job")[idx]).find("posting-date").text().substr(0,10);
						var expirtime = $($(resp).find("jobs").find("job")[idx]).find("expiration-date").text().substr(0,10);
						var jobtype = $($(resp).find("jobs").find("job")[idx]).find("position>job-type").text().substr(0,7);
						var yearmoney = $($(resp).find("jobs").find("job")[idx]).find("salary").text();
						eachDv.append(
							$("<div>").prop({"class" : "table-row"}).append(
								$("<div>").prop({"class" : "table-cell cell-section"}).text($($(resp).find("jobs").find("job")[idx]).find("company>name").text()),
								$("<div>").prop({"class" : "table-cell cell-section"}).html("<a href ='"+$($(resp).find("jobs").find("job")[idx]).find("url").text()+"'>"+$($(resp).find("jobs").find("job")[idx]).find("position>title").text()+"<br>"+"<img src='${cPath}/img/commuinty/money.jpg'>&nbsp;"+yearmoney+"&nbsp;&nbsp;"+$($(resp).find("jobs").find("job")[idx]).find("position>location").text()+"</a>"),
								$("<div>").prop({"class" : "table-cell cell-section"}).html($($(resp).find("jobs").find("job")[idx]).find("position>required-education-level").text()+"<br>"+$($(resp).find("jobs").find("job")[idx]).find("position>experience-level").text()),
								$("<div>").prop({"class" : "table-cell cell-section"}).text(jobtype),
								$("<div>").prop({"class" : "table-cell cell-section"}).text(posttime),
								$("<div>").prop({"class" : "table-cell cell-section"}).text(expirtime)
							)
						)
					});
					dv2.append(eachDv)
					dv.append(dv2);
					img.push(dv);
					result.html(img);
			   },
			   errors : function(error){
				   console.log(error);
			   }
		})
	})
	
	$("#todayrecruitment").on("click", function() {
		$.ajax({
			   url : "RestTemplatetoday",
			   type: "get",
	 		   dataType: "xml",
			   success : function(resp){
					var img = [];
					let dv = $("<div>").prop({"class" : "table-job-list"});
					let dv2 = $("<div>").prop({"class" : "table-wrap"}).append(
									$("<div>").prop({"class" : "table-header"}).append(
										$("<div>").prop({"class" : "table-row"}).append(
											$("<div>").prop({"class" : "table-cell cell-status"}).text("회사명"),
											$("<div>").prop({"class" : "table-cell cell-position"}).text("채용제목 / 연봉 / 근무지역"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("학력 / 경력"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("고용형태"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("등록일"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("마감일")
										 )			
									)
							   )
								
					let eachDv = $("<div>").prop({"class" : "table-body"});
											
					$($(resp).find("jobs").find("job")).each(function(idx, job){
						var posttime = $($(resp).find("jobs").find("job")[idx]).find("posting-date").text().substr(0,10);
						var expirtime = $($(resp).find("jobs").find("job")[idx]).find("expiration-date").text().substr(0,10);
						var jobtype = $($(resp).find("jobs").find("job")[idx]).find("position>job-type").text().substr(0,7);
						var yearmoney = $($(resp).find("jobs").find("job")[idx]).find("salary").text();
						eachDv.append(
							$("<div>").prop({"class" : "table-row"}).append(
								$("<div>").prop({"class" : "table-cell cell-section"}).text($($(resp).find("jobs").find("job")[idx]).find("company>name").text()),
								$("<div>").prop({"class" : "table-cell cell-section"}).html("<a href ='"+$($(resp).find("jobs").find("job")[idx]).find("url").text()+"'>"+$($(resp).find("jobs").find("job")[idx]).find("position>title").text()+"<br>"+"<img src='${cPath}/img/commuinty/money.jpg'>&nbsp;"+yearmoney+"&nbsp;&nbsp;"+$($(resp).find("jobs").find("job")[idx]).find("position>location").text()+"</a>"),
								$("<div>").prop({"class" : "table-cell cell-section"}).html($($(resp).find("jobs").find("job")[idx]).find("position>required-education-level").text()+"<br>"+$($(resp).find("jobs").find("job")[idx]).find("position>experience-level").text()),
								$("<div>").prop({"class" : "table-cell cell-section"}).text(jobtype),
								$("<div>").prop({"class" : "table-cell cell-section"}).text(posttime),
								$("<div>").prop({"class" : "table-cell cell-section"}).text(expirtime)
							)
						)
					});
					dv2.append(eachDv)
					dv.append(dv2);
					img.push(dv);
					result.html(img);
			   },
			   errors : function(error){
				   console.log(error);
			   }
		})
	})
	
	
	
	$("#serach").on('click', function() {
		
		
		//검색 키워드
		var keywords = $("#search").val();
		
		//상장여부
		var stock = $("input[name='Stocktype']:checked").val();
		
		//근무지 loc_cd = loc_mcd + loc_bcd
		//1차 근무지
		var loc_mcd = $("#firstArea option:selected").val();
		//2c 근무지 
		var loc_bcd = $("#secondArea option:selected").val();
		
		//산업 + 직종 1 + 101
		var fjob_category = $("#occupation option:selected").val();
		
		var sjob_category = $("#industry option:selected").val();
		
		//학력
		var edu_lv = $("#academic option:selected").val();
		
		//고용형태
		var job_type = $("#servicetype option:selected").val();
		
		
		
		$.ajax({
			 url : "RestTemplateEx",
			   type: "get",
			   data:{
				   keywords : keywords,
				   stock : stock,
				   loc_bcd : loc_bcd,
				   sjob_category : sjob_category,
				   edu_lv : edu_lv,
				   job_type : job_type
			   },
	 		   dataType: "xml",
			   success : function(resp){
					var img = [];
					let dv = $("<div>").prop({"class" : "table-job-list"});
					let dv2 = $("<div>").prop({"class" : "table-wrap"}).append(
									$("<div>").prop({"class" : "table-header"}).append(
										$("<div>").prop({"class" : "table-row"}).append(
											$("<div>").prop({"class" : "table-cell cell-status"}).text("회사명"),
											$("<div>").prop({"class" : "table-cell cell-position"}).text("채용제목 / 연봉 / 근무지역"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("학력 / 경력"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("고용형태"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("등록일"),
											$("<div>").prop({"class" : "table-cell cell-status"}).text("마감일")
										 )			
									)
							   )
								
					let eachDv = $("<div>").prop({"class" : "table-body"});
											
					$($(resp).find("jobs").find("job")).each(function(idx, job){
						var posttime = $($(resp).find("jobs").find("job")[idx]).find("posting-date").text().substr(0,10);
						var expirtime = $($(resp).find("jobs").find("job")[idx]).find("expiration-date").text().substr(0,10);
						var jobtype = $($(resp).find("jobs").find("job")[idx]).find("position>job-type").text().substr(0,7);
						var yearmoney = $($(resp).find("jobs").find("job")[idx]).find("salary").text();
						eachDv.append(
							$("<div>").prop({"class" : "table-row"}).append(
								$("<div>").prop({"class" : "table-cell cell-section"}).text($($(resp).find("jobs").find("job")[idx]).find("company>name").text()),
								$("<div>").prop({"class" : "table-cell cell-section"}).html("<a href ='"+$($(resp).find("jobs").find("job")[idx]).find("url").text()+"'>"+$($(resp).find("jobs").find("job")[idx]).find("position>title").text()+"<br>"+"<img src='${cPath}/img/commuinty/money.jpg'>&nbsp;"+yearmoney+"&nbsp;&nbsp;"+$($(resp).find("jobs").find("job")[idx]).find("position>location").text()+"</a>"),
								$("<div>").prop({"class" : "table-cell cell-section"}).html($($(resp).find("jobs").find("job")[idx]).find("position>required-education-level").text()+"<br>"+$($(resp).find("jobs").find("job")[idx]).find("position>experience-level").text()),
								$("<div>").prop({"class" : "table-cell cell-section"}).text(jobtype),
								$("<div>").prop({"class" : "table-cell cell-section"}).text(posttime),
								$("<div>").prop({"class" : "table-cell cell-section"}).text(expirtime)
							)
						)
					});
					dv2.append(eachDv)
					dv.append(dv2);
					img.push(dv);
					result.html(img);
			   },
			   errors : function(error){
				   console.log(error);
			   }
		})
		
	})
	
	// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
	var floatPosition = parseInt($("#floatMenu").css('top'));
	// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";

		/* 애니메이션 없이 바로 따라감
		 $("#floatMenu").css('top', newPosition);
		 */

		$("#floatMenu").stop().animate({
			"top" : newPosition
		}, 500);

	}).scroll();
	
	
</script>