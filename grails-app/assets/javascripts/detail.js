
jQuery( function( $ )
	{
	$('.more').on( 'click' , function (e){
		e.preventDefault();
		$('.complete').toggleClass( 'hide' );

		  var text = $('.more').text();
		   $('.more').text( text == "more..." ? "less" : "more...");
	});
	});


$(document).ready(function(){ 
    $("#myTab a").click(function(e){
    	e.preventDefault();
    	$(this).tab('show');
    });
});