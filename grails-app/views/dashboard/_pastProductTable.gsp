<table class="table table-hover table-condensed table-striped">
    <tbody class='table-hover table-condensed table-striped'>
    <g:each in="${pastProducts}" var="product">
        <tr>
            <td><g:link controller="detail" action="index" params="[productName:product.productName]">${product.productName}</g:link></td>
            <td><g:formatDate format="MM-dd-yyyy" date="${product.startDate}"/> - <g:formatDate format="MM-dd-yyyy" date="${product.endDate}"/></td>
        </tr>
    </g:each>
    </tbody>
</table>