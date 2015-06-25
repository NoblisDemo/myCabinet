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
            <td class='visible-md visible-lg visible-sm alignCenter'><a href='#' class='add-product' alt='edit health product' data-toggle="modal" data-target="#editProductModal"> Edit </a> <a href='#' class='add-product' alt='delete health product' onclick="${remoteFunction(controller: 'healthProduct',  action: 'delete', id: product.id, onSuccess:"updatePastProductTable()")}">Delete</a></td>
        </tr>
    </g:each>
    </tbody>
</table>