<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<asset:stylesheet src="detail.css"/>
		<title>Detailed View</title>
	</head>
	<body>
	<div class="row">
  		<div class="col-xs-12 col-md-8"> <asset:image src="HealthAlerts_Logo.png" alt="My Health Alert Logo" class='logo' /> </div>
  		<div class="col-xs-6 col-md-4 align-right"> 
  			<span class='headerText'> PRODUCT SEARCH </span>
			<div class='input-group'>
				<g:render template="../searchBox"/>
				<span class="input-group-btn">
					<g:submitButton name="submit" class="btn btn-default" type="button" value="Search" onclick="submitSearch()"/>
				</span>
			</div>
		</div>
	</div>

	<div class='row'>
		<div class='col-md-12'>
			<h1 class='main-header'> ${product_name} </h1>
		</div>
	</div>

	<div class='row'>
		<div class="detail-chart-nav">
	    <ul class="nav nav-tabs" id="myTab">
	        <li class="active"><a href="#details">Details</a></li>
	        <li><a href="#charts">Charts</a></li>
	    </ul>
	    <div class="tab-content">
		        <div id="details" class="tab-pane fade in active">
		        	<div class="row prod-info">
				        <div class="col-xs-12 col-md-8">
				        	<h3> PRODUCT INFORMATION </h3>
				        	<div class='row first-row'>
				        		<div class='col-md-6'>
				        			<span class='info'>PRODUCT TYPE:</span>   ${product_type}
				        		</div>
				        		<div class='col-md-6'>
				        			<span class='info'>PHARMACY CLASS:</span>    ${pharm_class_epc}
				        		</div>
				        	</div>

				        	<div class='row'>
				        		<div class='col-md-6'>
				        			<span class='info'>MANUFACTURER:</span>   ${manufacturer_name}
				        		</div>
				        		<div class='col-md-6'>
									<span class='info'>APPLICATION METHOD:</span>   ${route}
				        		</div>
				        	</div>

		            		<h3>TOP 5 SIDE EFFECTS:</h3>

		            		<div id="adverse-events">
							  <ul>
							    <li>Nose Bleed</li>
							    <li>Nausea</li>
							    <li>Vomitting</li>
							    <li>Shortness of breath</li>
							  </ul>
							</div>

							<a href='#' class='show-adverse-events' alt='show adverse events'> Show More</a>

		            		<h3>LABEL WARNINGS</h3>

		            		<div class='prod-info'>
		            			<span class='info'>ADDITIONAL WARNINGS: </span> warning placeholder
		            		</div>

				        </div>
				        <div class="col-xs-12 col-md-4 recall-div">
				           <div class='row recall-head'><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> RECENT RECALLS </div>
				           <div class='row well recalls'> </div>
				        </div>
				    </div>
		        </div>

		        <div id="charts" class="tab-pane fade">
		            <h3>Charts</h3>
		            <p>Vestibulum nec erat eu nulla rhoncus fringilla ut non neque. Vivamus nibh urna, ornare id gravida ut, mollis a magna. Aliquam porttitor condimentum nisi, eu viverra ipsum porta ut. Nam hendrerit bibendum turpis, sed molestie mi fermentum id. Aenean volutpat velit sem. Sed consequat ante in rutrum convallis. Nunc facilisis leo at faucibus adipiscing.</p>
		        </div>
		    </div>
		</div>
	</div> 


	<!--modal for adverse events -->

	<div id="adverseModal" class="modal fade">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title">Adverse Events</h4>
	            </div>
	            <div class="modal-body">
	                <div class='adverse-event-list'> </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            </div>
	        </div>
	    </div>
	</div>

	</body>
</html>