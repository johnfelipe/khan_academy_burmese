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
});