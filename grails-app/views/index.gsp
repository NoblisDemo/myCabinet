<!DOCTYPE html>
<html>
	<head>
		<asset:stylesheet src="frontPage.css"/>
		<meta name="layout" content="main"/>
	</head>
	<body>
		<div class='span12 navbar'>
			<div class='navbar-inner'>
				<div class='pull-left'>
					<div id=""role="banner"><asset:image src="HealthAlerts_Logo.png" alt="My Health Alert" class='logo' /></div>
				</div>
				<div class='pull-right login'>
					<div class='input-group'>
						<g:textField name="userNameLogin" class="userNameLogin form-control" placeholder="Username" />
						<g:textField name="passwordLogin" class="passwordLogin form-control" placeholder="Password" />
						<a href="#"> Create Account </a><g:submitButton name="login" class="btn btn-info login-button" type="button" value="LOGIN"/>
					</div>
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
			<div class='fluid-row'>
				<div class='right-searchpane-md-lg col-md-4 visible-md visible-lg'>
					<div>
						<span class='headerText'> WHO WE ARE </span>
					</div>
					<div>
						<div class='descriptionText' >My Health Alert helps individuals and caregivers stay up to date on all reported recalls and side effects for medications and health devices.</div>
						<a href="#"> Create Account </a>
					</div>
				</div>
				<div class='right-searchpane-sm col-sm-5 visible-sm'>
					<div>
						<span class='headerText'> WHO WE ARE </span>
					</div>
					<div>
						<div class='descriptionText' >My Health Alert helps individuals and caregivers stay up to date on all reported recalls and side effects for medications and health devices.</div>
						<a href="#"> Create Account </a>
					</div>
				</div>
				<div class='right-searchpane-xs col-xs-12 visible-xs'>
					<div>
						<span class='headerText'> WHO WE ARE </span>
					</div>
					<div>
						<div class='descriptionText' >My Health Alert helps individuals and caregivers stay up to date on all reported recalls and side effects for medications and health devices.</div>
						<a href="#"> Create Account </a>
					</div>
				</div>
			</div>
			<div class='col-md-2 col-sm-1 col-xs-0'></div>
		</div>

	</body>
</html>
