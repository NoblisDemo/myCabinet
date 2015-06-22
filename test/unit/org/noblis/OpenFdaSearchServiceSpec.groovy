package org.noblis

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(OpenFdaSearchService)
class OpenFdaSearchServiceSpec extends Specification {

    static def drugInfo =
[
        full_drug:[
               pharm_class_epc:["p1"],
                manufacturer_name:["m1"],
                route:["r1"],
                product_type:["pt1"]
        ],
        drug_with_extra_info:[
                pharm_class_epc:["p1"],
                manufacturer_name:["m1","m2","m3"],
                route:["r1"],
                product_type:["pt1"]
        ],
        missing_info_drug:[
                pharm_class_epc:[],
                route:[],
        ]
]

    def setup() {
        service.openFdaApiService = [
                getAllAutocompleteValues: { ->
                    return [
                            [term: "TYLENOL", category: "Drug"],
                            [term: "ASPIRIN", category: "Drug"],
                            [term: "LIPITOR", category: "Drug"],
                    ]
                }
        ]

        service.openFdaApiService = [
                getDrugOpenFDADetails: {String drug ->
                    drugInfo[drug]
                }
        ]
    }

    def cleanup() {
    }

    void "test autocomplete"() {
        when:
            def results = service.autocomplete(searchTerm)
        then:
            size == results.size()
            if (matches) {
                assert results*.label.containsAll(matches)
            }
        where:
            searchTerm  | size  | matches
            "tyl"       | 1     | ["TYLENOL"]
            "TyL"       | 1     | ["TYLENOL"]
            "TYLENOL"   | 1     | ["TYLENOL"]
            "SPIRIN"    | 0     | []
    }

    void "test get details"() {
        when:
        def details = service.getDrugDetails(drug)

        then:
        details.pharm_class_epc == pharm_class_epc
        details.manufacturer_name == manufacturer_name
        details.route == route
        details.product_type == product_type
        details.product_name == product_name

        where:
        drug                  |   pharm_class_epc                                 |   manufacturer_name                                 |   route                                   |   product_type                                    |   product_name
        "full_drug"           |   drugInfo.full_drug.pharm_class_epc[0]           |   drugInfo.full_drug.manufacturer_name[0]           |   drugInfo.full_drug.route[0]             |   drugInfo.full_drug.product_type[0]              |  "full_drug"
        "drug_with_extra_info"|   drugInfo.drug_with_extra_info.pharm_class_epc[0]|   drugInfo.drug_with_extra_info.manufacturer_name[0]|   drugInfo.drug_with_extra_info.route[0]  |   drugInfo.drug_with_extra_info.product_type[0]   |  "drug_with_extra_info"
        "missing_info_drug"   |   "Unknown"                                       |    "Unknown"                                        | "Unknown"                                 |"Unknown"                                          |   "missing_info_drug"
    }
}
