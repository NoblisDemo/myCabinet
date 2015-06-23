package org.noblis.myHealthAlerts

import grails.plugin.springsecurity.ui.RegistrationCode
import grails.plugin.springsecurity.authentication.dao.NullSaltSource

class RegisterController extends grails.plugin.springsecurity.ui.RegisterController {

//    This is copied from grails.plugin.springsecurity.ui.RegisterController but without sending a verification email and
//    with a different redirect on success.
    def register(RegisterCommand command) {

        if (command.hasErrors()) {
            render template: "register", model: [command: command]
            return
        }

        String salt = saltSource instanceof NullSaltSource ? null : command.username
        def user = lookupUserClass().newInstance(username: command.username,
                accountLocked: false, enabled: true, )

        RegistrationCode registrationCode = springSecurityUiService.register(user, command.password, salt)
        if (registrationCode == null || registrationCode.hasErrors()) {
            // null means problem creating the user
            flash.error = message(code: 'spring.security.ui.register.miscError')
            flash.chainedParams = params
            redirect action: 'index'
            return
        }

        redirect url: '/'
    }

}

// This is copied from grails.plugin.springsecurity.ui.RegisterController with the email field removed
class RegisterCommand {

    String username
    String password
    String password2

    def grailsApplication

    static constraints = {
        username blank: false, email: true, validator: { value, command ->
            if (value) {
                if (User.findByUsername(value)) {
                    return 'registerCommand.username.unique'
                }
            }
        }
        password blank: false, validator: RegisterController.passwordValidator
        password2 validator: RegisterController.password2Validator
    }
}