<div id='regForm'>
	<table>
		<tbody>
			<input id='actionUrl' name="actionUrl" value='${g.createLink(controller: "register", action: "register")}' type="hidden">
			<div class="form-group">
				<s2ui:textFieldRow name='username' labelCode='user.username.label' bean="${command}" size='40' value="${command?.username}"/>
			</div>
			<div class="form-group">
				<s2ui:passwordFieldRow name='password' labelCode='user.password.label' bean="${command}" size='40' value="${command?.password}"/>
			</div>
			<div class="form-group">
				<s2ui:passwordFieldRow name='password2' labelCode='user.password2.label' bean="${command}" size='40'  value="${command?.password2}"/>
			</div>
		</tbody>
	</table>
</div>