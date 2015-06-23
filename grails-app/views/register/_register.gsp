<table>
    <tbody>

    <s2ui:textFieldRow name='username' labelCode='user.username.label' bean="${command}"
                       size='40' labelCodeDefault='Username' value="${command.username}"/>

    <s2ui:passwordFieldRow name='password' labelCode='user.password.label' bean="${command}"
                           size='40' labelCodeDefault='Password' value="${command.password}"/>

    <s2ui:passwordFieldRow name='password2' labelCode='user.password2.label' bean="${command}"
                           size='40' labelCodeDefault='Password (again)' value="${command.password2}"/>

    </tbody>
</table>