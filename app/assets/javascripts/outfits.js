// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
var lastClicked;

// Ajax pagination
$(function () {
	$('#page_links').on("click", 'a', function (e) {
		$.get(this.href, null, loadJS, 'script');
		return false;
  });
});

$(function () {
	$('#outfits_button').on("click", function () {
		var items = $('#outfit_canvas .draggable2')
		var canvas = $('#outfit_canvas')
		var array = []
			items.each(function () { 
			var x_coordinate = ($(this).offset().left - canvas.offset().left) / $('#outfit_canvas').width();
			var y_coordinate = ($(this).offset().top - canvas.offset().top) / $('#outfit_canvas').height();
			var height = $(this).height() / $('#outfit_canvas').height();
			var width = $(this).width() / $('#outfit_canvas').width();
			var item_id = $(this).data().itemId;
			var outfit_id = $(this).data().outfitId;
		  var object = {styled_id: userId, item_id: item_id, x_coordinate: x_coordinate, y_coordinate: y_coordinate, height: height, width: width};
			array.push(object)
		});
		$.post(
			"/users/"+userId+"/closets",
			{object: array},
			function(data) {
			  window.location = data.location
			},
			'json'
		);
		return false;
	});
});

function loadJS () {

  var handle = $('.ui-resizable-handle')
  var initialClass = "draggable"
  if (handle.parent().hasClass(initialClass)) {
  	handle.hide();
  }
  
  var items = $('.draggable')
  var items2 = $('.draggable2')
  
  items.width(150)
  items.height(150)
  items2.width(150)
  items2.height(150)
  
  
  // Drop on curser location
  
  var newClass = 'draggable2 ui-draggable ui-draggable-handle ui-resizable ui-draggable-dragging'
  // For each .draggable element
  $('.draggable').each(function() {
    // Set up the variables
    var $this = $(this),
        w = $this.find('img').width(), // Width of the image inside .draggable
        h = $this.find('img').height(); // Height of the image inside .draggable
    $this.width(w).height(h); // Set width and height of .draggable to match image
  });
  
  // For each .draggable2 element
  $('.draggable2').each(function() {
    // Set up the variables
    var $this = $(this),
        w = $this.find('img').width(), // Width of the image inside .draggable2
        h = $this.find('img').height(); // Height of the image inside .draggable2
    $this.width(w).height(h); // Set width and height of .draggable2 to match image
  });
  
  $( "#outfit_canvas" ).droppable({
    accept: ".draggable, .draggable2",
  	tolerance: "fit",
  	hoverClass: "drop-hover",
    drop: addDrag,
  	out: removeItem
   });	 
  				 
  $( ".draggable" ).draggable({
    revert: "invalid",
  	helper: "clone"
  	//stop: help
  });
  
  
  // Enable dialog box
  var myDialog = $("#dialog")
	
  $( "#dialog" ).dialog({
    autoOpen: false,
  	// focus: closeDialog,
    open: function(e) {
        closedialog = 1;
        $(document).bind('click', overlayclickclose);
    },
    focus: function() {
        closedialog = 0;
    },
    close: function() {
      $(document).unbind('click');
    },
  	position: { my: "center", at: "center", of: ".draggable" }
  });
  
  
  var closedialog;
  
  function overlayclickclose() {
    if (closedialog) {
        myDialog.dialog('close');
     }
    //set to one because click on dialog box sets to zero
    closedialog = 1;
  }
  
  $(".draggable").on("click", function() {
  	var image = $(this).find("img.imageUpload");
  	var info = $(this).find("div.item_info");
  	if (myDialog.find("img.imageUpload") != image || myDialog.find("div.item_info") != info) {
      myDialog.empty("img.imageUpload");  
      myDialog.empty("div.item_info");
  		myDialog.append(image.clone());
  		myDialog.append(info.clone());
  	}
  	else {
  	}	
  	myDialog.dialog("open")
  	closedialog = 0;
  	myDialog.dialog( "option", "position", { my: "right top", at: "center", of: this } );
  });
  
  
  // Handles only around selected	
  
  $(document).on("click", function(e) {
  	
  	var handle = $('.ui-resizable-handle')
  	// lastClicked = $(e.target)		
    $('.draggable2').find('.ui-resizable-handle').hide();
  	if ($(e.target).is('.imageUpload')) {
  		$(e.target).siblings('.ui-resizable-handle').show();
  	} 
  	if ($(e.target).parent().hasClass("draggable")) {
  		handle.hide()
    }
  	// lastClicked.toggleClass('last_clicked')
  	
  });
  
  // Disappear if dragged out of canvas
  
  function removeItem(event, ui) {
	
      $(ui.helper).fadeOut(100, function () {
          $(this).remove();
      });
  }
  
  // Add clone functionality
  
  function addDrag( event, ui ) {
  	var canvas = $('#outfit_canvas')
  	var dropElem = ui.draggable.get(0)
  	var clone = $(dropElem).clone()
  	var cloneClass = $(clone).attr('class')
 
  	if (cloneClass != newClass) {
  		clone.attr('class', 'draggable2');
  		// position of the draggable minus position of the droppable
      // relative to the document
      var $newPosX = ui.offset.left - $(this).offset().left;
      var $newPosY =  ui.offset.top - $(this).offset().top;
  		
      clone.css('left',$newPosX);    
      clone.css('top',$newPosY);
  
  		clone.appendTo("#outfit_canvas");
  		
  		$(clone).draggable({
    		revert: "invalid"
  		})
  			
  		
  		$(clone).resizable({
     	 // minWidth: image.width(),
     	 // minHeight: image.height(),
  			aspectRatio: true,
  			maxHeight: $('.ui-droppable').height(),
  			maxWidth: $('.ui-droppable').width(),
      	handles: {
          	'nw': '#nwgrip',
          	'ne': '#negrip',
          	'sw': '#swgrip',
          	'se': '#segrip',
          	'n': '#ngrip',
          	'e': '#egrip',
          	's': '#sgrip',
          	'w': '#wgrip'
      	}
			/*	
				,
  		    autoHide: true
  		}).off('mouseenter mouseleave').on({
  		    click: function () {
  					$(this).find('.ui-resizable-handle').show();
  		    }
  			});
				*/
			});
  	}
  }
}

$(document).ready(function () {
	
    $(function () {
      var boards = $('.outfit-display-panel')
      boards.each(function() { 
        var canvas = $(this);
        canvas.children('.small_draggable2').each(function () { 
          var obj = $(this);
          var width = obj.data().width;
          var height = obj.data().height;
          var canvasHeight = canvas.height();
          var canvasWidth = canvas.width();
          var newHeight = height * canvasHeight;
          var newWidth = width * canvasWidth;
          obj.height(newHeight);
          obj.width(newWidth);
          var offsetX = obj.data().left;
          var offsetY = obj.data().top;
          var PosX = (offsetX * canvasWidth) + canvas.offset().left;
          var PosY = (offsetY * canvasHeight) + canvas.offset().top;
          obj.offset({ top: PosY, left: PosX });
        });
      });
    });

		loadJS();


});