<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Brush+Script" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Abel" rel="stylesheet">
<link rel="stylesheet" href="${cPath}/css/introduction/slick.css">
<style>

/* 이미지 슬라이드 */
.slider figure {position: relative;}
.slider figcaption {position: absolute; bottom: 0; left: 0; width: 100%; padding: 20px;
    box-sizing: border-box;
    background-color: rgba(0,0,0,0.5);
    color: #fff;
    font-size: 18px;
}
.slider figcaption em {
    display: block; 
    font-weight: bold; font-size: 28px; text-transform: uppercase; font-family: 'Abel', sans-serif;
    opacity: 0;
    transform: translateX(50px);
    transition: all .84s ease;
}
.slider figcaption span {
    display: block;
    overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
    opacity: 0;
    transform: translateX(50px);
    transition: all .84s 0.2s ease;
}
.slider .slick-active figcaption em {opacity: 1; transform: translateX(0)}
.slider .slick-active figcaption span {opacity: 1; transform: translateX(0)}

.slider .slick-dots {display: block; width: 100%; text-align: center;}
.slider .slick-dots li {display: inline-block; width: 15px; height: 15px; margin: 5px;}
.slider .slick-dots li button {
    font-size: 0; 
    line-height: 0; 
    display: block; 
    width: 15px; height: 15px;
    cursor: pointer; 
    background: #5dbfeb; 
    border-radius: 50%;
}
.slider .slick-dots li.slick-active button {background: #2b91c8;}
.slider .slick-prev {
    position: absolute; left: 0; bottom: 0; 
    z-index: 1000;
    width: 30px; height: 30px; 
    display: inline-block;
    font: normal normal normal 14px/1 FontAwesome;
    text-indent: -9999px;
}
.slider .slick-prev::before {
    content: "\f053";
    color: #5dbfeb;
    text-indent: 0;
    position: absolute; left: 9px; top: 8px;
}
.slider .slick-next {
    position: absolute; right: 0; bottom: 0; 
    z-index: 1000;
    width: 30px; height: 30px; 
    display: inline-block;
    font: normal normal normal 14px/1 FontAwesome;
    text-indent: -9999px;
}
.slider .slick-next::before {
    content: "\f054";
    color: #5dbfeb;
    text-indent: 0;
    position: absolute; left: 11px; top: 8px;
}

</style>
	<section id="cont_center">
                    <article class="column col4" style="width: 750px; height:570px;">
						<!-- 이미지 슬라이드 -->
						<div class="slider">
							<div>
                                <figure>
                                    <img src="${cPath}/img/iu.jpg" alt="이미지1">
                                    <figcaption><em>아이유란?</em><span>뭐긴뭐임 존예여신.</span></figcaption>
                                </figure>
				            </div>
							<div>
                                <figure>
                                    <img src="${cPath}/img/iu.jpg" alt="이미지2">
                                    <figcaption><em>Responsive Site</em><span>슬라이드 플러그인을 이용한 반응형 이미지 슬라이드 입니다.</span></figcaption>
                                </figure>
				            </div>
				            <div>
                                <figure>
                                    <img src="${cPath}/img/iu.jpg" alt="이미지3">
                                    <figcaption><em>Responsive Site</em><span>슬라이드 플러그인을 이용한 반응형 이미지 슬라이드 입니다.</span></figcaption>
                                </figure>
				            </div>
						</div>
						<!--//이미지 슬라이드 -->
                    </article>
                </section>

 <script src="${cPath}/js/slick.min.js"></script>
<script type="text/javascript">              
$(".slider").slick({
	dots: true,
	arrows: true
});

</script>