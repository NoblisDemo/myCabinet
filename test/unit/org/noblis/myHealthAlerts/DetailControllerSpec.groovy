package myHealthAlerts

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(DetailController)
class DetailControllerSpec extends Specification {

    static def default_drug_details = [pharm_class_epc: "p1",manufacturer_name: "m1"
                                ,route: "r1",product_type:"pt1",product_name: "n1"]

    def setup() {
        controller.openFdaSearchService = [
            getDrugDetails: {def drug ->
                default_drug_details
            }
        ]
    }

    def cleanup() {
    }

    void "test index"() {
        when:
        controller.index("foo")

        then:
        model.pharm_class_epc == default_drug_details.pharm_class_epc
        model.manufacturer_name == default_drug_details.manufacturer_name
        model.route == default_drug_details.route
        model.product_type == default_drug_details.product_type
        model.product_name == default_drug_details.product_name

    }
}
