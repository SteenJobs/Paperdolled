$(document).ready(function () {

	var currentURL = stripTrailingSlash(window.location.pathname)

	console.log(currentURL)

	var matchingButton = $(".main-nav-group").find(".main-nav")
	$('a[href="'+currentURL+'"]').children().addClass('active')

	
	$(".main-nav-buttons").on("click", function() {
   		$(".main-nav-group").find(".active").removeClass("active");
   		$(this).addClass("active");
	});
	
	$( ".login-panel" ).draggable();

});

function stripTrailingSlash(str) {
    if(str.substr(str.length - 1) === '/') {
        return str.substr(0, str.length - 1);
    }
    return str;
}

