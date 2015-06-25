package org.noblis.myHealthAlerts

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(OpenFdaSearchService)
class OpenFdaSearchServiceSpec extends Specification {
    //mock data representing info that would return from a relevant drug info query to the events database
    static def drugInfo =
            [
                    full_drug:[
                            pharm_class_epc:[["p1"]],
                            manufacturer_name:[["m1"]],
                            route:[["r1"]],
                            product_type:[["pt1"]]
                    ],
                    drug_with_extra_info:[
                            pharm_class_epc:[["p1"]],
                            manufacturer_name:[["m1","m2","m3"]],
                            route:[["r1"]],
                            product_type:[["pt1"]]
                    ],
                    missing_info_drug:[
                            pharm_class_epc:[[]],
                            route:[[]],
                    ]
            ]

    //mock data representing info that would return from a relevant reaction count query to the events database
    static def reactionInfo =
            [
                    alreadyOrderedCount:[[term:"r1",count:1000],[term:"r2",count:500],[term:"r3",count:200]],
                    unorderedCount:[[term:"r2",count:500],[term:"r3",count:200],[term:"r1",count:1000]],
                    oneItem:[[term:"r1",count:1000]],
                    duplicateItems:[[term:"r1",count:1000],[term:"r3",count:400],[term:"r2",count:200],[term:"r2",count:500],[term:"r3",count:100]]
            ]

    //mock data representing info that would return from a relevant query to the enforcement reports database
    static def enforcementReports =
            [
                    reportWithNormalInfo:[
                            [reason_for_recall:["r1"],status:["s1"],product_description:["pd1"],report_date:["2015-01-01"],classification:["c1"]]
                    ],
                    reportWithMissingInfo:[[report_date:["2015-01-01"]]],
                    reportWithExtraInfo:[
                            [reason_for_recall:["r1"],status:["s1"],product_description:["pd1"],report_date:["2015-01-01"],classification:["c1"],
                             voluntary_mandated:["vm1"],distribution_pattern:["dp1"]]
                    ],
                    multipleReportsUnsorted:[ [reason_for_recall:["r1"],status:["s1"],product_description:["pd1"],report_date:["2015-01-01"],classification:["c1"]],
                                              [reason_for_recall:["r2"],status:["s2"],product_description:["pd2"],report_date:["2015-01-03"],classification:["c1"]],
                                              [reason_for_recall:["r3"],status:["s3"],product_description:["pd2"],report_date:["2015-01-05"],classification:["c1"]]],
                    multipleReportsSorted:[ [reason_for_recall:["r1"],status:["s1"],product_description:["pd1"],report_date:["2015-01-6"],classification:["c1"]],
                                            [reason_for_recall:["r2"],status:["s2"],product_description:["pd2"],report_date:["2015-01-04"],classification:["c1"]],
                                            [reason_for_recall:["r3"],status:["s3"],product_description:["pd2"],report_date:["2015-01-02"],classification:["c1"]]]
            ]

    //mock data representing info that would return from a relevant drug info query to the labels database
    static def labelInfo =
            [
                    full_drug:[
                            description:[[["d1"]]],
                            warnings:[[["w1"]]],
                    ],
                    drug_with_extra_info:[
                            description:[[["d1"]]],
                            warnings:[[["w1","w2"]]],
                            dosage_and_administration:[[["da1"]]],
                            when_using:[[["p1"]]]
                    ],
                    missing_info_drug:[
                            description:[],
                    ]
            ]

    def setup() {
        enforcementReports.info_with_short_reason = [[reason_for_recall:["A"],report_date:["2015-01-02"]],[reason_for_recall:["A LONGER REASON"],report_date:["2015-01-01"]]]
        service.openFdaApiService = [
                getAllAutocompleteValues: { ->
                    return [
                            [term: "TYLENOL", category: "Drug"],
                            [term: "ASPIRIN", category: "Drug"],
                            [term: "LIPITOR", category: "Drug"],
                    ]
                },
                getDrugOpenFDADetails: {String drug ->
                    drugInfo[drug]
                }
                ,
                getReactionList:{String drug ->
                    reactionInfo[drug]
                },
                getEnforcementReports:{List<String> drugs ->
                    drugs.collectEntries{[(it):enforcementReports[it]]}
                },
                getLabelInfo:{String drug ->
                    labelInfo[drug]
                }

        ]

    }

    void "test autocomplete"() {
        when:
        def results = service.autocomplete(searchTerm)
        then:
        size == results.size()
        if (matches) {
            assert results*.label.containsAll(matches)
        }
        where:
        searchTerm  | size  | matches
        "tyl"       | 1     | ["TYLENOL"]
        "TyL"       | 1     | ["TYLENOL"]
        "TYLENOL"   | 1     | ["TYLENOL"]
        "SPIRIN"    | 0     | []
    }

    void "test get details"() {
        when:
        def details = service.getDrugDetails(drug)

        then:
        details.pharm_class_epc == pharm_class_epc[0]
        details.manufacturer_name == manufacturer_name[0]
        details.route == route[0]
        details.product_type == product_type[0]
        details.product_name == product_name

        where:
        drug                  |   pharm_class_epc                                 |   manufacturer_name                                 |   route                                   |   product_type                                    |   product_name
        "full_drug"           |   drugInfo.full_drug.pharm_class_epc[0]           |   drugInfo.full_drug.manufacturer_name[0]           |   drugInfo.full_drug.route[0]             |   drugInfo.full_drug.product_type[0]              |  "full_drug"
        "drug_with_extra_info"|   drugInfo.drug_with_extra_info.pharm_class_epc[0]|   drugInfo.drug_with_extra_info.manufacturer_name[0]|   drugInfo.drug_with_extra_info.route[0]  |   drugInfo.drug_with_extra_info.product_type[0]   |  "drug_with_extra_info"
        "missing_info_drug"   |   ["Unknown"]                                       |   ["Unknown"]                                       | ["Unknown"]                                 |["Unknown"]                                          |   "missing_info_drug"
    }

    void "test get reaction list"(){
        when:
        def reactionList = service.getReactionList(drug)

        then:
        reactionList == correctReactionOrder

        where:
        drug                    |   correctReactionOrder
        "alreadyOrderedCount"   |   ["r1","r2","r3"]
        "unorderedCount"        |   ["r1","r2","r3"]
        "oneItem"               |   ["r1"]
        "duplicateItems"        |   ["r1","r2","r3"]
    }

    void "test get enforcement report data"(){
        when:
        def enforcementReport = service.getEnforcementReports([drug])[0]

        then:
        enforcementReport.reason_for_recall==reason_for_recall
        enforcementReport.status==status
        enforcementReport.product_description==product_description
        enforcementReport.report_date==report_date
        enforcementReport.classification==classification
        enforcementReport.product_name == product_name

        where:
        drug                   |   reason_for_recall   |   status  |   product_description |   report_date |   classification   |   product_name
        "reportWithNormalInfo" |   "r1"                |   "s1"    |   "pd1"               |   "2015-01-01"|   "c1"             |   "reportWithNormalInfo"
        "reportWithExtraInfo"  |   "r1"                |   "s1"    |   "pd1"               |   "2015-01-01"|   "c1"             |   "reportWithExtraInfo"
        "reportWithMissingInfo"|   "Unknown"           |   "Unknown"|   "Unknown"          |   "2015-01-01"|   "Unknown"        |   "reportWithMissingInfo"
    }

    void "test enforcement report sorting"(){
        when:
        def enforcementReports = service.getEnforcementReports(drugs)

        then:
        dates.eachWithIndex{it,index->
            enforcementReports[index].report_date == it
        }

        where:
        drugs                                               |   dates
        ["multipleReportsSorted"]                           |   ["2015-01-03","2015-01-02","2015-01-01"]
        ["multipleReportsUnsorted"]                         |   ["2015-01-03","2015-01-02","2015-01-01"]
        ["multipleReportsSorted","multipleReportsUnsorted"] |   ["2015-01-06","2015-01-05","2015-01-04","2015-01-03","2015-01-02","2015-01-01"]
    }

    void "test get warnings and description"(){
        when:
        def labelInfo = service.getLabelInfo(drug)

        then:
        labelInfo.description == description
        labelInfo.warnings == warnings

        where:
        drug                    |   description |   warnings
        "full_drug"             |   "d1"        |   "w1"
        "drug_with_extra_info"  |   "d1"        |   "w1"
        "missing_info_drug"|   "Unknown"   |   "Unknown"
    }

    void "test add short report info"(){
        when:
        service.ENFORCEMENT_REPORT_SHORT_LENGTH = limit
        def reports = service.getEnforcementReports(["info_with_short_reason"])

        then:
        reports[0].short_reason == short_reason[0]
        reports[1].short_reason == short_reason[1]

        where:
        limit | short_reason
        50    | ["A","A LONGER REASON"]
        1     | ["A","A"]
    }
}
