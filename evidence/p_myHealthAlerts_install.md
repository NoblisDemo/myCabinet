# Installing myHealthAlerts

myHealthAlerts is distributed as a web aplication archive aka WAR file, which is placed in the deployment folder of Apache Tomcat web server.

## Requirements
myHealthAlerts requires Java 7 or better and Apache Tomcat 6 or better.

## Getting Started

### Install Java
Ensure a flavor of Java has been installed, Either [openJDK](http://openjdk.java.net/install/) or [Oracle](http://www.oracle.com/technetwork/java/javase/downloads/index.html), to the server.  Please refer to the installation instructions from the link to install on the host OS

### Install Tomcat
myHealthAlerts has been tested on [Apache Tomcat 6](http://tomcat.apache.org/download-60.cgi).  Higher Tomcat versions should be compatible but have not been tested.  Please follow instructions in the [readme file](http://download.nextag.com/apache/tomcat/tomcat-6/v6.0.44/README.html) about installation details.

## Deploy myHealthAlerts
There are several ways to deploy a WAR file to Tomcat.  
- The simplest is to copy the WAR file to the /webapps directory of the Tomcat base directory.  The WAR will unpack and deploy itself once dropped into the folder.  
- For more fine grained control, such as easily undeploying, updating, and redeploying the WAR file, please refer to the [Manager App Guide](https://tomcat.apache.org/tomcat-6.0-doc/manager-howto.html) 
- If Jenkins is being used for continuous integration there is a [deployment plugin](https://wiki.jenkins-ci.org/display/JENKINS/Deploy+Plugin) that can automatically deploy the WAR to Tomcat.