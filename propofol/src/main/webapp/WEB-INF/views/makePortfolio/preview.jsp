<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Propofol - 포트폴리오 제작</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="author" content="colorlib.com">
<!-- Favicons -->
<link href="/img/favicon.png" rel="icon">
<link href="/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- Main Stylesheet File -->
<link href="/css/makePortfolio/mainStyle.css" rel="stylesheet">

<body>
	<div class="main">
       	<input id="tab0" type="radio" name="tabs" checked>
       	<label for="tab0">홈</label>
        	
		<c:forEach var="menu" items="${menu}" varStatus="vs">
        	<input id="tab${vs.count}" type="radio" name="tabs">
        	<label for="tab${vs.count}">${menu}</label>
		</c:forEach>
			<section id="content0">
				홈화면입니다.
	   		</section>
		<c:forEach var="content" items="${content}" varStatus="vs">
			<section id="content${vs.count}">
	        	${content}
	   		</section>
		</c:forEach>
	</div>
</body>
</html>
