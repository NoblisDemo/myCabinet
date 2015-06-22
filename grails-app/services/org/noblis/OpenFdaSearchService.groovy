package org.noblis

import org.noblis.myCabinet.SearchService
import groovyx.net.http.HTTPBuilder

class OpenFdaSearchService implements SearchService {

    @Override
    List<Map> autocomplete(String term) {
        List<Map> results = []

        def http = new HTTPBuilder('https://api.fda.gov/drug/event.json')

        def json = http.get(query : [count: "patient.drug.medicinalproduct.exact", limit: 1000])

        results.addAll json.results.findAll {
            it.term ==~ /(?i)$term.*/
        }.collect {
            [label: it.term, category: "Drug"]
        }

        return results
    }

}
