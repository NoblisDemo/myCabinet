package org.noblis.myHealthAlerts

class HealthProductController {

    def springSecurityService

    def view(){
        render template: "../healthProduct/addProduct"
    }

    def add() {
        def product = new HealthProduct(params)
        if(product.validate()){
            product.save()
            //get current user and add to their list of products
            def user = springSecurityService.getCurrentUser()
            user.addToProducts(product)
            user.save(flush:true)
            //render a success
            render status:200
        }
        else{
            render template: "addProduct", status:417, model:[product:product]
        }
    }

    def update() {
        def product = HealthProduct.get(params.id)
        if(product){
            product.properties = params
            if(product.validate()){
                product.save()
                render status:200
            }
            else {
                render status:417, model:[product:product]
            }
        }
        else {
            flash.message = "Product could not be found"
            render status: 417
        }
    }

    def delete() {
        def product = HealthProduct.get(params.id)
        if(product){
            try {
                //get current user and remove from their list of products
                def user = springSecurityService.getCurrentUser()
                user.removeFromProducts(product)
                user.save()
                product.delete(flush:true)
                render status: 200
            } catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Could not delete product ${product.name}"
                render status:417
            }
        }
        else {
            flash.message = "Product could not be found"
            render status: 417
        }
    }
}
