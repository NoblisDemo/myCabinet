package org.noblis.myHealthAlerts

class DetailController {
    def openFdaSearchService
    static int ENFORCEMENT_REPORT_SHORT_LENGTH = 50
    static int DESCRIPTION_LENGTH = 50

    def index(String productName) {
        def details = openFdaSearchService.getDrugDetails(productName)
        def reactions = openFdaSearchService.getReactionList(productName)
        def enforcementReports = openFdaSearchService.getEnforcementReports(productName)
        def labelInfo = openFdaSearchService.getLabelInfo(productName)

        addShortReportInfo(enforcementReports)
        addShortDescriptionInfo(labelInfo)

        render view: "index", model: [pharm_class_epc: details.pharm_class_epc,manufacturer_name: details.manufacturer_name
                                      ,route: details.route,product_type:details.product_type,product_name: details.product_name,
                                      reaction_list:reactions,
                                      //enforcement is a list of maps with fields : ["reason_for_recall", "status", "product_description", "report_date", "classification","short_reason"]
                                      enforcement_reports:enforcementReports,
                                      description:labelInfo.description,
                                      warnings:labelInfo.warnings,
                                      short_description:labelInfo.short_description,]
    }

    //adds in a second version of the recall reason field that is shorter (for display purposes)
    private void addShortReportInfo(def enforcementReports){
        enforcementReports.each{
            if (it.reason_for_recall.size() > ENFORCEMENT_REPORT_SHORT_LENGTH) {
                it.short_reason = it.reason_for_recall[0..ENFORCEMENT_REPORT_SHORT_LENGTH-1]
            }
            else{
                it.short_reason = it.reason_for_recall
            }

        }
    }

    //adds in a shorter version of the product description
    private void addShortDescriptionInfo(def labelInfo){
        if (labelInfo.description.size() > DESCRIPTION_LENGTH) {
            labelInfo.short_description = labelInfo.description[0..DESCRIPTION_LENGTH-1]
        }
        else{
            labelInfo.short_description = labelInfo.description
        }

    }
}
