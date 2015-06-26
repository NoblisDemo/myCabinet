package org.noblis.myHealthAlerts

class DashboardController {

    def springSecurityService
    def openFdaSearchService

    def index() {
        def enforcementReports = openFdaSearchService.getEnforcementReports(springSecurityService.getCurrentUser().products*.productName)
        def products = springSecurityService.getCurrentUser().products.findAll{!it.endDate || (it.endDate > new Date())}?.sort{it.productName}
        def pastProducts = springSecurityService.getCurrentUser().products.findAll{it.startDate && it.endDate && (it.endDate < new Date())}?.sort{it.productName}
        render view:"index", model: [
                enforcement_reports:enforcementReports,
                products: products,
                pastProducts: pastProducts
        ]
    }

    def refreshProducts() {
        render(template: "productTable", model:[products: springSecurityService.getCurrentUser().products.findAll{!it.endDate || (it.endDate > new Date())}?.sort{it.productName}])
    }

    def refreshPastProducts(){
        render(template: "pastProductTable", model:[pastProducts: springSecurityService.getCurrentUser().products.findAll{it.startDate && it.endDate && (it.endDate < new Date())}?.sort{it.productName}])
    }
}
