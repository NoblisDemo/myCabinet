package org.noblis

import org.noblis.myCabinet.SearchService
import groovyx.net.http.HTTPBuilder

class OpenFdaService implements SearchService {

    @Override
    List<String> autocomplete(String term) {

        println "in OpenFdaService autocomplete"
        List<Map> results = []

        def http = new HTTPBuilder('https://api.fda.gov/drug/event.json')

        def json = http.get(query : [count: "patient.drug.medicinalproduct.exact", limit: 1000])

        results.addAll json.results.findAll {
            it.term ==~ /$term.*/
        }.collect {
            it.term
        }

        return results
    }

}
