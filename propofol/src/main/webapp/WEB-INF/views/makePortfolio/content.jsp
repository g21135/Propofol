<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="content">
<img src="${cPath}/img/makePortfolio/contents/basicContent2.jpg" style="position: relative;bottom:-464px;">
</div>

<script>
var successTag = $("<a>").css({
    "position": "absolute",
	"text-align":"center",
	"text-decoration": "none",
    "border-radius": "50px",
    "z-index":"999"
}).prop("class","successTag btn btn-info").text("완료");

var modifyTag = $("<a>").css({
    "position": "absolute",
	"text-align":"center",
	"text-decoration": "none",
    "border-radius": "50px",
    "z-index":"999"
}).prop("class","modifyTag btn btn-success").text("변경");

var checkFlag = false;
$(document).on('mouseenter', '.editContainer', function(event) {
	if(checkFlag){
		return false;
	}
	var editContainer = $(this);
	
	editContainer.css({
		"border":"solid 2px lightgreen",
		"z-index":"999"
	});
	
	modifyTag.css({
		"position":"initial",
	    "margin-left": "-21px",
	    "margin-top": "-38px"
	});
	editContainer.prepend(modifyTag);	
	
}).on('mouseleave', '.editContainer', function(event) {
	if(checkFlag){
		return false;
	}
	var editContainer = $(this);
	modifyTag.detach();
	editContainer.css({
		"border":"",
		"cursor":"",
		"z-index":""
	});
});

$(document).on("click",".modifyTag",function(e){
	modifyTag.hide();
	var deleteTag = $("<a>").css({
	    "position": "absolute",
		"text-align":"center",
		"text-decoration": "none",
	    "border-radius": "50px",
	    "z-index":"999"
	}).prop("class","deleteTag btn btn-info").text("삭제");
	
	checkFlag = true;
	var editContainer = $(this).parent();
	if($('.successTag').length){
		$('.successTag').trigger("click");
	}
	
	editContainer.css({
		"border":"solid 2px skyblue",
		"cursor":"pointer",
		"z-index":"999"
	});
	
	editContainer.find(".edit").css({"pointer-events":"none"});
	
	successTag.css({
		"top": editContainer.offset().top-15,
		"left": editContainer.offset().left
	});
	
	successTag.on("click",function(){
		successTag.detach();
		deleteTag.detach();	
		$("#"+editContainer.attr("id")).resizable({disabled: true });
		$("#"+editContainer.attr("id")).draggable({disabled: true });
		editContainer.css({
			"border":"",
			"cursor":"",
			"z-index":""
		});
		checkFlag = false;
		modifyTag.show();	
		editContainer.find(".edit").css({"pointer-events":""});
	})
	
	deleteTag.css({
		"top": editContainer.offset().top-15,
		"left": editContainer.offset().left+54
	});
	
	deleteTag.on("click",function(){
		var check = confirm("박스를 정말로 삭제하시겠습니까?");
		if(!check){
			return;
		}	
		successTag.trigger("click");
		editContainer.remove();
	})
	
	pageView.on("click",".makePage",function(){
		successTag.detach();
		deleteTag.detach();	
		$("#"+editContainer.attr("id")).resizable({disabled: true });
		$("#"+editContainer.attr("id")).draggable({disabled: true });
		editContainer.css({
			"border":"",
			"cursor":"",
			"z-index":""
		});
		checkFlag = false;
		modifyTag.show();
		modifyTag.trigger("mouseleave");
	});
	
	$("#"+editContainer.attr("id")).resizable({
		disabled: false, 
  		containment: "#content",
  		handles: 'n, e, s, w, ne, se, sw, nw',
  		resize: function(e,ui) {
			successTag.css({
				"top": editContainer.offset().top-15,
				"left": editContainer.offset().left
			});
			deleteTag.css({
				"top": editContainer.offset().top-15,
				"left": editContainer.offset().left+54
			});
  	   	}
    });
	
	$("#"+editContainer.attr("id")).draggable({
		disabled: false, 
		containment: "#content",
		drag:function(){
			successTag.css({
				"top": editContainer.offset().top-15,
				"left": editContainer.offset().left
			});
			deleteTag.css({
				"top": editContainer.offset().top-15,
				"left": editContainer.offset().left+54
			});
		}
    });
	
	editContainer.after(successTag,deleteTag);	 
})
</script>