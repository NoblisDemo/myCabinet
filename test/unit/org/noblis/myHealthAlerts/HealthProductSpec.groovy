package org.noblis.myHealthAlerts

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(HealthProduct)
class HealthProductSpec extends Specification {

    void "test create health product"() {
        when:
            def product = new HealthProduct()
        then:
            !product.validate()
            assert "nullable" == product.errors['productName'].code

        when:
            product = new HealthProduct(productName:"drug")
        then:
            product.validate()

        when: "checking to see if saving updates the date"
            assertNull product.startDate
            product = product.save(flush:true)
        then:
            def savedProduct = HealthProduct.get(product.id)
            assertNotNull savedProduct.startDate

    }

}
