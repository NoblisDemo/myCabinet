package org.noblis.myHealthAlerts

class DetailController {
    def openFdaSearchService
    static int ENFORCEMENT_REPORT_SHORT_LENGTH = 50

    def index(String productName) {
        def details = openFdaSearchService.getDrugDetails(productName)
        def reactions = openFdaSearchService.getReactionList(productName)
        def enforcementReports = openFdaSearchService.getEnforcementReports(productName)
        addShortReportInfo(enforcementReports)
        //enforcement is a list of maps with fields : ["reason_for_recall", "status", "product_description", "report_date", "classification","short_reason"]
        render view: "index", model: [pharm_class_epc: details.pharm_class_epc,manufacturer_name: details.manufacturer_name
         ,route: details.route,product_type:details.product_type,product_name: details.product_name, reaction_list:reactions,enforcement_reports:enforcementReports]
    }

    //adds in a second version of the recall reason field that is shorter (for display purposes)
    private void addShortReportInfo(def enforcementReports){
        enforcementReports.each{
            if (it.reason_for_recall.length() > ENFORCEMENT_REPORT_SHORT_LENGTH) {
                it.short_reason = it.reason_for_recall[0..ENFORCEMENT_REPORT_SHORT_LENGTH-1]
            }
            else{
                it.short_reason = it.reason_for_recall
            }

        }
    }
}
