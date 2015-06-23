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
		<asset:javascript src="bootstrap.min.js"/>
		<title>Welcome to My Health Alert</title>
		<asset:stylesheet src="custom.css"/>
		<g:javascript src="select2.js" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}" type="text/css">
		<jqui:resources />
    	<g:layoutHead/>
	</head>
	<body>
	<div class='navbar-fixed-top' >
		<div class = 'row headerline' > </div>
	</div>
	<div class='spacer'></div>
	<g:layoutBody/>
	<div class='navbar-fixed-bottom'>
		<div class='row footerlightblue'> </div>
		<div class='row footerline'>
			<p> DISCLAIMER: Information provided here is from the openFDA beta research project and should not be used for clinical use.</p>
		</div>
        <div class="footer descriptionText" role="contentinfo">
            Build Information: Build Number <g:meta name="build.number"/>, Gid Id <g:meta name="git.id"/>
        </div>
	</div>
	</body>
</html>
