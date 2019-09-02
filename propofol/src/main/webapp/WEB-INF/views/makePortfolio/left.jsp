<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="${cPath}/css/makePortfolio/left.css" rel="stylesheet">

<h5 class="leftMenuTitle">레이아웃</h5>
<div id="leftLayoutMenu">
<ul class="accordion-menu">
  <li>
    <div class="dropdownlink"><img class="icon" src="${cPath}/img/makePortfolio/leftMenu/layout.png">레이아웃 설정
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <ul class="submenuItems">
      <li><a id="info" class="addLayout" href="#">정보형<i class="plusIcon fas fa-plus"></i></a></li>
      <li><a class="addLayout" href="#">갤러리형<i class="plusIcon fas fa-plus"></i></a></li>
      <li><a class="addLayout" href="#">혼합형<i class="plusIcon fas fa-plus"></i></a></li>
      <li><a class="addLayout" href="#">자유형<i class="plusIcon fas fa-plus"></i></a></li>
    </ul>	
  </li>
</ul>
</div>

<h5 class="leftMenuTitle" style="margin-top: 40px;">구성요소</h5>
<div id="leftLayoutMenu">
<ul class="accordion-menu">
  <li>
    <div class="dropdownlink"><i class="icon far fa-square"></i>박스
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <ul class="submenuItems">
      <li><a id="boxAdd1" href="#">고정형<i class="plusIcon fas fa-plus"></i></a></li>
      <li><a id="boxAdd2" href="#">반응형<i class="plusIcon fas fa-plus"></i></a></li>
    </ul>	
  </li>
</ul>
</div>
<c:url var="uploadImageUrl" value="/makePortfolio/uploadImage">
	<c:param name="type" value="Images" />
</c:url>
<script>
	var Accordion = function(el, multiple) {
		this.el = el || {};
		// more then one submenu open?
		this.multiple = multiple || false;

		var dropdownlink = this.el.find('.dropdownlink');
		dropdownlink.on('click', {
			el : this.el,
			multiple : this.multiple
		}, this.dropdown);
	};

	Accordion.prototype.dropdown = function(e) {
		var $el = e.data.el, $this = $(this),
		//this is the ul.submenuItems
		$next = $this.next();
		$next.slideToggle();
		$this.parent().toggleClass('open');

		if (!e.data.multiple) {
			//show only one menu at the same time
			$el.find('.submenuItems').not($next).slideUp().parent().removeClass('open');
		}
	}

	var accordion = new Accordion($('.accordion-menu'), false);
	
	$(".addLayout").on("click",function(){
		if($("#content").find("#layout").length){
			var check = confirm("이미 레이아웃이 존재 합니다\n 새로운 레이아웃으로 덮어 씌우시겠습니까?");
			if(!check){
				return;
			}	
		}
		for(name in CKEDITOR.instances)
		{
		    CKEDITOR.instances[name].destroy(true);
		}
		loadingStart();
		$.ajax({
			url : "${cPath}/makePortfolio/"+ $(this).attr("id"),
			method: "get",
			dataType: "html",
			success: function(resp) {
				$("#content").find(".mainContent").html(resp);
				
				$(".edit").each(function(){ 
					$(this).prop("contenteditable",true);
					
					CKEDITOR.inline($(this).attr("id"),{
						extraPlugins: 'font ,sourcedialog, image2, html5video, widget, widgetselection, clipboard, lineutils, youtube, colorbutton, panelbutton',
					    removePlugins: 'image',
					    filebrowserBrowseUrl: '${cPath}/js/ckfinder/ckfinder.html',
					    filebrowserUploadUrl: '${cPath}/ckfinder/connector?command=QuickUpload&type=Files',
					    youtube_controls : true,
					    youtube_responsive : true,
					    allowedContent : true
					})
				});
			}
		})
	})
	
	var idNumber = 1;
	function boxAdd(option1, option2){
		if(!$("#layout").length){
			return;
		}
		var innerBox = $("<div>").prop({"class":"edit","id":"box"+idNumber,"contenteditable":"true"})
						.append($("<h1>").text("BOX").css("text-align","center"));
		
		var newBox = $("<div>").prop({"class":"editContainer","id":"edit-content"+idNumber})
		.append(innerBox)
		.css({"width":option1,"height":option2,"left":"780px","top":"360px"});
		
		idNumber = idNumber + 1
		$("#layout").append(newBox);
		
		CKEDITOR.inline(innerBox.attr("id"),{
			extraPlugins: 'font ,sourcedialog, image2, html5video, widget, widgetselection, clipboard, lineutils, youtube, colorbutton, panelbutton',
		    removePlugins: 'image',
		    filebrowserBrowseUrl: '${cPath}/js/ckfinder/ckfinder.html',
		    filebrowserUploadUrl: '${cPath}/ckfinder/connector?command=QuickUpload&type=Files',
		    youtube_controls : true,
		    youtube_responsive : true,
		    allowedContent : true
		})
	}

	$("#boxAdd1").on("click",function(){
		boxAdd("300px","300px");
	})
	
	$("#boxAdd2").on("click",function(){
		boxAdd("auto","auto");
	})
</script> 