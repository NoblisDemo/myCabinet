<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Dashboard</title>
    <asset:stylesheet src="dashboard.css"/>
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
    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
        <table class="table table-bordered table-hover table-condensed table-striped">
            <thead>
            <tr>
                <th>Product Name</th>
                <th class='visible-md visible-lg visible-sm alignCenter'>Date Started</th>
                <th class='alignCenter' >Email Notification</th>
                <th class='visible-md visible-lg visible-sm alignCenter'>Product Details</th>
            </tr>
            </thead>
            <tbody class='table-bordered table-hover table-condensed table-striped'>
            <g:each in="${products}" var="product">
                <tr>
                    <td><g:link controller="detail" action="index" params="[productName:product.productName]">${product.productName}</g:link></td>
                    <td class='visible-md visible-lg visible-sm alignCenter'><g:formatDate format="MM-dd-yyyy" date="${product.startDate}"/></td>
                    <td class='alignCenter'><g:checkBox name="emailNotification" checked="${product.emailNotification}" onclick="${remoteFunction(controller: 'healthProduct',  action: 'updateNotification', id: product.id, params: '\'emailNotification=\' + this.checked')}"/> </td>
                    <td class='visible-md visible-lg visible-sm alignCenter'><g:link controller="detail" action="index" params="[productName:product.productName]" class='btn viewButton' >View</g:link> </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
<div class='row'>
    <div class='tableTitle col-xs-12 col-sm-12 col-md-12 col-lg-12'>MY PAST PRODUCTS</div>
    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
        <table class="table table-bordered table-hover table-condensed table-striped">
            <thead>
            <tr>
                <th>Product Name</th>
                <th class='visible-md visible-lg visible-sm alignCenter'>Dates Used</th>
                <th class='alignCenter' >Email Notification</th>
                <th class='visible-md visible-lg visible-sm alignCenter'>Product Details</th>
            </tr>
            </thead>
            <tbody class='table-bordered table-hover table-condensed table-striped'>
            <g:each in="${pastProducts}" var="product">
                <tr>
                    <td><g:link controller="detail" action="index" params="[productName:product.productName]">${product.productName}</g:link></td>
                    <td class='visible-md visible-lg visible-sm alignCenter'><g:formatDate format="MM-dd-yyyy" date="${product.startDate}"/> - <g:formatDate format="MM-dd-yyyy" date="${product.endDate}"/></td>
                    <td class='alignCenter'><g:checkBox name="emailNotification" checked="${product.emailNotification}" onclick="${remoteFunction(controller: 'healthProduct',  action: 'updateNotification', id: product.id, params: '\'emailNotification=\' + this.checked')}"/> </td>
                    <td class='visible-md visible-lg visible-sm alignCenter'><g:link controller="detail" action="index" params="[productName:product.productName]" class='btn viewButton' >View</g:link> </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
<div class="row">
    <div class='row recall-head'><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> RECENT RECALLS </div>
    <div class='row recalls'>

        <g:set var="total" value="${5}"/>
        <g:if test="${enforcement_reports.size() < total}">
            <g:set var="total" value="${enforcement_reports.size()}"/>
        </g:if>
        %{--TODO: DISPLAY NO RECALLS IF NO RECALLS--}%
        <g:if test="${total > 0}">
        <g:each in="${0..total-1}" var="index" >
            <g:if test="${enforcement_reports[index] != null}">
                <div class='reason'>
                    ${enforcement_reports[index]?.getAt('product_name')}<br/>
                    <p>${enforcement_reports[index]?.getAt('short_reason')} ...</p>
                    <a href='#' class='read-more' alt='read more link' data-toggle="modal" data-target="#recall-${index}" > Read More </a>
                </div>

            </g:if>
        </g:each>
        </g:if>

    </div>
</div>


<!--Some logic to create all the modals for the read more recent recalls -->

<g:set var="total" value="${5}"/>
<g:if test="${enforcement_reports.size() < total}">
    <g:set var="total" value="${enforcement_reports.size()}"/>
</g:if>

<g:each in="${0..total}" var="index" >
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
</body>