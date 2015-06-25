package org.noblis.myHealthAlerts

import grails.plugin.cache.Cacheable
import groovyx.net.http.HTTPBuilder
import org.apache.http.client.HttpResponseException
import groovyx.net.http.Method

class OpenFdaApiService {

    def eventDrugNameSearchDomains = ["patient.drug.openfda.generic_name",
                                 "patient.drug.openfda.substance_name",
                                 "patient.drug.openfda.brand_name"]
    def drugNameSearchDomains = ["openfda.generic_name",
                                          "openfda.substance_name",
                                          "openfda.brand_name"]

    @Cacheable(value="getAllAutocompleteValues")
    def getAllAutocompleteValues() {
        List<Map> results = []

        def http = new HTTPBuilder('https://api.fda.gov/drug/event.json')

        Set drugs = []
        eventDrugNameSearchDomains.each {

            def json = http.get(query : [count: "${it}.exact", limit: 1000])

            drugs.addAll json.results*.term*.toUpperCase()
        }

        results.addAll drugs.collect {
            [term: it, category: "Drug"]
        }

        return results
    }

    //searching openfda for drug name and return the drug.openfda field for the first match
    def getDrugOpenFDADetails(String drug) {

        def http = new HTTPBuilder('https://api.fda.gov/drug/event.json')
        def drugs = []
        eventDrugNameSearchDomains.each {
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

    //gets enforcement reports for a given drug
    def getEnforcementReports(List<String> drugs){
        def enforcementReports = [:]
        def http = new HTTPBuilder('https://api.fda.gov/drug/enforcement.json')

        drugNameSearchDomains.each {
            drugs.each {drug->
                enforcementReports[drug] = []
                try {
                    def json = http.get(query: [search: "${it}:\"$drug\"", limit: "25"])
                    enforcementReports[drug] << json.results
                } catch (HttpResponseException e) {
                    log.debug("No Response when querying ${it} of enforcement database for drug ${drug} enforcement report")
                }
            }
        }
        return enforcementReports
    }

    def countReactionsByDrug(String term,int limit = 100) {
        def http = new HTTPBuilder('https://api.fda.gov/drug/event.json')

        def searchTerm = drugNameSearchDomains.collect {
            "$it:$term"
        }.join(" ")

        def query = [search: searchTerm, count: "patient.reaction.reactionmeddrapt.exact", limit: limit]

        def json = http.request(Method.GET) {
            uri.query = query
            response.failure = { rest ->
                log.error "Error executing request with query $query"
            }
        }
        return json?.results ?: []
    }

    //query labels database for drug description and warnings
    def getLabelInfo(String drug){
        def http = new HTTPBuilder('https://api.fda.gov/drug/label.json')
        def results = []
        drugNameSearchDomains.each {
            try {
                def json = http.get(query: [search: "${it}:\"$drug\""])
                results << json.results
            }catch(HttpResponseException e){
                log.debug("No Response when querying ${it} of label database for drug ${drug}")
            }
        }

        return results
    }
}
