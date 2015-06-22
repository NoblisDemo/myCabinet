<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
		<asset:javascript src="application.js"/>
		<title>Welcome to myCabinet</title>
		<asset:stylesheet src="custom.css"/>
		<g:javascript src="select2.js" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}" type="text/css">
		<jqui:resources />
	</head>
	<body>


		<div class='span12 navbar navbar-default'>
			<div class='navbar-inner'>
				<div class='pull-left'>
					Place Holder for Header
					<div id="" class='' role="banner"><asset:image src="" alt="myCabinet"/></a></div>
				</div>
				<div class='pull-right'>
					Place Holder for Log In fields
				</div>
			</div>
		</div>
	
		<g:layoutBody/>
		<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
	</body>
</html>
