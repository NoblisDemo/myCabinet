eventWarStart = { warName ->
    def buildNumber = System.getProperty("BUILD_NUMBER", "CUSTOM")
    def gitCommit = System.getProperty("GIT_COMMIT", "N/A")
    ant.propertyfile(
            file:"${classesDir}/application.properties") {
        entry(key:"build.number", value:buildNumber)
        entry(key: "git.id", value:gitCommit)
    }
}