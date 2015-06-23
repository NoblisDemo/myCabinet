<g:form controller="healthProduct" action="add">

    <div class ="form-horizontal">
        <label>Name: </label> <g:textField name="productName" value="${product?.productName}"/>
    </div>
    <div class="form-horizontal">
        <label>Start Date</label><g:datePicker name="startDate" value="${product?.startDate}"/>
    </div>
    <div class="form-horizontal">
        <label>End Date</label><g:datePicker name="endDate" value="${product?.endDate}"/>
    </div>
    <g:submitButton name="add" value="Add"/>
</g:form>
