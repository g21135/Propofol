<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>


.flip-container{
	width: 100vm;
 	position: absolute; 
 	top: 45%; 
 	left: 30%; 
 	transform : translate(-20%,-30%); 
	text-align: center;
	
}
.flip-card{
	width:  400px;
	height: 550px;
	text-align: center;
	perspective : 1000px;
	display:  inline-block;
	margin: 10px;
}

.flip-card-front img{
	width : 400px;
	height: 550px;
}

.flip-card-back img{
	width: 350px;
	height: 200px;
	border-radius: 20px; 
}


.flip-card-inner{

	position: relative;
	width: inherit;
	height: 100%;
	text-align: center;
	transition : 0.5s ease-in-out;
	transform-style : preserve-3d;
}

.flip-card:hover .flip-card-inner{
	transform : rotateY(180deg);
}

.flip-card-front{
	z-index: 2;
}
.flip-card-back{
	z-index: 1;
	background-color: #fff;
	transform : rotateY(180deg);
}

.flip-card-front , .flip-card-back{
	position: absolute;
	width: 100%;
	height: 100%;
	backface-visibility : hidden;
}

.flip-card-bakc p{
	text-align: left;
	padding: 0 30px;
	box-sizing: border-box;
}

.flip-card-back p a {
	display: block;
	width: 100px;
	margin: 20px auto;
	background-color: #000;
	color: #fff;
	text-align: center;
	padding: 5px;
	border-radius: 20px;
	text-transform: uppercase;
	text-decoration: none;
	transition : 0.3s;
}

.flip-card-back p a:hover {
	background-color: dodgerblue; 
}
</style>
<div class="flip-container">
	<div class="flip-card">
		<div class="flip-card-inner">
			<div class="flip-card-front">
				<img src="${cPath}/img/pay/premium1.jpg">
			</div>
			<div class="flip-card-back">
				<img src="${cPath}/img/pay/premium1-1.jpg">
				<h4>아이유에요</h4>
				<p>아이유입니당당당
				<a href="${cPath}/addPayment">구매하기</a>
				</p>
			</div>
		</div>
	</div>
	
	<div class="flip-card">
		<div class="flip-card-inner">
			<div class="flip-card-front">
				<img src="${cPath}/img/pay/premium3.jpg">
			</div>
			<div class="flip-card-back">
			<img src="${cPath}/img/pay/premium3-3.jpg">
				<h4>아이유에요</h4>
				<p>아이유입니당당당
				<a href="${cPath}/addPayment">구매하기</a>
				</p>
			</div>
		</div>
	</div>
	
	<div class="flip-card">
		<div class="flip-card-inner">
			<div class="flip-card-front">
				<img src="${cPath}/img/pay/premium6.jpg">
			</div>
			<div class="flip-card-back">
			<img src="${cPath}/img/pay/premium6-6.jpg">
				<h4>아이유에요</h4>
				<p>아이유입니당당당
				<a href="${cPath}/addPayment">구매하기</a>
				</p>
			</div>
		</div>
	</div>
</div>