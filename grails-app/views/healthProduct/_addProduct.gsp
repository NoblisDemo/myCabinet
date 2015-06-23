<div id="product-form">
    <g:formRemote name="product-form" url="[controller: 'healthProduct', action: 'add']" update="[failure: 'product-form']" onSuccess="closeModal()">
        <g:hasErrors bean="${product}">
            <ul class="errors" role="alert">
                <g:eachError bean="${product}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>
        <div class ="form-horizontal">
            <label>Name: </label> <g:textField name="productName" value="${product?.productName?:productName}"/>
        </div>
        <div class="form-horizontal">
            <label>Start Date</label><g:datePicker name="startDate" value="${product?.startDate}"/>
        </div>
        <div class="form-horizontal">
            <label>End Date</label><g:datePicker name="endDate" value="${product?.endDate}"/>
        </div>
        <g:submitButton name="add" value="Add"/>
    </g:formRemote>
</div>