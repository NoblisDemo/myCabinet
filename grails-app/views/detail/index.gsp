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
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script>
		google.load('visualization', '1', {packages: ['corechart', 'bar']});
		google.setOnLoadCallback(drawChart)
		function drawChart() {

			var dataArray = [["Reaction", "Count"]]

			$.ajax("${g.createLink(action: "topReportedSideEffects", params: [productName: params.productName])}", {
				success: function (data) {
					$(data).each(function (i, row) {
						dataArray.push(
								[row.term, row.count]
						);
					});

					var tableData = google.visualization.arrayToDataTable(dataArray);

					var chart = new google.visualization.BarChart(
							document.getElementById('countReactionsChart'));

					chart.draw(tableData, {
						title: "Top Side Effects Reported",
						height: 350,
						width: 500,
						colors: ['#b81e30'],
						bars: 'horizontal',
						legend: { position: "none" },
						hAxis: {
							title: "Occurances"
						}
					});
				}
			});
		};
	</script>
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

<sec:ifLoggedIn>
	<div class='dashboard-link'><g:link resource="dashboard">Return to My Dashboard &#62;&#62;</g:link></div>
</sec:ifLoggedIn>
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
								<span class="complete hide">${description_more}</span>
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
						<div class='row'>
							<div class='prod-info col-md-6'>
								<span class='info'>ADDITIONAL WARNINGS: </span> <div class="warnings">${warnings} </div>
							</div>
						</div>
					</div>

					<div class="col-xs-12 col-md-4 recall-div">
						<div class='row recall-head'><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> RECENT RECALLS </div>
						<g class='row recalls'>

							<g:each in="${0..<Math.min(enforcement_reports.size(), 5)}" var="index" >
								<g:if test="${enforcement_reports[index] != null}">
									<div class='reason'>
										<p>${enforcement_reports[index]?.getAt('short_reason')} ...</p>
										<a href='#' class='read-more' alt='read more link' data-toggle="modal" data-target="#recall-${index}" > Read More </a>
									</div>

								</g:if>
							</g:each>

					</div>
				</div>
			</div>
		</div>

		<div id="charts" class="tab-pane fade">
			<h3>Charts</h3>
			<div id="countReactionsChart"></div>
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

<!--Modal to add a product -->
<div id="addProductModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button id="productCloseButton" type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">ADD PRODUCT</h4>
			</div>
			<g:render template="../healthProduct/addProduct" model="${[product_name:product_name]}"/>
		</div>
	</div>
</div>

<!--Some logic to create all the modals for the read more recent recalls -->

<g:each in="${0..<Math.min(enforcement_reports.size(), 5)}" var="index" >
	<g:if test="${enforcement_reports[index] != null}">

		<div id="recall-${index}" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button id="RecallCloseButton" type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title">Recall Details</h4>
					</div>
					<div class="modal-body">

						<p><span class="info">REASON FOR RECALL:</span> ${enforcement_reports[index]?.getAt('reason_for_recall')} </p>
						<p><span class="info">STATUS:</span>${enforcement_reports[index]?.getAt('status')}</p>
						<p><span class="info">DESCRIPTION:</span>${enforcement_reports[index]?.getAt('product_description')}</p>
						<p><span class="info">REPORT DATE:</span>${enforcement_reports[index]?.getAt('report_date')}</p>
						<p><span class="info">CLASSIFICATION:</span>${enforcement_reports[index]?.getAt('classification')}</p>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

	</g:if>
</g:each>
</body>

</html>