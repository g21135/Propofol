<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
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

<!-- Bootstrap CSS File -->
<link href="${cPath}/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${cPath}/bootstrap-3.3.7/css/bootstrap-theme.min.css"/>
<!-- Libraries CSS Files -->
<link href="${cPath}/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${cPath}/lib/animate/animate.min.css" rel="stylesheet">
<link href="${cPath}/lib/ionicons/css/ionicons.min.css" rel="stylesheet">
<link href="${cPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

<!-- Main Stylesheet File -->
<link href="${cPath}/css/managementPortfolio/style.css" rel="stylesheet">

<!-- fontawesome -->
<script src="https://kit.fontawesome.com/4409c92568.js"></script>

<!-- management CSS File -->
<link href="${cPath}/css/managementPortfolio/portBoard.css" rel="stylesheet">

<!-- JavaScript Libraries -->
<script src="${cPath}/lib/jquery/jquery.min.js"></script>
<script src="${cPath}/lib/jquery/jquery-migrate.min.js"></script>
<script src="${cPath}/lib/popper/popper.min.js"></script>
<script src="${cPath}/lib/bootstrap/js/bootstrap.min.js"></script>
<script src="${cPath}/lib/easing/easing.min.js"></script>
<script src="${cPath}/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="${cPath}/lib/scrollreveal/scrollreveal.min.js"></script>

<!-- fontawesome -->
<script src="https://kit.fontawesome.com/4409c92568.js"></script>
</head>
<body>
	<div id="topMenu">
  	<tiles:insertAttribute name="topMenu"/>
	</div> 
	<div id="content">
  	<tiles:insertAttribute name="content"/>
	</div>
	<div id="footMenu">
	</div>
	<!-- Template Main Javascript File -->
	<script src="${cPath}/js/main.js"></script>
</body>
</html>