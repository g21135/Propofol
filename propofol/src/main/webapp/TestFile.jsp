<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>

<title>Insert title here</title>
<script>
$(function(){
	
	var pptGo = $('#pptGo');
	
	$(":button").on('click', function(e) {
// 		//캡쳐
// 		html2canvas(e.target.parentElement).then(function(canvas) {
// 			document.body.appendChild(canvas)
// 		});
		
		//이미지테그만들기
		html2canvas(e.target.parentElement).then(function(canvas) {
// 			$('body').append('<img src="' + canvas.toDataURL("image/jpeg") + '"/>');
			var blob = canvas.toDataURL("image/jpeg");
			pptData = $("#pptData").val(blob);
			pptGo.submit();
		});
		
		$("#pptGo").on('submit', function(){
			$.ajax({
				url : "${cPath}/made",
				data : pptData,
				method : "post",
				dataType : "json",
				success : function(resp){
				}
			});
		})
		
// 		//파일저장
// 		html2canvas(e.target.parentElement).then(function(canvas) {
// 			if (navigator.msSaveBlob) {
// 				var blob = canvas.msToBlob();
// 				return navigator.msSaveBlob(blob, '파일명.jpg');
// 			} else {
// 				var el = document.getElementById("target");
// 				el.href = canvas.toDataURL("image/jpeg");
// 				el.download = '파일명.jpg';
// 				el.click();
// 			}
// 		});
	});
})
</script>

</head>
<body>
<form id="pptGo" method="post" enctype="multipart/form-data" >
	<table>
		<tr>
			<td>사진</td>
			<td>이름</td>
		</tr>
		<tr>
			<td><img src="${cPath}/images/솔지1.jpg"></td>
			<td>혁준S2솔지</td>
		</tr>
		<tr>
			<td><img src="${cPath}/images/iu.jpg"></td>
			<td>승태S2아이유</td>
		</tr>
	</table>
	<input type="button" value="히융" />
	<input type="hidden" name="pptData" id="pptData"/>
</form>

</body>
</html>