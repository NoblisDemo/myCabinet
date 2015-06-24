package org.noblis.myHealthAlerts

class DashboardController {

    def springSecurityService
    def openFdaSearchService

    def index() {
        def enforcementReports = openFdaSearchService.getEnforcementReports(springSecurityService.getCurrentUser().products*.productName)

        render view:"index", model: [
                enforcementReports:enforcementReports,
                products:springSecurityService.getCurrentUser().products.findAll{!it.endDate}]
    }
}
