<script>
$(function() {
    $( "#startdatepicker" ).datepicker();
    $( "#enddatepicker" ).datepicker();
  });
  </script>
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
            <label>Name: </label> <g:textField name="productName" value="${product?.productName?:product_name}"/>
        </div>
        <div class="form-horizontal">
            <label>Start Date: </label><input type="text" name="startDate" value="${product?.startDate}" id="startdatepicker" style="width:75px;"> (Optional)
        </div>
        <div class="form-horizontal">
            <label>End Date: </label><input type="text" name="endDate" value="${product?.endDate}" id="enddatepicker" style="width:75px;"> (Optional)
        </div>
        <g:submitButton name="add" value="Add"/>
    </g:formRemote>
</div>