<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:getAsString name="title" /></title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="author" content="colorlib.com">

<!-- Favicons -->
<link href="${cPath}/img/favicon.png" rel="icon">
<link href="${cPath}/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- bootstrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- jquery ui-->
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css" />

<!-- Main Stylesheet File -->
<link href="${cPath}/css/makePortfolio/mainStyle.css" rel="stylesheet">

<!-- etc css  -->
<!-- <link rel="stylesheet" type="text/css" href="css/default.css" /> -->
<link rel="stylesheet" type="text/css" href="${cPath}/css/makePortfolio/component.css" />

<!-- jquery -->
<script src="${cPath}/lib/jquery/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<c:url value='/js/ckeditor/ckeditor.js'/>"></script>

<!-- fontawesome -->
<script src="https://kit.fontawesome.com/4409c92568.js"></script>

<!-- slide mneu -->
<script src="${cPath}/js/modernizr.custom.js"></script>
</head>
<body>
<div class="balloon"></div>

	<div id="top">
		<tiles:insertAttribute name="top" />
	</div>
	
	<nav id="cbp-spmenu-s4" class="cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-bottom">
		<div id="page">
			<tiles:insertAttribute name="page" />
		</div>
	</nav>
	<div id="showBottom"><i class="fas fa-copy" style=" font-size: 22px;margin-left: 18px;margin-top: 4px;"></i></div>
	   
	<nav id="cbp-spmenu-s1" class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left">
		<div id="left">
			<tiles:insertAttribute name="left" />
		</div>	
	</nav>
	<div id="showLeftPush"><i class="fas fa-caret-right" style="margin-left: 6px;font-size: 41px; margin-top: 10px;"></i></div>
	<div id="contentMain">
		<tiles:insertAttribute name="content"/>
	</div>
	
	<div id="loadingImg" style="position: absolute; left: 43%; top: 40%;"></div>
	<script src="${cPath}/js/classie.js"></script>
	
<script>
function loadingStart() {
	LoadingWithMask('${cPath}/img/loading.gif');
	setTimeout("closeLoadingWithMask()", 500);
}
 
function LoadingWithMask(gif) {
    var maskHeight = $(document).height();
    var maskWidth  = window.document.body.clientWidth;
    
    var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
    var loadingImg = '';
      
    loadingImg += "<img src='"+ gif +"'/>";
 
    $('body').append(mask)
 
    $('#mask').css({
            'width' : maskWidth,
            'height': maskHeight,
            'opacity' : '0.3'
    });
  
    $('#mask').show();
  
    $('#loadingImg').append(loadingImg);
    $('#loadingImg').show();
}
function closeLoadingWithMask() {
    $('#mask, #loadingImg').hide();
    $('#mask, #loadingImg').empty(); 
}

$(window).bind('beforeunload', function() {
	return '정말로 나가시겠습니까?';
});

menuBottom = document.getElementById( 'cbp-spmenu-s4' );
menuLeft = document.getElementById( 'cbp-spmenu-s1' );

var showBottomFlag = false;
$("#showBottom").on("click",function(event){
	if(!showBottomFlag){
		$("#showBottom").css({"bottom":"230px"});
		showBottomFlag = true;
	}else{
		$("#showBottom").css({"bottom":"0px"});
		showBottomFlag = false;
	}
	classie.toggle( this, 'active' );
	classie.toggle( menuBottom, 'cbp-spmenu-open' );
	disableOther( 'showBottom' );
});	

var showLeftPushFlag = false;
$("#showLeftPush").on("click",function(event){
	if(!showLeftPushFlag){
		$("#showLeftPush").css({"left":"240px"});
		showLeftPushFlag = true;
	}else{
		$("#showLeftPush").css({"left":"0px"});
		showLeftPushFlag = false;
	}
	classie.toggle( this, 'active' );
	classie.toggle( menuLeft, 'cbp-spmenu-open' );
	disableOther( 'showLeftPush' );
});

function disableOther( button ) {
	if( button !== 'menuBottom' ) {
		classie.toggle( showBottom, 'disabled' );
	}
	if( button !== 'showLeftPush' ) {
		classie.toggle( showLeftPush, 'disabled' );
	}
}

</script>	
</body>
</html>
