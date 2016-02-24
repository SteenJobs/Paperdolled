// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready(function () { 
  // Enable dialog box
  var myDialog = $("#dialog2")

  
  $( "#dialog2" ).dialog({
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
  	position: { my: "center", at: "center", of: ".draggable3" }
  });
  
  
  var closedialog;
  
  function overlayclickclose() {
    if (closedialog) {
        myDialog.dialog('close');
     }
    //set to one because click on dialog box sets to zero
    closedialog = 1;
  }
  
  $(".draggable3").on("click", function() {
		
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
	
});  