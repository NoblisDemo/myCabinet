package mycabinet

class DetailController {
    def openFdaSearchService

    def index(String productName) {
        def details = openFdaSearchService.getDrugDetails(productName)
        render view: "index", model: [pharm_class_epc: details.pharm_class_epc,manufacturer_name: details.manufacturer_name
         ,route: details.route,product_type:details.product_type,product_name: details.product_name]
    }
}
