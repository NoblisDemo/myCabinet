package org.noblis

import grails.plugin.cache.Cacheable
import groovyx.net.http.HTTPBuilder
import org.apache.http.client.HttpResponseException

class OpenFdaApiService {

    @Cacheable(value="getAllAutocompleteValues")
    def getAllAutocompleteValues() {
        List<Map> results = []

        def http = new HTTPBuilder('https://api.fda.gov/drug/event.json')

        Set drugs = []
        ["patient.drug.openfda.generic_name",
         "patient.drug.openfda.substance_name",
         "patient.drug.openfda.brand_name"].each {

            def json = http.get(query : [count: "${it}.exact", limit: 1000])

            drugs.addAll json.results*.term*.toUpperCase()
        }

        results.addAll drugs.collect {
            [term: it, category: "Drug"]
        }

//        TODO: add devices

        return results
    }

    //searching openfda for drug name and return the drug.openfda field for the first match
    def getDrugOpenFDADetails(String drug) {

        def dataFields = ["patient.drug.openfda.generic_name",
                          "patient.drug.openfda.substance_name",
                          "patient.drug.openfda.brand_name"]

        def json = http.get(query: [search: "${dataFields[0]}:\"$drug\"+${dataFields[1]}:\"$drug\"+${dataFields[2]}:\"$drug\""])
        drugs << json.results.patient.drug

        return drugs[0].drug.openfda
    }
}
