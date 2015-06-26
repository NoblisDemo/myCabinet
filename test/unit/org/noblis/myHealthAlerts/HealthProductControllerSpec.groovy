package org.noblis.myHealthAlerts

import grails.test.mixin.TestFor
import grails.test.mixin.TestMixin
import grails.test.mixin.domain.DomainClassUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(HealthProductController)
@TestMixin(DomainClassUnitTestMixin)
class HealthProductControllerSpec extends Specification {

    void setup() {
        mockDomains(User, HealthProduct)
        def user = new User(username:"testUser@email.com", password: "password")
        user.save(flush:true, failOnError:true)
        controller.springSecurityService = [
                getCurrentUser: {User.get(1)}
        ]
    }

    void "test add a valid health product"() {
        when: "set up the form"
            params.productName = "test"
            controller.add()
        then:
            response.status == 200
            flash.message == null
            HealthProduct.count() == 1
            User.get(1).products.size() == 1
    }

    void "test add an invalid health product"() {
        when: "set up the form"
            controller.add()
        then:
            response.status == 417
            HealthProduct.count() == 0
            flash.message == null
    }

    void "test update health product"() {
        when: "set up the form"
            params.productName = "test"
            controller.add()
        then:
            response.status == 200
            HealthProduct.count() == 1
        when: "update the product"
            params.id = 1
            params.productName = "test2"
            controller.update()
        then:
            response.status == 200
            HealthProduct.get(1).productName == "test2"

    }

    void "test update health product no id"() {
        when:
            params.id = 1
            params.name = "test2"
        controller.update()
        then:
            response.status == 417
            flash.message == "Product could not be found"
    }

    void "test delete health product"() {
        when: "set up the form"
            params.productName = "test"
            controller.add()
        then:
            response.status == 200
            HealthProduct.count() == 1
            User.get(1).products.size() == 1
        when: "delete the product"
            params.id = 1
            controller.delete()
        then:
            response.status == 200
            HealthProduct.count() == 0
            User.get(1).products.size() == 0
    }

    void "test delete health product no id"(){
        when: "delete the product"
            params.id = 1
            controller.delete()
        then:
            response.status == 417
            flash.message == "Product could not be found"
    }

    void "test update notification checkbox"(){
        when: "set up the form"
        params.productName = "test"
        controller.add()
        then:
        response.status == 200
        HealthProduct.count() == 1
        User.get(1).products.size() == 1
        HealthProduct.get(1).emailNotification == true
        when: "change checkbox and update"
        params.id = 1
        params.emailNotification = "false"
        controller.updateNotification()
        then:
        HealthProduct.get(1).emailNotification == false
    }
}

