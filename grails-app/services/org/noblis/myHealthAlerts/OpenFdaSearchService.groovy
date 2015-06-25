package org.noblis.myHealthAlerts

class OpenFdaSearchService implements SearchService {
    static int ENFORCEMENT_REPORT_SHORT_LENGTH = 300

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

    @Override
    List<Map> countReactionsByDrug(String term) {
        return openFdaApiService.countReactionsByDrug(term,10)
    }

    @Override
    List<Map> countReactionsByDrugOverTime(String term) {
        def apiResults = openFdaApiService.countReactionsByDrugOverTime(term)
        return apiResults.groupBy { it.time[0..5] }
                .collect { k, v -> [date: k, count: v*.count.sum() ] }
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
        def reactionMap = openFdaApiService.countReactionsByDrug(drug)

        return reactionMap.collect{it.term}
    }

    //gets the list of enforcement reports for a given drug,organized by date with most recent first
    List getEnforcementReports(List<String> drugs){
        def rawEnforcements = openFdaApiService.getEnforcementReports(drugs)
        def enforcementReports = []
        //iterate through all enforcements from all drugs, adding drug info as a field to report
        drugs.each { drug ->
            rawEnforcements[drug].each { curRawReport ->
                //parsing out the relevant data for the reports and putting them in a new map
                def curReport = [:]
                ["reason_for_recall", "status", "product_description", "classification", "report_date"].each {
                    if (curRawReport[it] && curRawReport[it][0]) {
                        curReport[it] = curRawReport[it][0]
                    } else {
                        curReport[it] = "Unknown"
                    }
                }
                curReport.product_name=drug
                //adds in a second version of the recall reason field that is shorter (for display purposes)
                if (curReport.reason_for_recall.size() > ENFORCEMENT_REPORT_SHORT_LENGTH) {
                    curReport.short_reason = curReport.reason_for_recall[0..ENFORCEMENT_REPORT_SHORT_LENGTH - 1]
                } else {
                    curReport.short_reason = curReport.reason_for_recall
                }

                enforcementReports << curReport
            }
        }
        //the date format on the website is listed as yyyymmdd but is actually yyyy-MM-dd or yyyyMMdd
        return enforcementReports.sort{a,b->
            try {
                new Date().parse("yyyy-MM-dd", b.report_date).compareTo(new Date().parse("yyyy-MM-dd", a.report_date))
            }catch(Exception e){
                log.debug("Error parsing date for drug, attemping alternate date format")
                new Date().parse("yyyyMMdd", b.report_date).compareTo(new Date().parse("yyyyMMdd", a.report_date))
            }
        }
    }



    //Gets the description and warnings info given a drug
    Map getLabelInfo(String drug){
        def labelInfo = openFdaApiService.getLabelInfo(drug)

        def results = [:]
        //parsing out the warnings and descriptions and adding them to a new map
        ["warnings","description"].each{
            if (labelInfo[it] && (labelInfo[it][0]) && (labelInfo[it][0][0])) {
                results[it] = labelInfo[it][0][0][0]
            }
            else{
                results[it] = "Unknown"
            }
        }
        return results
    }

}
