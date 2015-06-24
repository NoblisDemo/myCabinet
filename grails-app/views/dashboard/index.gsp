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
                            <td><g:link controller="detail" action="index" params="[term:product.productName]">${product.productName}</g:link></td>
                            <td class='visible-md visible-lg visible-sm alignCenter'><g:formatDate format="MM-dd-yyyy" date="${product.startDate}"/></td>
                            <td class='alignCenter'><g:checkBox name="emailNotification" checked="${product.emailNotification}"/></td>
                            <td class='visible-md visible-lg visible-sm alignCenter'><g:link controller="detail" action="index" params="[term:product.productName]" class='btn viewButton' >View</g:link> </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </div>
</body>