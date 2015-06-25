<table class="table table-hover table-condensed table-striped">
    <thead>
    <tr>
        <th>Product Name</th>
        <th class='visible-md visible-lg visible-sm alignCenter borderLeft'>Date Started</th>
        <th class='alignCenter borderLeft' >Email Notification</th>
        <th class='visible-md visible-lg visible-sm alignCenter borderLeft'>Actions</th>
    </tr>
    </thead>
    <tbody class='table-hover table-condensed table-striped'>
    <g:each in="${products}" var="product">
        <tr>
            <td><g:link controller="detail" action="index" params="[productName:product.productName]">${product.productName}</g:link></td>
            <td class='visible-md visible-lg visible-sm alignCenter borderLeft'><g:formatDate format="MM-dd-yyyy" date="${product.startDate}"/></td>
            <td class='alignCenter borderLeft'><g:checkBox name="emailNotification" checked="${product.emailNotification}" onclick="${remoteFunction(controller: 'healthProduct',  action: 'updateNotification', id: product.id, params: '\'emailNotification=\' + this.checked')}"/> </td>
            <td class='visible-md visible-lg visible-sm alignCenter borderLeft'><a href='#' alt='edit health product' data-toggle="modal" data-target="#editProductModal" onclick="setUpEditModal('${product.id}')"> Usage Ended </a> | <a href='#' alt='delete health product' onclick="${remoteFunction(controller: 'healthProduct',  action: 'delete', id: product.id, onSuccess:"updateProductTable()")}">Delete</a></td>
        </tr>
    </g:each>
    </tbody>
</table>