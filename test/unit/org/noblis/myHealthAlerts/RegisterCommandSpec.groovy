package org.noblis.myHealthAlerts

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(RegisterController)
@Mock(User)
class RegisterCommandSpec extends Specification {

    void "Test username is valid email address"() {
        when:
            def command = new RegisterCommand(username: "username")
            command.validate()
        then:
            'email.invalid' == command.errors['username'].code
        when:
            command = new RegisterCommand(username: "user@test.com")
            command.validate()
        then:
            assert !command.errors['username']
    }
}
