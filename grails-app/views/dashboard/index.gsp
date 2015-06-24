<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Dashboard</title>
</head>
<body>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th class="text-center">Date Started</th>
                    <th class="text-center">Email Notification</th>
                    <th class="text-center">Product Details</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${products}" var="product">
                    <tr>
                        <td>${product.productName}</td>
                        <td class="text-center"><g:formatDate format="MM-dd-yyyy" date="${product.startDate}"/></td>
                        <td class="text-center"><g:checkBox name="emailNotification" checked="${product.emailNotification}" onclick="${remoteFunction(controller: 'healthProduct',  action: 'updateNotification', id: product.id, params: '\'emailNotification=\' + this.checked')}"/></td>
                        <td class="text-center"><g:link controller="detail" action="index" params="[term:product.productName]">View</g:link> </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>
</body>