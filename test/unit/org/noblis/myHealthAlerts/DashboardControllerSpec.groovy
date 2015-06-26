package org.noblis.myHealthAlerts

import grails.test.mixin.TestFor
import grails.test.mixin.TestMixin
import grails.test.mixin.domain.DomainClassUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(DashboardController)
@TestMixin(DomainClassUnitTestMixin)
class DashboardControllerSpec extends Specification {

    void setup() {
        mockDomains(User, HealthProduct)
        def user = new User(username:"testUser@email.com", password: "password", products: [new HealthProduct (productName:"product1"), new HealthProduct (productName: "product2"),
                                                                                            new HealthProduct (productName:"product3", startDate: new Date().parse("MM/dd/yyyy", "06/10/2015"), endDate: new Date().parse("MM/dd/yyyy", "06/17/2015")),
                                                                                            new HealthProduct (productName:"product4", startDate: new Date().parse("MM/dd/yyyy", "06/10/2015"), endDate: new Date().parse("MM/dd/yyyy", "06/17/2015"))])
        user.save(flush:true, failOnError:true)
        controller.springSecurityService = [
                getCurrentUser: {User.get(1)}
        ]
        controller.openFdaSearchService = [
                getEnforcementReports: { def drug ->
                    [[reason_for_recall:"RECALL1"],[reason_for_recall:"RECALL2"]]
                },
        ]
    }


    void "test index"() {
        when:
        controller.index()

        then:
        model.products.size() == 2
        model.products*.productName.contains("product1")
        model.products*.productName.contains("product2")
        model.pastProducts.size() == 2
        model.pastProducts*.productName.contains("product3")
        model.pastProducts*.productName.contains("product4")
        model.enforcement_reports.size() == 2
        model.enforcement_reports[0].reason_for_recall == "RECALL1"
        model.enforcement_reports[1].reason_for_recall == "RECALL2"
    }
}
