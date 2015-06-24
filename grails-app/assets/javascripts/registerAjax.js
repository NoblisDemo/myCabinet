jQuery( function($)
	{
	initRegistraion();
	} );


function initRegistraion()
	{
	var clearError = "<div id='regError'></div>";
	var clearSuccess = "<div id='regSuccess'></div>";
	$( '#regSucces' ).replaceWith(clearSuccess);
	$( '#regError' ).replaceWith(clearError);
	$('#regFormSubmit').on( 'click', function (e)
		{
		e.preventDefault();
    	e.stopImmediatePropagation();
		var username = $('#username').val(),
			password = $('#password').val(),
			password2 = $('#password2').val()
			link = $('#actionUrl').val();

		var options = {
		  url: link
		, data: {username: username, password: password, password2: password2}
		, type: "POST"
		, dataType: "html"
		, success: function(data, textStatus, XMLHttpRequest)
			{
			if (data == 'success') 
				{
				window.location.reload();
				var message = "<div id='regSuccess'> Registeration was successul!</div>";
				$( '#regSuccess' ).replaceWith(message);
				} 
			else
				{
				var message = data;
				$( '#regForm' ).replaceWith(message);
				}
			}
		, error: function() 
			{
			var failMessage = "<div id='regError'>There was an error when trying to register.</div>";
			$( '#regError' ).replaceWith(failMessage);
			}
		}

		$.ajax(options);
		});
	}