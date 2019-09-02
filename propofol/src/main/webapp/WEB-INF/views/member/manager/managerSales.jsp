<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="<c:url value='/js/chartjs/Chart.js' />"></script>
<script>
$(function() {
	var chartData1 = [];
	var chartData2 = [];
	
	var x = Math.floor(Math.random() * 256);
    var y = Math.floor(Math.random() * 256);
    var z = Math.floor(Math.random() * 256);
    var ctx = document.getElementById('Chart').getContext('2d');

    var data = {
		labels: chartData1,
        datasets: [{
            label: "매출액",
            data: chartData2, 
            fill: false, 
            borderColor: "rgba(" + x + "," + y + "," + z + "," + 1 +")",
            backgroundColor : "rgba(" + x + "," + y + "," + z + "," + 0.3 +")",
        }]
	};
    
    var MyChart = new Chart('Chart', {
    	type: 'line',
        data: data,
        options : {maintainAspectRatio: true},
	        scales : {
	            yAxes : [ {
	                ticks : {
	                    beginAtZero : true
	                }
	            } ]
	        }
    });

    //실행 시 바로 작동하는 ajax
	$.ajax({
		url: "${cPath}/manager/sales",
	    method: "POST",
        dataType : 'json',
        success : function(result) {
        	for (var i in result) {
        		chartData1.push(result[i].order_date);
        		chartData2.push(result[i].order_cost);
	        }
        	MyChart.update();
        },
        error : function(error){
			console.log(error);
		}
    });
	
// 	년도 조회 폼
	var yearForm = $("#yearForm");
	$("#yearBtn").on("click", function() {
		yearForm.submit();
	});
// 	월별 조회 폼
	var dateForm = $("#dateForm");
	$("#selectMonth").change(function() {
		dateForm.submit();
	});
// 	타입 조회 폼
	var typeForm = $("#typeForm");
	$("#typeBtn").on("click", function() {
		typeForm.submit();
	});
	
	//ajax 코드 실행
	var commonHandler = function(){
		event.preventDefault();
		let form = $(this)[0];
		let formData = new FormData(form);
		let action = $(this).attr('action');
		let method = $(this).attr('method');
		$.ajax({
			url : action,
			data : formData,
			dataType : "json",
			method : method,
			contentType: false,
			processData: false,
			success : function(result) {
				chartData1.length = 0;
				chartData2.length = 0;
		        for (var i in result) {
	        		chartData1.push(result[i].order_date);
	        		chartData2.push(result[i].order_cost);
		        }
	        	data.labels = chartData1;
	        	data.datasets[0].data = chartData2;
	        	MyChart.update();
	        },
			error : function(error){
				console.log(error);
			}
		})//ajax end
		return false;
	};
	
	//전체
	yearForm.on("submit", commonHandler); 
	//월별
	dateForm.on("submit", commonHandler); 
	//타입별
	typeForm.on("submit", commonHandler); 
});
</script>

<div style="display:inline-flex; width: 100%;">
	<div style="margin-right: 70px;">
		<!-- 전체 조회 조회 폼 -->
		<form id="yearForm" method="post" action="${cPath}/manager/sales">
			<button id="yearBtn" type="button" class="btn btn-dark" style="height: 40px;">전체 조회</button>
		</form>
	</div>
	<div style="margin-right: 70px;">
		<!-- 타입별 조회 조회 폼 -->
		<form id="typeForm" method="post" action="${cPath}/manager/sales">
			<input type="hidden" name="order_type" value="type"/>
			<button id="typeBtn" type="button" class="btn btn-dark" style="height: 40px;">타입별 조회</button>
		</form>
	</div>
	<div style="width: 15%;">
		<!-- 월별 조회 폼 -->
		<form id="dateForm" method="post" action="${cPath}/manager/sales">
			<div class="notice_write_div">
				<label for="type_num" class="no_icon" style="position: absolute;border-radius: 3px 0 0 3px;height: 40px;line-height: 38px;width: 40px;background: #eee;text-align: center;color: #888;">
					<i class="fa fa-check" aria-hidden="true"></i>
				</label>
				<select id="selectMonth" name="order_date" class="notice_frm_input full_input required" style="padding-left:50px">
					<c:forEach var="month" begin="1" end="12">
						<option value="2019-${month}">2019년${month}월</option>
					</c:forEach>
				</select>
			</div>
		</form>
	</div>
</div>
<!-- canvas -->
<div style="max-width: 1000px;max-height: 600px;">
	<canvas id="Chart" width="1000" height="600"></canvas>
</div>