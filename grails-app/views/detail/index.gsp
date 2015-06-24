<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<g:javascript>
			function closeModal(){
				$(productCloseButton).click();
				return false;
			}
		</g:javascript>
		<asset:stylesheet src="detail.css"/>
		<title>Detailed View</title>
	</head>
	<body>
	<div class="row">
  		<div class="col-xs-12 col-md-8"> <asset:image src="HealthAlerts_Logo.png" alt="My Health Alert Logo" class='logo' /> </div>
  		<div class="col-xs-6 col-md-4 align-right"> 
  			<span class='headerText'> PRODUCT SEARCH </span> <span class="glyphicon glyphicon-info-sign tip" data-toggle="tooltip" data-placement="top" title="Search works for Medicine names only. Choose from the auto fill dropdown options for guaranteed results." aria-hidden="true"></span>
			<div class='input-group'>
				<g:render template="../searchBox"/>
				<span class="input-group-btn">
					<button type="submit" name="submit" class="btn btn-search" value="" onclick="submitSearch()" id="submit">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</span>
			</div>
		</div>
	</div>

	<div class='row'>
		<div class='col-md-12 main-header'>
			<h1 class='inline'> ${product_name} </h1>
			<!-- auth check goes here -->
				<sec:ifLoggedIn>
				<a href='#' class='add-product' alt='add health product' data-toggle="modal" data-target="#addProductModal"> + Add to My Products</a>
				</sec:ifLoggedIn>
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

				        	<div class='row first-row col-md-12'>
				        		<span class='info'>DESCRIPTION:</span> 
				        	</div>

				        	<div class='row col-md-12'>
				        		<span class="teaser">${description}</span>

				        		<g:if test="${! description.equals('Unknown') }">
									<span class="complete hide"> ${description_more}</span>
									<a href='#' class="more">more...</a>
								</g:if>
				        	</div>

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
							 	<g:set var="count" value="${0}"/>
							 	 
							 		<g:each in="${reaction_list}" var='reaction'>
							 			<g:if test="${count < 5 }">
				  							<li> <span class="glyphicon glyphicon-play bullet" aria-hidden="true"></span> ${reaction}  </li>
				  						</g:if>
				  						<g:set var="count" value="${count + 1}"/>
					  				</g:each>


							  
							</div>

							<a href='#' class='show-adverse-events' alt='show adverse events' data-toggle="modal" data-target="#adverseModal"> Show More</a>

		            		<h3>LABEL WARNINGS</h3>

		            		<div class='prod-info'>
		            			<span class='info'>ADDITIONAL WARNINGS: </span> warning placeholder
		            		</div>

				        </div>
				        <div class="col-xs-12 col-md-4 recall-div">
				           <div class='row recall-head'><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> RECENT RECALLS </div>
				           <div class='row well recalls'> 

				           	 	<g:set var="count" value="${0}"/>
							 	 
							 		<g:each in="${enforcement_reports}" var='reports'>
							 			<g:each in="${reports.value}" var="report">

							 				${report}

							 			</g:each>

					  				</g:each>


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


	<!--modal for adverse events -->

	<div id="adverseModal" class="modal fade">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title">ALL SIDE EFFECTS</h4>
	            </div>
	            <div class="modal-body">
                	<div>
					  <ul class='modal-ul'>
					  	<g:each in="${reaction_list}" var='reaction'>
				  			<li> <span class="glyphicon glyphicon-play bullet" aria-hidden="true"></span> ${reaction}  </li>
					  	</g:each>
					  </ul>
					</div> 
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            </div>
	        </div>
	    </div>
	</div>

	<div id="addProductModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button id="productCloseButton" type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">ADD PRODUCT</h4>
				</div>
				<div class="modal-body">
					<g:render template="../healthProduct/addProduct" model="${[product_name:product_name]}"/>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>