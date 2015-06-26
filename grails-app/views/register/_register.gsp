<div id='regForm'>
	<table>
		<tbody>
			<input id='actionUrl' name="actionUrl" value='${g.createLink(controller: "register", action: "register")}' type="hidden">
			<s2ui:textFieldRow name='username' labelCode='user.username.label' bean="${command}" size='40' placeholder='Email' value="${command?.username}"/>
			<s2ui:passwordFieldRow name='password' labelCode='user.password.label' bean="${command}" size='40' placeholder='Password' value="${command?.password}"/>
			<s2ui:passwordFieldRow name='password2' labelCode='user.password2.label' bean="${command}" size='40' placeholder='Password (again)' value="${command?.password2}"/>
		</tbody>
	</table>
</div>