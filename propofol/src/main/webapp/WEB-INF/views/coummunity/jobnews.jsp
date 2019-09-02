<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="${cPath}/css/community/jobnews.css" rel="stylesheet">
<style>


</style>

<div class="head">
	취업뉴스
</div>
<div class="d1">
	<form>
		<input type="text" placeholder="관심 기업&키워드를 검색해보세요" id="keyword" />
		<button type="button" id="keywordBtn" ></button>
	</form>
</div>

<div id="nav">
	<ul id="selectable">
		<li value="취업">취업</li>
		<li value="기업">기업</li>
	</ul>
</div>

<div id="day">
	<ul id="selectDay">
		<li value = "전체보기">전체보기</li>
		<c:forEach var="dayMap" items="${dayList }">
			<li value="${dayMap['day'] }">${dayMap.day }</li>
		</c:forEach>
	</ul>
</div>

<div id="news"></div>

<div class="pg_wrap" id="pagigArea">
	<span class="pg" id="pg"></span>
</div>

<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
        $("#selectable li").addClass("ui-widget-content");
	    $("#selectable").selectable().on("selectablestop", function() {
	      var kind ;
	      $('#selectable .ui-selected').each(function() {
	    	  kind = $(this).text();
	    	  var keyword = $("#keyword").val();
	       var kindUrl = 'https://newsapi.org/v2/everything?q='+keyword+"+"+kind+'&sortBy=popularity&apiKey=4355acd848a54907b05052b4c9806479'
			$.ajax({
			url : kindUrl,
			method: "get",
			dataType : "json",
			success : function(resp) {
				var img = [];
				$(resp.articles).each(function(idx, news){
					var writeday = news.publishedAt.substr(0,10);
					title = $("<span>").text(news.title);
					description = $("<p>").text(news.description);
					
					let dv1 = $("<div id='Methods2'>").append(
					  $("<dl>").append(
					    $("<dt>").html("<img src="+news.urlToImage+">"),
					    $("<dd>").append(
							$("<h3>").html("<a href ='"+news.url+"'>"+news.title+"</a>"),
							$("<p>").text(news.description),
							$("<p1>").text(news.author),
							$("<p2>").text("작성일 : "+writeday)
				   			 )
				 	   )
					)
				img.push(dv1);
				});//for each end
				news.html(img);
			},
			error : function(error) {
				console.log(error);
			}
		});//ajax end
    });   //.ui-selected end
   });//ui-widget-content end
            
        
        var news = $("#news");
        var url = 'https://newsapi.org/v2/everything?' +
		'q=취업'+"+"+'기업&'+
//  	'from=2019-08-06&'+
//		'to=1999-08-04&'+
		'sortBy=popularity&'+
		'apiKey=4355acd848a54907b05052b4c9806479'
		
        $.ajax({
		url : url,
		dataType : "json",
		success : function(resp) {
			var img = [];
			$(resp.articles).each(function(idx, news){
				var writeday = news.publishedAt.substr(0,10);
				console.log(resp.articles.length);
				title = $("<span>").text(news.title);
				description = $("<p>").text(news.description);
				
				image = $("<img>").attr({
					src:news.urlToImage										
				}).css({width:"100px",heigh:"100px", marginRight:"10px", marginLeft:"10px"});
			

				let dv1 = $("<div id='Methods2'>").append(
				  $("<dl>").append(
				    $("<dt>").html("<img src="+news.urlToImage+">"),
				    $("<dd>").append(
						$("<h3>").html("<a href ='"+news.url+"'>"+news.title+"</a>"),
						$("<p>").text(news.description),
						$("<p1>").text(news.author),
						$("<p2>").text("작성일 : "+writeday)
				    )
				    )
				
				)
			img.push(dv1);
			});
			
			news.html(img);
		},
		error : function() {

		}
	});
    
//     키워드 검색 스크립트
    $("#keywordBtn").on("click" , function() {
    	var keyword = $("#keyword").val();
    	var keywordUrl = 'https://newsapi.org/v2/everything?q='+keyword+'&sortBy=popularity&apiKey=4355acd848a54907b05052b4c9806479'
		
		$.ajax({
		url : keywordUrl,
		method: "get",
		dataType : "json",
		success : function(resp) {
			var img = [];
			$(resp.articles).each(function(idx, news){
				var writeday = news.publishedAt.substr(0,10);
				
				title = $("<span>").text(news.title);
				description = $("<p>").text(news.description);
				
				image = $("<img>").attr({
					src:news.urlToImage										
				}).css({width:"100px",heigh:"100px", marginRight:"10px", marginLeft:"10px"});
				
				let dv1 = $("<div id='Methods2'>").append(
				  $("<dl>").append(
				    $("<dt>").html("<img src="+news.urlToImage+">"),
				    $("<dd>").append(
						$("<h3>").html("<a href ='"+news.url+"'>"+news.title+"</a>"),
						$("<p>").text(news.description),
						$("<p1>").text(news.author),
						$("<p2>").text("작성일 : "+writeday)
				    )
				    )
				
				)
			img.push(dv1);
			});
			
			news.html(img);
		},
		error : function() {

		}
	})
    });   
    
//     날짜별검색
    $("#selectDay").on("click" ,"li", function() {
    	var day = $(this).text();
    	kind ="";
    	var keyword = $("#keyword").val();
    	if($('#keyword').val().replace(/\s/g,"").length == 0){
    		keyword ="취업"
    	}
    	
    	$("#selectable").selectable().on("selectablestop", function() {
  	      $('#selectable .ui-selected').each(function() {
  	    	  kind = $(this).text();
  	      })
    	})
     	var keywordUrl = 'https://newsapi.org/v2/everything?q='+keyword+"+"+kind+'&from='+day+'&to='+day+'&sortBy=popularity&apiKey=4355acd848a54907b05052b4c9806479'
		
		$.ajax({
		url : keywordUrl,
		method: "get",
		dataType : "json",
		success : function(resp) {
			
			var img = [];
			$(resp.articles).each(function(idx, news){
				var writeday = news.publishedAt.substr(0,10);
				
				title = $("<span>").text(news.title);
				description = $("<p>").text(news.description);
				
				image = $("<img>").attr({
					src:news.urlToImage										
				}).css({width:"100px",heigh:"100px", marginRight:"10px", marginLeft:"10px"});
				
				let dv1 = $("<div id='Methods2'>").append(
				  $("<dl>").append(
				    $("<dt>").html("<img src="+news.urlToImage+">"),
				    $("<dd>").append(
						$("<h3>").html("<a href ='"+news.url+"'>"+news.title+"</a>"),
						$("<p>").text(news.description),
						$("<p1>").text(news.author),
						$("<p2>").text("작성일 : "+writeday)
						
				   	 	)
			    	)
				
				)
			img.push(dv1);
			});
			
			news.html(img);
		},
		error : function() {

		}
	});//ajax end
    });//li function end   
    
    function paging(totalRecord, currentPage){
    	
	    var screenSize = 5; //한 화면에 보여질 숫자
		var blockSize = 3;//한 화면에 보여줄 페이지 블록 수
	
		var totalRecord = totalRecord; //전체 게시글 수
		var totalPage; //전체 페이지 수
	
		var currentPage = currentPage;  // 현재 선택학 페이지
	
		var startRow; //스크린에서 첫 번쨰 레코드
		var endRow; //스크린에서 마지막 레코드
	
		var startPage; // 페이지 블럭에서 첫 번째 페이지
		var endPage; // 페이지 블럭에서 마지막 페이지
	    
		totalPage = Math.ceil(totalRecord  / screenSize);
		console.log("총 페이지 수 "+totalPage);
		
		endRow = screenSize * currentPage;
		console.log("스크린에서 마지막 레코드" + endRow);
		
		startRow = endRow - (screenSize - 1);
		console.log("스크린에서 첫 번째 레코드 " + startRow);
		
		endPage = Math.ceil(((currentPage + (blockSize - 1)) / blockSize) * blockSize);
		console.log("마지막 페이지" + endPage);
		
		startPage = endPage - (blockSize - 1);
		console.log("첫 번째 페이지 " + startPage);
		
		var spanTag = $('#pg');
		var aTags = $('<a href="#">');
		
		if(startPage > 1){
			startPage = startPage - 1;
			spanTag.append(aTags.prop('class', 'pg_page').text('≪'));
			console.log("첫 번째 if문");
		}else{
			console.log("else if문");
		}
		
		if(endPage > totalPage){
			endPage = totalPage;
			console.log("두 번째 if문");
		}
		
		for(i = startPage; i <= endPage; i++){
			console.log("for문");
			if(currentPage == i){
			console.log("for 안 if문");
				spanTag.append($('<strong class="pg_current">').text(i));
			}else{
			console.log("for문 안else if문");
				spanTag.append(aTags.prop('class', 'pg_page').text(i));
			}
		}
		
		if(endPage < totalPage){
			console.log("세 번째 if문");
			aTags.on('click', function(){
				endPage = endPage + 1;
				aTags.prop('class', 'pg_page').text('≫');
			});
		}else{
			console.log("세 번째 if문");
			return false;
		}
    }//function end
	paging(17, 1);
  </script>
  
