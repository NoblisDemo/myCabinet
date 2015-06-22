package org.noblis

import com.google.gson.JsonNull
import org.noblis.myCabinet.SearchService

class OpenFdaSearchService implements SearchService {

    def openFdaApiService

    @Override
    List<Map> autocomplete(String term) {
        List<Map> results = []

        def autocompleteValues = openFdaApiService.getAllAutocompleteValues()

        results.addAll autocompleteValues.findAll {
            it.term ==~ /(?i)$term.*/
        }.collect {
            [label: it.term, category: it.category]
        }

        return results
    }


    Map getDrugDetails(String drug) {
        def results =  openFdaApiService.getDrugOpenFDADetails(drug)
        //add fields to map and populate missing fields with "unknown"
        def drugDetails = [:]

        ["pharm_class_epc","manufacturer_name","route","product_type"].each{
            if (results[it] && (results[it][0])){
                drugDetails.put(it, results[it][0][0])
            }
            else{
                drugDetails.put(it, "Unknown")
            }
        }
        drugDetails.product_name = drug
        return drugDetails
    }

}
