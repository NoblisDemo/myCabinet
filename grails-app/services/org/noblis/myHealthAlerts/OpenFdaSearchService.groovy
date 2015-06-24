package org.noblis.myHealthAlerts

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

    //returns an ordered list of reactions (max to min) given a drug
    List getReactionList(String drug){
        def reactionMap = openFdaApiService.getReactionList(drug)
        def reactionList = reactionMap.collect {[it.term,it.count]}
        //order the list based on count and return just the reactions
        def returnList= reactionList.sort{a,b->b[1].compareTo a[1]}.collect{it[0]}

        return returnList
    }

    //gets the list of enforcement reports for a given drug,organized by date with most recent first
    List getEnforcementReports(String drug){
        def rawEnforcements = openFdaApiService.getEnforcementReports(drug)
        def enforcementReports = []
        rawEnforcements.each { curRawReport ->
            def curReport = [:]
            ["reason_for_recall", "status", "product_description", "report_date", "classification"].each {
                if (curRawReport[it] ) {
                    curReport[it] = curRawReport[it]
                } else {
                    curReport[it] = "Unknown"
                }
            }
            enforcementReports << curReport
        }
        //the date format on the website is listed as yyyymmdd but is actually yyyy-MM-dd in the data
        return enforcementReports.sort{a,b->
            new Date().parse("yyyy-MM-dd", b.report_date).compareTo(new Date().parse("yyyy-MM-dd", a.report_date))
        }
    }

}
