<!DOCTYPE html>
<html>
	<head>
		<asset:stylesheet src="frontPage.css"/>
		<meta name="layout" content="main"/>
		<asset:javascript src="registerAjax.js"/>
	</head>
	<body>
		<div class='span12 navbar'>
			<div class='navbar-inner'>
				<div class='pull-left'>
					<div id=""role="banner"><asset:image src="HealthAlerts_Logo.png" alt="My Health Alert" class='logo' /></div>
				</div>
				<div class='pull-right login'>
					<sec:ifLoggedIn>
						Logged In as <sec:username /><br />
						<g:link controller="logout">Logout</g:link>
					</sec:ifLoggedIn>
					<sec:ifNotLoggedIn>
						<div class='input-group'>
							<g:form controller='j_spring_security_check' name="loginForm" autocomplete='off'>
								<g:textField name="j_username" class="userNameLogin form-control" placeholder="Username" />
								<g:passwordField name="j_password" class="passwordLogin form-control" placeholder="Password" />
								<a href="#" data-toggle="modal" data-target="#createAccountModal"> Create Account </a><input form="loginForm" name="login" class="btn btn-info login-button" type="submit" value="LOGIN"/>
							</g:form>
						</div>
					</sec:ifNotLoggedIn>
				</div>
			</div>
		</div>

		<div class='row searchBar'>
			<div class='col-md-2 col-sm-1 col-xs-0'></div>
			<div class='col-md-5 col-sm-6 col-xs-12'>
				<span class='headerText'> PRODUCT SEARCH </span>
				<div class='input-group'>
					<g:render template="searchBox" class="form-control searchInput" placeholder="Drug Name/Device Search"/>
					<span class="input-group-btn">
						<g:submitButton name="submit" class="btn btn-default" type="button" value="Search" onclick="submitSearch()"/>
					</span>
				</div>
				<div class='descriptionText' >* Search works for Medicine and Device names only. Choose from the auto fill dropdown options for guaranteed results.</div>
			</div>
			<div class='right-searchpane col-md-4 col-sm-5 col-xs-12'>
				<div>
					<span class='headerText'> WHO WE ARE </span>
				</div>
				<div>
					<div class='descriptionText' >My Health Alert helps individuals and caregivers stay up to date on all reported recalls and side effects for medications and health devices.</div>
					<a href="#" data-toggle="modal" data-target="#createAccountModal"> Create Account </a>
				</div>
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
								<a href="#" id='regFormSubmit' class="btn btn-info pull-right"> Create Account </a>
							</g:form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			<div class='col-md-2 col-sm-1 col-xs-0'></div>
		</div>

	</body>
</html>
