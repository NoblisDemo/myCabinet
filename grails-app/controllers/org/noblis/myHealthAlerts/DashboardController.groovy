package org.noblis.myHealthAlerts

class DashboardController {

    def springSecurityService

    def index() {
        render view:"index", model: [products:springSecurityService.getCurrentUser().products.findAll{!it.endDate}?.sort{it.productName}]
    }
}
