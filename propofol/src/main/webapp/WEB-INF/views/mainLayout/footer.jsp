<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${cPath}/css/chat.css" rel="stylesheet">
<script>
	$(function() {
		var chatbotBtn = $("#chatbotBtn");
		var submitBtn = $("#submitBtn");
		var chatbotForm = $("#chatbotForm");
		
		chatbotBtn.on("click", function() {
			 $("#chatModal").toggle(500);
			 
		});
		
		chatbotForm.on("submit",function(){
			var input = $("input[name='inputText']").val();
			memImg = ($("#memImg").val() ? "${cPath}/img/profile/" + $("#memImg").val() : "${cPath}/img/신세카이1.jpg");
			$(".contentDiv").append($("<div class='MY'>").append($("<img>").prop({"class":"MyImg", "src":memImg}),$("<div>").prop({"class":"Mydiv"}).text(input)))
			var action = $(this).attr("action");
			var method = $(this).attr("method");
			var queryString = $(this).serialize();
			$.ajax({
			url:action,
				data : queryString,
				method : method,
				dataType : "json",
				success : function(resp) {
					var http = null;
					$("input[name='inputText']").val("");
					$(resp.response).each(function(idx, port){
						if (port.includes('http')) {
							http = $("<a>").prop({"href":port}).text(port);
						}else{
							http = port
						}
						$(".contentDiv").append($("<div class='CHAT'>").append(
																									$("<img>").prop({"class":"ChatImg", "src":"${cPath}/img/마동석le.png"}),
																									$("<div>").prop({"class":"Chatdiv"})
																													.append(http)))
					});
				},
				error : function(errorResp) {
					console.log(errorResp.status + ", " + errorResp.responseText);
				}
			});
			return false;
   		});
	});
</script>

<img src="${cPath}/img/마동석.png" id="chatbotBtn">

<div class="backDiv">
	<input type="hidden" id="memImg" value="${sessionScope.authMember.mem_image}">
	<div id="chatModal" class="mainDiv">
		<div class="nextMainDiv">
			<div class="topDiv">
				<h4>ProChat</h4>
			</div>
			<div class="contentDiv">
				<div class='CHAT'>
					<img src="${cPath}/img/마동석le.png" class="ChatImg">
					<div class="Chatdiv">마! 마동석봇입니다!!!!</div>
				</div>
			</div>
			<div class="bottomDiv">
				<form action="${cPath}/chatbot" id="chatbotForm" method="post">
					<div class="textDiv">
						<input type="text" id="inputText" name="inputText" placeholder="챗봇에게 물어보세요!">
						<button type="submit" id="submitBtn" class="btn btn-light">전송</button>
					</div>
				</form>
			</div>
			<div class="chat">
			</div>
		</div>
	</div>
</div>
