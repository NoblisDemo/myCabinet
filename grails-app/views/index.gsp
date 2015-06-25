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
				    <sec:ifLoggedIn>
				        <div class="col-xs-12 col-md-8"> <g:link resource="dashboard"><asset:image src="HealthAlerts_Logo.png" alt="My Health Alert Logo" class='logo' /> </g:link> </div>
				    </sec:ifLoggedIn>
				    <sec:ifNotLoggedIn>
				        <div class="col-xs-12 col-md-8"> <a href="${createLink(uri: '/', absolute: true)}"><asset:image src="HealthAlerts_Logo.png" alt="My Health Alert Logo" class='logo' /> </a> </div>
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
						<button type="submit" name="submit" class="btn btn-search" value="" onclick="submitSearch()" id="submit">
							<span class="glyphicon glyphicon-search"></span>
						</button>
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
						<a href="#" data-toggle="modal" data-target="#createAccountModal" > Create Account </a>
					</div>
				</div>
				<div class='right-searchpane-sm col-sm-5 visible-sm'>
					<div>
						<span class='headerText'> WHO WE ARE </span>
					</div>
					<div>
						<div class='descriptionText' >My Health Alert helps individuals and caregivers stay up to date on all reported recalls and side effects for medications and health devices.</div>
						<a href="#" data-toggle="modal" data-target="#createAccountModal" > Create Account </a>
					</div>
				</div>
				<div class='right-searchpane-xs col-xs-12 visible-xs'>
					<div>
						<span class='headerText'> WHO WE ARE </span>
					</div>
					<div>
						<div class='descriptionText' >My Health Alert helps individuals and caregivers stay up to date on all reported recalls and side effects for medications and health devices.</div>
						<a href="#" data-toggle="modal" data-target="#createAccountModal" > Create Account </a>
					</div>
				</div>
			</div>
			<div class='col-md-2 col-sm-1 col-xs-0'></div>
		</div>
	</body>
</html>
