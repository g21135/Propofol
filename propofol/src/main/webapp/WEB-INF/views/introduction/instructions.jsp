<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#directions{
	border: 2px solid;
	width: 250px;
}
#mainDir{
	border-bottom: 2px solid;
	height: 40px;
	font-size: 22px;
}
#subDir{
	
}

#menu{
	width: 500px;
}
#menu ul li {
	float: left;
	width:  25%;
	height: 100%;
	line-height: 50px;
	text-align: center;
	margin-right: 20px;
}
#menu ul li:hover{
	color: #a9a9a9;
	cursor: pointer;
}
#result{
	margin-top: 30px;
}



</style>
<!-- 전체 div -->
<div style="margin-top: 50px;">
<!-- 	위 사용법 div -->
	<div>
	<!-- 사용법 -->
		<div id="directions" style="text-align: center; display: inline-block;">
		<!--메인 사용법 이름 -->
		<div id="mainDir" >
		사 용 법
		</div>
		<!--서브 사용법 이름 -->
		<div id="subDir" style="color: white; background-color: black; ">
		서브사용법
		</div>
		</div>
	<!-- 메뉴 -->
		<div id="menu" style="display: inline-block; margin-left: 70px;">
		<ul>
			<li id="Home">Home</li>
			<li id="Explanation">Explanation</li>
			<li id="Inquiry">Inquiry</li>
		</ul>
		</div>
	</div>
<!-- 	동영상 div -->
	<div id="result">
	</div>
	
    </div>
<script type="text/javascript">

var Home = $("#Home");
var Explanation = $("#Explanation");
var Inquiry = $("#Inquiry");



$.ajax({
	url : "instructions",
	dataType : "text",
	success : function() {
		$("#result").html("<iframe width='750' height='570' src='https://www.youtube.com/embed/5SNVJ9f8C1I' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-pictur' allowfullscreenstyle></iframe>");
	},error : function(error) {
		alert("통신실패");
	}
})

Home.on("click" , function() {
$.ajax({
	url : "instructions",
	dataType : "text",
	success : function() {
		$("#result").html("<iframe width='750' height='570' src='https://www.youtube.com/embed/5SNVJ9f8C1I' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-pictur' allowfullscreenstyle></iframe>");
	},error : function(error) {
		alert("통신실패");
	}
})
})

Explanation.on("click" , function() {
$.ajax({
	url : "slider",
	dataType : "text",
	success : function(resp) {
		$("#result").html(resp);
	},error : function(error) {
		alert("통신실패");
	}
})
})

Inquiry

//    동영상 반응형 처리
//   $(window).resize(function(){resizeYoutube();});
//   $(function(){resizeYoutube();});
//   function resizeYoutube(){ $("iframe").each(function(){ if( /^https?:\/\/www.youtube.com\/embed\//g.test($(this).attr("src")) ){ $(this).css("width","100%"); $(this).css("width","100%"); }


</script>


