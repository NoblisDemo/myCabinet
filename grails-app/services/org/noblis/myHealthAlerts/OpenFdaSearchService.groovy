package org.noblis.myHealthAlerts

class OpenFdaSearchService implements SearchService {

    def openFdaApiService

    @Override
    List<Map> autocomplete(String term) {
        List<Map> results = []

        def autocompleteValues = openFdaApiService.getAllAutocompleteValues()

        results.addAll autocompleteValues.findAll {
            it.term ==~ /(?i)$term.*/
        }.collect {
            [label: it.term, category: it.category]
        }

        return results
    }

}
