package org.noblis.myHealthAlerts

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(DetailController)
class DetailControllerSpec extends Specification {

    static def default_drug_details = [pharm_class_epc: "p1",manufacturer_name: "m1"
                                ,route: "r1",product_type:"pt1",product_name: "n1"]
    static def default_reaction_list = ["r1","r2","r3","r4"]

    def setup() {
        controller.openFdaSearchService = [
            getDrugDetails: { def drug ->
                default_drug_details
            },
            getReactionList:{def drug->
                default_reaction_list
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
        model.reaction_list == default_reaction_list
    }
}
