<script>
$(function() {
    $( "#startdatepicker" ).datepicker();
    $( "#enddatepicker" ).datepicker();
  });
  </script>

<div class="modal-body">
    <div id="product-form">
        <g:formRemote name="product-form" url="[controller: 'healthProduct', action: 'add']" update="[failure: 'product-form']" onSuccess="closeModal()">
            <g:hasErrors bean="${product}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${product}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <div class ="form-horizontal form-group">
                <label>Name: </label> <g:textField class="form-control" name="productName" value="${product?.productName?:product_name}"/>
            </div>
            <div class="form-horizontal form-group">
                <label>Start Date: </label><input class="form-control" type="text" name="startDate" value="${product?.startDate}" id="startdatepicker" style="width:75px;"> (Optional)
            </div> 
            <div class="form-horizontal form-group">
                <label>End Date: </label><input class="form-control" type="text" name="endDate" value="${product?.endDate}" id="enddatepicker" style="width:75px;"> (Optional)
            </div>
            <div class='form-btns'>
                <g:submitButton name="add" class='btn btn-primary' value="Add"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </g:formRemote>
    </div>
</div>

