<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Dashboard</title>
</head>
<body>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Date Started</th>
                <th>Email Notification</th>
                <th>Product Details</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${products}" var="product">
                <tr>
                    <td>${product.productName}</td>
                    <td><g:formatDate format="MM-dd-yyyy" date="${product.startDate}"/></td>
                    <td><g:checkBox name="emailNotification" checked="${product.emailNotification}"/></td>
                    <td><g:link controller="detail" action="index" params="[term:product.productName]">View</g:link> </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</body>