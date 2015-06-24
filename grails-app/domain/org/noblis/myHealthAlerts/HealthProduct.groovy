package org.noblis.myHealthAlerts

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode
class HealthProduct {

    String productName
    Date startDate
    Date endDate
    Boolean emailNotification = true

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
