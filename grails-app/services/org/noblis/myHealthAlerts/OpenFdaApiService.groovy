package org.noblis.myHealthAlerts

import grails.plugin.cache.Cacheable
import groovyx.net.http.HTTPBuilder
import org.apache.http.client.HttpResponseException

class OpenFdaApiService {

    def drugNameSearchDomains = ["patient.drug.openfda.generic_name",
                                 "patient.drug.openfda.substance_name",
                                 "patient.drug.openfda.brand_name"]

    @Cacheable(value="getAllAutocompleteValues")
    def getAllAutocompleteValues() {
        List<Map> results = []

        def http = new HTTPBuilder('https://api.fda.gov/drug/event.json')

        Set drugs = []
        drugNameSearchDomains.each {

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

        def http = new HTTPBuilder('https://api.fda.gov/drug/event.json')
        def drugs = []
        drugNameSearchDomains.each {
            try {
                def json = http.get(query: [search: "${it}:\"$drug\""])
                drugs << json.results.patient
            }catch(HttpResponseException e){
                log.debug("No Response when querying ${it} for drug ${drug}")
            }
        }

        def results = [:]
        ["pharm_class_epc","manufacturer_name","route","product_type"].each{
            results."${it}"= drugs[0].drug.openfda."${it}"[0]
        }

        return results
    }

    //gets a hashmap of recalls:count given a drug
    def getReactionList(String drug){
        def reactionCounts = []
        def http = new HTTPBuilder('https://api.fda.gov/drug/event.json')

        drugNameSearchDomains.each {
            try {
                def json = http.get(query: [search: "${it}:\"$drug\"",count:"patient.reaction.reactionmeddrapt.exact"])
                reactionCounts.addAll(json.results)
            }catch(HttpResponseException e){
                log.debug("No Response when querying ${it} for drug ${drug} reaction count")
            }
        }
        return reactionCounts
     }
}
