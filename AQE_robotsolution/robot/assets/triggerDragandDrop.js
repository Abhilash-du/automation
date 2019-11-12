var selector = "[data-tests-id=RA_VSP_PXTC_sk091n_164226]";
var positionX = 510;
var positionY = 220;
var dragEvent = new CustomEvent('dragstart', { bubbles: true, cancelable: true });
dragEvent.dataTransfer =  {
            data: {},
            setData: function(type,val) {
                this.data[type] = val;
                this.types[0] = type;
            },
            getData: function(type) {
                return this.data && this.data[type] || '{}'
            },
            setDragImage: function(image, x,y) {},
            dropEffect: 'copy',
            effectAllowed:'copyMove',
            types: [],
            items: {},
            files:[]
};
$(selector).get(0).dispatchEvent(dragEvent);
$(document).get(0).dispatchEvent(new MouseEvent('dragover', { clientX: positionX + 270, clientY: positionY + 125 }));
$(selector).get(0).dispatchEvent(new MouseEvent('drag', { clientX: positionX + 270, clientY: positionY + 125 }));

 var dropEvent = new CustomEvent('drop', { bubbles: true, cancelable: true });
dropEvent.initCustomEvent('drop', true, true, null);
dropEvent.dataTransfer = {
   data: {},
   setData: function (type, val){ this.data[type] = val; this.types[0] = type; },
   getData: function (type) {
   return this.data && this.data[type] || '{}';
},
dropEffect: 'copy',
effectAllowed: 'copyMove',
types: [],
items: {},
files: []
};
dropEvent.pageX = positionX + 290;
dropEvent.pageY = positionY - 9940;
setTimeout(function (){ 
   $('#draggable_element').get(0).dispatchEvent(dropEvent); 
 }, 2000);
