<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="shortcut icon" href="${assetPath(src: 'HealthAlerts_Favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
		<asset:javascript src="application.js"/>
		<title>Welcome to My Health Alert</title>
		<asset:stylesheet src="custom.css"/>
		<g:javascript src="select2.js" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}" type="text/css">
		<jqui:resources />
    	<g:layoutHead/>
	</head>
	<body>
		<div class='navbar-fixed-top' >
			<div class = 'row headerline' >
				<div class='pull-right login'>
					<sec:ifLoggedIn>
						Logged In as <sec:username /><br />
						<g:link controller="logout">Logout</g:link>
					</sec:ifLoggedIn>
					<sec:ifNotLoggedIn>
							<g:form controller='j_spring_security_check' name="loginForm" autocomplete='off'>
								<g:textField name="j_username" class="userNameLogin " placeholder="Username" />
								<g:passwordField name="j_password" class="passwordLogin " placeholder="Password" />
								<input form="loginForm" name="login" class="btn login-button" type="submit" value="LOGIN"/><a href="#" data-toggle="modal" data-target="#createAccountModal" class='createAccount-link'> Create Account </a>
							</g:form>
					</sec:ifNotLoggedIn>
				</div>
			</div>
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

		<div class="modal fade" id="createAccountModal" >
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div id="loginFormContainer" >
						<div class="modal-header">
							<span>
								Create Account
							</span>
						</div>
						<div class="modal-body">
							<div id='regError'></div>
							<div id='regSuccess'></div>
							<g:form action='register' name='registerForm' controller='register' >
								<g:if test='${emailSent}'>
									<br/>
									<g:message code='spring.security.ui.register.sent'/>
								</g:if>
								<g:else>
									<br/>
									<g:render template="/register/register" model="${[command: command]}" />
								</g:else>
								<a href="#" id='regFormSubmit' class="btn createAccount-button pull-right"> Create Account </a>
							</g:form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
