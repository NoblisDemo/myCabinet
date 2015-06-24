package org.noblis.myHealthAlerts

import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(User)
class UserSpec extends Specification {

    void "Test email address constraint on username"(){
        when:
            def u = new User(username:"notvalid")
        then:
            !u.validate()
            assert 'email.invalid' == u.errors['username'].code
        when:
            u = new User(username:"test@noblis.org", password: "password")
        then:
            u.validate()
    }
}
