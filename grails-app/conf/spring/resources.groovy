// Place your Spring DSL code here
beans = {

    simpleUrlAuthenticationSuccessHandler(org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler){ bean ->
        defaultTargetUrl = "/dashboard/index" //this param doesn't actually work.  see Config.groovy to change default url
        targetUrlParameter= "spring-security-redirect"
    }

    openFdaApiKey(String, '${openFda.api.key}')

}
