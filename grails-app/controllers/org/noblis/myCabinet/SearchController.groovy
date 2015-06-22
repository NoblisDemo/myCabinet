package org.noblis.myCabinet

import grails.converters.JSON

class SearchController {

    SearchService openFdaSearchService

    def index() {
        request.withFormat {
            json {
                render(openFdaSearchService.autocomplete(params.term) as JSON)
            }
        }
    }
}
