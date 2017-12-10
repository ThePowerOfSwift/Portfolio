$(document).ready(function() {

	$('.blog-main').magnificPopup({
        delegate: '.blog-post a',
		type: 'image',
		closeOnContentClick: true,
		mainClass: 'mfp-img-mobile',
		image: {
			verticalFit: true
		}
		
	});

$('#socialNews ul.media-list').magnificPopup({
    delegate: 'li.media a',
   type:'inline',
   midClick: true
});
$('#blog-main').magnificPopup({
    delegate:'a#readMore',
   type:'inline',
   midClick: true
});
    $('#twitterNews ul.media-list').magnificPopup({
    delegate: 'li.media a',
   type:'inline',
   midClick: true
});
        $('#instagramNews ul.media-list').magnificPopup({
    delegate: 'li.media a',
   type:'inline',
   midClick: true
});

});
