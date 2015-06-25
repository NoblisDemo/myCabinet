<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Dashboard</title>
    <asset:stylesheet src="dashboard.css"/>
    <g:javascript>
        function setUpEditModal(id){
            $("#edit-product").load("/myHealthAlerts/healthProduct/edit/"+id);
        };
        function closeModalAndUpdate(callback){
            $(productCloseButton).click();
            updateProductTable()
            updatePastProductTable()
            return false;
        };
        function updateProductTable(){
            $("#product-table").empty()
            $("#product-table").load("/myHealthAlerts/dashboard/refreshProducts")
        };

        function updatePastProductTable(){
            $("#past-product-table").empty()
            $("#past-product-table").load("/myHealthAlerts/dashboard/refreshPastProducts")
        };
    </g:javascript>
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
    <div class='tableTitle col-xs-12 col-sm-12 col-md-12 col-lg-12'>MY CURRENT PRODUCTS</div>
    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12 currentProducts' id="product-table">
        <g:render template="productTable"/>
    </div>
</div>
<div class='row'>
    <div class='col-xs-12 col-sm-12 col-md-6 col-lg-6'>
        <h3 class='stretchH3'><span class='paddingH3'>MY PAST PRODUCTS</span></h3>
        <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12 pastProduts' id="past-product-table">
            <g:render template="pastProductTable"/>
        </div>
    </div>

    <div class='col-xs-12 col-sm-12 col-md-6 col-lg-6'>
        <div class='row recall-head'><h3 class='stretchH3 pushH3right'><asset:image src="RecallWarningIcon_Blue.png" alt="My Health Alert Logo" class='alertIcon' /> RECENT RECALLS </h3></div>
        <div class='row recalls'>
            <g:each in="${0..<Math.min(enforcement_reports.size(), 5)}" var="index" >
                <g:if test="${enforcement_reports[index] != null}">
                    <div class='reason'>
                        <span class="glyphicon glyphicon-play bullet" aria-hidden="true"></span> <span class='reasonName'>${enforcement_reports[index]?.getAt('product_name')}</span>
                        <div class='reasonDescription'>
                            <p>${enforcement_reports[index]?.getAt('short_reason')} ...</p>
                            <a href='#' class='read-more' alt='read more link' data-toggle="modal" data-target="#recall-${index}" > Read More </a>
                        </div>
                    </div>
                </g:if>
            </g:each>
            <g:if test="${enforcement_reports.size() <= 0}">
                <div class='reason'>
                    NO RECALLS
                </div>
            </g:if>
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
                        <p><span class="info">PRODUCT NAME:</span> ${enforcement_reports[index]?.getAt('product_name')} </p>
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

<!--Modal to edit a product -->
<div id="editProductModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button id="productCloseButton" type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">EDIT PRODUCT</h4>
            </div>
            <div id="edit-product"/>
        </div>
    </div>
</div>
</body>