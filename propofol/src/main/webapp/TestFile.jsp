<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>

<div id="grid"></div>
<script>
   const gridData = [ {
      id : '10012',
      city : 'Seoul',
      country : 'South Korea'
   }, {
      id : '10013',
      city : 'Tokyo',
      country : 'Japan'
   }, {
      id : '10014',
      city : 'London',
      country : 'England'
   }, {
      id : '10015',
      city : 'Ljubljana',
      country : 'Slovenia'
   }, {
      id : '10016',
      city : 'Reykjavik',
      country : 'Iceland'
   } ];
   
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
      columns: [
         {
            header: 'Name',
            name: 'id',
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
            header: 'CITY',
            name: 'city',
            onBeforeChange(ev){
               console.log('Before change:' + ev);
            },
            onAfterChange(ev){
               console.log('After change:' + ev);
            },
            editor: {
               type: CustomTextEditor,
               options: {
                  maxLength: 10
               }
            }
         },
         {
            header: 'COUNTRY',
            name: 'country',
            onBeforeChange(ev){
               console.log('Before change:' + ev);
            },
            onAfterChange(ev){
               console.log('After change:' + ev);
            },
            formatter: 'listItemText',
            editor: {
               type: 'select',
               options: {
                  listItems: [
                     { text: 'Deluxe', value: '1' },
                     { text: 'EP', value: '2' },
                     { text: 'Single', value: '3' }
                  ]
               }
            }
         }
      ]
  });
  grid.resetData(gridData);
</script>