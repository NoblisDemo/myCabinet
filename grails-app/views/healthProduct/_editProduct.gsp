<script>
    $(function() {
        $( "#startdatepicker" ).datepicker();
        $( "#enddatepicker" ).datepicker();
    });
</script>

<div class="modal-body">
    <div id="product-form">
        <g:formRemote name="product-form" url="[controller: 'healthProduct', action: 'update', id:product.id]" update="[failure: 'product-form']" onSuccess="closeModalAndUpdate()">
            <g:hasErrors bean="${product}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${product}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <div class ="form-horizontal form-group">
                <g:hiddenField name="productName" value="${product?.productName}"/>
                <label>Name: ${product?.productName}
            </div>
            <div class="form-horizontal form-group">
                <label>Start Date: </label><input class="form-control" type="text" name="startDate" value="${product?.startDate?.format("MM/dd/yyyy")}" id="startdatepicker" style="width:100px;">
            </div>
            <div class="form-horizontal form-group">
                <label>End Date: </label><input class="form-control" type="text" name="endDate" value="${product?.endDate?.format("MM/dd/yyyy")}" id="enddatepicker" style="width:100px;">
            </div>
            <div class='form-btns'>
                <g:submitButton name="edit" class='btn btn-primary' value="Save"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </g:formRemote>
    </div>
</div>