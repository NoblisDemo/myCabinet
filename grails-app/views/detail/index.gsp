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
  		<div class="col-xs-6 col-md-4 align-right"> <g:render template="../searchBox"/><a href='#' class='btn btn-primary' onclick="submitSearch()"> Go </a></div>
	</div>

	<div class='row'>
		<div class='col-md-12'>
			<h1 class='main-header'> ${product_name} </h1>
		</div>
	</div>

	<div class='row'>
		<div class="bs-example">
	    <ul class="nav nav-tabs" id="myTab">
	        <li class="active"><a href="#details">Details</a></li>
	        <li><a href="#charts">Charts</a></li>
	    </ul>
	    <div class="tab-content">
		        <div id="details" class="tab-pane fade in active">
		        	<div class="row">
				        <div class="col-xs-12 col-md-8">

				        	<div class='row first-row'>
				        		<div class='col-md-6'>
				        			<strong>Product Type:</strong>   ${product_type}
				        		</div>
				        		<div class='col-md-6'>
				        			<strong>Pharm Class:</strong>    ${pharm_class_epc}
				        		</div>
				        	</div>

				        	<div class='row'>
				        		<div class='col-md-6'>
				        			<strong>Manu. Name:</strong>   ${manufacturer_name}
				        		</div>
				        		<div class='col-md-6'>
									<strong>Route:</strong>   ${route}
				        		</div>
				        	</div>





		            		<h3>Adverse Events (Top 5):</h3>

		            		<h3>Warnings</h3>

				        </div>
				        <div class="col-xs-12 col-md-4">
				            <div class='enforment-report'> 
				            	<div class='well enforment-reports'>
				            		<h4> Enforcement Reports </h4>


				            	</div>

				            </div>
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

	</body>
</html>