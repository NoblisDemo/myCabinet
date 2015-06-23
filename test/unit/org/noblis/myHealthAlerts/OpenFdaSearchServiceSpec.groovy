package org.noblis.myHealthAlerts

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(OpenFdaSearchService)
class OpenFdaSearchServiceSpec extends Specification {

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
}
