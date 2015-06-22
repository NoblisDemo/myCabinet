package org.noblis.myCabinet

import grails.converters.JSON

class SearchController {

    SearchService openFdaService

    def index() {
        request.withFormat {
            json {
                render(openFdaService.autocomplete(params.term) as JSON)
            }
        }
    }
}
