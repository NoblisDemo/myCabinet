eventPackagingEnd = {
    def buildNumber = System.getenv().get("BUILD_NUMBER") ?: "CUSTOM"
    def gitCommit = System.getenv().get("GIT_COMMIT") ?: "N/A"
    ant.propertyfile(
            file:"${classesDir}/application.properties") {
        entry(key:"build.number", value:buildNumber)
        entry(key: "git.id", value:gitCommit)
    }
}