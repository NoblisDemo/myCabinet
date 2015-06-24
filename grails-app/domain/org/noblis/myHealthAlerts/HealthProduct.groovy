package org.noblis.myHealthAlerts

class HealthProduct {

    String productName
    Date startDate
    Date endDate

    static constraints = {
        productName blank:false
        startDate nullable:true
        endDate nullable:true
    }

    def beforeInsert() {
        if(!startDate) {
            startDate = new Date()
        }
    }
}
