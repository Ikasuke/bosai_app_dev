$(document).on('turbolinks:load', function () {
    $('html').css('overflow', 'auto')
   
    $('.nav_profile').simpleSidebar({
		opener: '#profile_button',
		wrapper: '#mainContent',
		animation: {	
		},
		sidebar: {
            align: 'left',
            width: 600

		}
	});


});