<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="${cPath}/css/makePortfolio/page.css" rel="stylesheet">

<div id="pageView">
</div>
<div id="addPage">
	<img src="${cPath}/img/makePortfolio/basicPage/addPage.jpg">
</div>
<div class="bubble">
	<span class="pageCopy">페이지 복사<i class="fas fa-copy"></i></span>
	<span class="pageDelete">페이지 삭제<i class="fas fa-trash-alt"></i></span>
</div>
<c:url var="uploadImageUrl" value="/makePortfolio/uploadImage">
	<c:param name="type" value="Images" />
</c:url>

<c:if test="${not empty pv.tempList}">
	<c:forEach var="item" items="${pv.tempList}" varStatus="vs">
	<div id="page${vs.count}">
		${item.temp_page}
	</div>
	<script>
	var contentData = $("<div>").prop({"class":"mainContent"})
	.css({"width":"100%","height":"100%","background":"white"})
	.append($("#page${vs.count}").html());	
	
	$("#pageView").append(
			$("<div>").prop({"class":"pageContent"}).append(
			$("<div>").prop({"class":"input-name"}).append(
				$("<input>").prop({"class":"inputMenuName","type":"text","name":"menuName${vs.count}",
					"value":"${item.temp_menu}"}),
				$("<span>").prop({"class":"underline-animation"})		
			),
			$("<i>").prop({"class":"menuEdit fas fa-cog"}),
			$("<img>").prop({"class":"makePage","src":"${item.page_img}"})
			.data({"content":contentData})
		)
	);
	$("#page${vs.count}").remove();
	</script>
	</c:forEach>
</c:if>
<script>
$(".bubble").css("display","none");

var addPage = $("#addPage");
var pageView = $("#pageView");
var isVisible = false;
var clickedAway = false;
CKEDITOR.disableAutoInline = true;

<c:if test="${not empty pageList}">
<c:forEach var="item" items="${pageList}" varStatus="vs">
	<c:if test="${not empty item.jsp_name}">
		$.ajax({
			url : "${cPath}/makePortfolio/${item.jsp_name}",
			method: "get",
			dataType: "html",
			success: function(resp) {
				var contentData = $("<div>").prop({"class":"mainContent"})
				.css({"width":"100%","height":"100%","background":"white"})
				.append(resp);	
				pageView.append(
						$("<div>").prop({"class":"pageContent"}).append(
						$("<div>").prop({"class":"input-name"}).append(
							$("<input>").prop({"class":"inputMenuName","type":"text","name":"menuName${vs.count}",
								"value":"${item.basic_page_name}"}),
							$("<span>").prop({"class":"underline-animation"})		
						),
						$("<i>").prop({"class":"menuEdit fas fa-cog"}),
						$("<img>").prop({"class":"makePage","src":"${cPath}/img/makePortfolio/basicPage/${item.basic_page_thumbnail}"})
						.data({"content":contentData})
					)
				);
			}
		})
	</c:if>
	<c:if test="${empty item.jsp_name}">
		pageView.append(
				$("<div>").prop({"class":"pageContent"}).append(
				$("<div>").prop({"class":"input-name"}).append(
					$("<input>").prop({"class":"inputMenuName","type":"text","name":"menuName${vs.count}",
						"value":"${item.basic_page_name}"}),
					$("<span>").prop({"class":"underline-animation"})		
				),
				$("<i>").prop({"class":"menuEdit fas fa-cog"}),
				$("<img>").prop({"class":"makePage","src":"${cPath}/img/makePortfolio/basicPage/${item.basic_page_thumbnail}"})
				.data({"content":
					$("<div>").prop({"class":"mainContent"})
					.css({"width":"100%","height":"100%","background":"white"})
					.append(
							$("<img>").prop({"class":"basicContent",
								"src":"${cPath}/img/makePortfolio/contents/basicContent.jpg"})
					)
				})
			)
		);
	</c:if>
</c:forEach>
</c:if>

addPage.on("click",function(){
	if($(".pageContent").length >= 8){
		alert("더 이상 추가할 수 없습니다.");
		return;
	}
    var page = $("<div>").prop({"class":"pageContent"}).append(
   		$("<div>").prop({"class":"input-name"}).append(
   				$("<input>").prop({"class":"inputMenuName","type":"text","name":"menuName"}).val("기본"),
   				$("<span>").prop({"class":"underline-animation"})
   		),
		$("<i>").prop({"class":"menuEdit fas fa-cog"}),
		$("<img>").prop({
			"class":"makePage",
			"src":"${cPath}/img/makePortfolio/basicPage/page0_thumbnail.jpg"
		}).data({"content":
				$("<div>").prop({"class":"mainContent"})
				.css({"width":"100%","height":"100%","background":"white"})
				.append(
					$("<img>")
					.prop({
						"class":"basicContent",
						"src":"${cPath}/img/makePortfolio/contents/basicContent.jpg"})
				)
			})
	)
	
	pageView.append(page);
    
    $('.menuEdit').popover({
    	html: true,
    	placement : "bottom",
        content: function () {
            return $('.bubble').html();
        },
        trigger: 'manual'
    });
})

pageView.sortable({
	placeholder : "itemHighlight",
	sort : function(e, div) {
		$(document).trigger("click");
	}
});

$(document).on("click",".menuEdit",function(e){
	$('.menuEdit').popover({
		html: true,
		placement : "bottom",
	    content: function () {
	        return $('.bubble').html();
	    },
	    trigger: 'manual'
	});
	
	$(this).popover('show');
    clickedAway = false;
    isVisible = true;
})

$(document).click(function (e) {
    if (isVisible & clickedAway) {
        $('.menuEdit').popover('hide');
        isVisible = clickedAway = false;
    } else {
        clickedAway = true;
    }
});

pageView.on("click",".pageCopy",function(e){
	if($(".pageContent").length >= 8){
		alert("더 이상 추가할 수 없습니다.");
		return;
	}
	$(document).trigger("click");
	var src = $(this).parents("div.pageContent").find(".makePage").attr("src");		
	var val = $(this).parents("div.pageContent").find(".inputMenuName").val();		
	var data = $(this).parents("div.pageContent").find(".makePage").data("content");
	
	var page = $("<div>").prop({"class":"pageContent"}).append(
		   		   $("<div>").prop({"class":"input-name"}).append(
		   				$("<input>").prop({"class":"inputMenuName","type":"text","name":"menuName"}).val(val),
		   				$("<span>").prop({"class":"underline-animation"})
		   		   ),
				   $("<i>").prop({"class":"menuEdit fas fa-cog"}),
				   $("<img>").prop({
					   "class":"makePage",
					   "src": src
				   }).data({"content":data.clone()})
			   );
	$(this).parents("div.pageContent").after(page);		

	$('.menuEdit').popover({
		html: true,
		placement : "bottom",
	    content: function () {
	        return $('.bubble').html();
	    },
	    trigger: 'manual'
	});
})

pageView.on("click",".pageDelete",function(e){
	if($(this).parents("div.pageContent").find(".makePage").css("border").indexOf("none") == -1){//내 이미지 테두리가 있다면
		var img = $("<img>").prop({"src":"${cPath}/img/makePortfolio/contents/basicContent2.jpg"})
		.css({"position":"relative","bottom":"-464px"});
		$("#content").html(img);
	}
	$(document).trigger("click");
	$(this).parents("div.pageContent").remove();
})

pageView.on("click",".makePage",function(){
	var makePage= $(this);
	$(".makePage").data("clicked",false);
	$(this).data("clicked",true);
	for(name in CKEDITOR.instances)
	{
	    CKEDITOR.instances[name].destroy(true);
	}
	loadingStart();
	$(".makePage").css("border","");
	
	var content = $("#content");
	$(this).css("border","solid 2px #1a1a1a");
	
	content.html($(this).data("content"));
	
	content.find(".edit").each(function(){ 
		$(this).prop("contenteditable",true);
		
		CKEDITOR.inline($(this).attr("id"),{
			extraPlugins: 'font, sourcedialog, image2, html5video, widget, widgetselection, clipboard, lineutils, youtube, colorbutton, panelbutton',
		    removePlugins: 'image',
		    filebrowserBrowseUrl: '${cPath}/js/ckfinder/ckfinder.html',
		    filebrowserUploadUrl: '${cPath}/ckfinder/connector?command=QuickUpload&type=Files',
		    youtube_controls : true,
		    youtube_responsive : true,
		    allowedContent : true
		    
		})
	});
	
	html2canvas(document.getElementById("content")).then(function(canvas) {
		var clob = canvas.toDataURL("image/jpeg");
		makePage.data("clob",clob);
		makePage.attr("src",clob);
	});
	
});
</script>