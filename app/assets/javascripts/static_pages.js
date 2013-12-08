$(document).ready(function() {
	var navbar = $('.video-nav');

	$(window).on('scroll', function() {
		var fromTop = $(window).scrollTop();
		var navbarClass = navbar.hasClass('fixed-video-nav');

		if (fromTop > 170 && !navbarClass) {
			navbar.toggleClass('fixed-video-nav');
			navbar.toggleClass('video-nav');
		} else if (fromTop <= 170 && navbarClass) {
			navbar.toggleClass('fixed-video-nav');
			navbar.toggleClass('video-nav');
		};
	});
    $("#import_videos").click(show_import);
    $("#upload_csv").click(warn_length);
});

function show_import() {
    //Show new pop-up allowing users to input a csv file
    $("#import_videos_form").css("position", "fixed");
    $("#import_videos_form").toggle();    
    return false;
}

function warn_length() {
    alert("This operation may take a while, especially if importing lots of videos.");
    return true;
}

