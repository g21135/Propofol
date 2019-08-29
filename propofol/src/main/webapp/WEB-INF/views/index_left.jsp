<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"  prefix="tiles"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<title><tiles:getAsString name="title"/></title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	<meta content="" name="keywords">
	<meta content="" name="description">
	<meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="author" content="colorlib.com">
	
	<!-- Favicons -->
	<link href="${cPath}/img/favicon.png" rel="icon">
	<link href="${cPath}/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">
	
	<!-- Bootstrap CSS File -->
	<link href="${cPath}/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Libraries CSS Files -->
	<link href="${cPath}/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link href="${cPath}/lib/animate/animate.min.css" rel="stylesheet">
	<link href="${cPath}/lib/ionicons/css/ionicons.min.css" rel="stylesheet">
	<link href="${cPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	
	<!-- portfolio CSS File -->
	<link href="${cPath }/css/portfolio/default.css"  rel="stylesheet">
	
	<!-- 	introductions stylesheet file -->
	<link rel="stylesheet" href="${cPath}/css/introduction/contents.css">
	<link rel="stylesheet" href="${cPath}/css/introduction/Map.css">
	
	
	<!-- Main Stylesheet File -->
	<link href="${cPath}/css/style_left.css" rel="stylesheet">
	<link href="${cPath}/css/noticeBoard/noticeBoard.css" rel="stylesheet">
	<link href="${cPath}/css/faq/faq.css" rel="stylesheet">
	
	<!-- loginForm  -->
	<link href="${cPath}/css/loginForm.css" rel="stylesheet">
	
	<!-- mypage purewhite -->
	<link rel="stylesheet" href="${cPath}/css/member/mypage.css">
	<link rel="stylesheet" href="${cPath}/css/member/memberManageMent.css">
	<link rel="stylesheet" href="${cPath}/css/findUserInfo/userInfo.css">

    <!-- JavaScript Libraries -->
	<script src="${cPath}/lib/jquery/jquery.min.js"></script>
	<script src="${cPath}/lib/jquery/jquery-migrate.min.js"></script>
	<script src="${cPath}/lib/popper/popper.min.js"></script>
	<script src="${cPath}/lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="${cPath}/lib/easing/easing.min.js"></script>
	<script src="${cPath}/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="${cPath}/lib/scrollreveal/scrollreveal.min.js"></script>
	<script src="${cPath}/lib/bootstrap/js/bootstrap-filestyle.min.js"> </script>
	<script src='https://www.google.com/recaptcha/api.js?onload=onload&render=explicit'></script>
	
	<!-- fontawesome -->
	<script src="https://kit.fontawesome.com/4409c92568.js"></script>
	
<script>
<c:if test="${not empty msg}">
	alert("${msg}");
	<c:remove var="msg" scope="session"/>
</c:if>
<c:if test="${not empty message}">
	alert("${message}");
	<c:remove var="message" scope="session"/>
</c:if>
</script>
</head>
<body>
<div id="layout">
	<div id="topMenu">
	  	<tiles:insertAttribute name="topMenu"/>
	</div> 
	
	<div id="leftMenu">
	  	<tiles:insertAttribute name="leftMenu"/>
	</div> 
	
	<div id="content">
	  	<tiles:insertAttribute name="content"/>
	</div>
	<div id="footMenu">
		<tiles:insertAttribute name="footer"/>
	</div>
</div>


<script src="${cPath}/js/main.js"></script>
</body>
</html>
