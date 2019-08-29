<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="grid"></div>

<script>
function successPfList(resp){
	class CustomTextEditor {
	      constructor(props) {
	         const el = document.createElement('input');
	         const { maxLength } = props.columnInfo.editor.options;
	         el.type = 'text';
	         el.maxLength = maxLength;
	         el.value = String(props.value);

	         this.el = el;
	      }

	      getElement() {
	         return this.el;
	      }

	      getValue() {
	         return this.el.value;
	      }

	      mounted() {
	         this.el.select();
	      }
	   }
	
	const grid = new tui.Grid({
	      el: document.getElementById('grid'),
	      scrollX: false,
	      scrollY: false,
	      minBodyHeight: 30,
			rowHeaders: ['rowNum'],
			pageOptions: {
				perPage: 5
			},
	      columns: [
	         {
	            header: '번호',
	            name: 'num',
	            onBeforeChange(ev){
	               console.log('Before change:' + ev);
	               ev.stop();
	            },
	            onAfterChange(ev){
	               console.log('After change:' + ev);
	            },
	            editor: 'text'
	         },
	         {
	            header: '포트폴리오명',
	            name: 'name',
	            onBeforeChange(ev){
	               console.log('Before change:' + ev);
	            },
	            onAfterChange(ev){
	               console.log('After change:' + ev);
	            },
	            editor: 'text'
	         },
	         {
	            header: '회원아이디',
	            name: 'memId',
	            onBeforeChange(ev){
	               console.log('Before change:' + ev);
	            },
	            onAfterChange(ev){
	               console.log('After change:' + ev);
	            },
	            editor: 'text'
	         },
	         {
	            header: '테마명',
	            name: 'themeName',
	            onBeforeChange(ev){
	               console.log('Before change:' + ev);
	            },
	            onAfterChange(ev){
	               console.log('After change:' + ev);
	            },
	            editor: 'text'
	         },
	         {
	            header: '제작일',
	            name: 'portDate',
	            onBeforeChange(ev){
	               console.log('Before change:' + ev);
	            },
	            onAfterChange(ev){
	               console.log('After change:' + ev);
	            },
	            editor: 'text'
	         }
	      ]
	  });
	
	const gridData = [];
	
	$(resp.dataList).each(function(idx, port){
	var data =	{
			num : port.port_num,
			name : port.port_name,
			memId : port.mem_id,
			themeName : port.themeList[0].theme_name,
			portDate : port.port_date
		}
	gridData.push(data);
	})
	grid.resetData(gridData);
}

	$(function(){
		var queryString = $(this).serialize();
		 $.ajax({
	        	url:"${cPath}/adminMenagement/allMemberPortList",
	        	method : "get",
		        data : queryString,
		        dataType : "json",
		        success : function(resp){
		        	successPfList(resp);
				},
				error : function(){
					console.log(errorResp.status + ", " + errorResp.responseText);
				}
			});
	})
</script>