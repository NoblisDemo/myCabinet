# Installing myHealthAlerts

myHealthAlerts is distributed as a web application archive aka <a href=http://ec2-54-175-250-1.compute-1.amazonaws.com/files/myHealthAlerts.war>WAR file</a>, which is placed in the deployment folder of Apache Tomcat web server.

## Requirements
myHealthAlerts requires Java 7 or better and Apache Tomcat 7.

## Getting Started

### Install Java
Ensure a flavor of Java has been installed, Either [openJDK](http://openjdk.java.net/install/) or [Oracle](http://www.oracle.com/technetwork/java/javase/downloads/index.html), to the server.  Please refer to the installation instructions from the link to install on the host OS

### Install Tomcat
myHealthAlerts has been tested on [Apache Tomcat 7](http://tomcat.apache.org/download-70.cgi).  Additional Tomcat versions should be compatible but have not been tested.  Please follow instructions in the [readme file](http://download.nextag.com/apache/tomcat/tomcat-7/v7.0.62/README.html) about installation details.

## Deploy myHealthAlerts

#### Option 1 - Deploy .war directly to Tomcat

There are several ways to deploy a WAR file to Tomcat.  
- The simplest is to copy  <a href=http://ec2-54-175-250-1.compute-1.amazonaws.com/files/myHealthAlerts.war>the WAR file</a> to the /webapps directory of the Tomcat base directory.  The WAR will unpack and deploy itself once dropped into the folder.  
- For more fine grained control, such as easily undeploying, updating, and redeploying the WAR file, please refer to the [Manager App Guide](https://tomcat.apache.org/tomcat-7.0-doc/manager-howto.html)
- If Jenkins is being used for continuous integration there is a [deployment plugin](https://wiki.jenkins-ci.org/display/JENKINS/Deploy+Plugin) that can automatically deploy the WAR to Tomcat.

#### Option 2 - Deploy Via Docker

Alternatively, if Docker is available on the target machine, one could use the following steps to deploy the application

- Load the base Docker image <a href=http://ec2-54-175-250-1.compute-1.amazonaws.com/files/centos_tomcat_2.tar>centos_tomcat_2.tar</a> into the local Docker repository
- Create two folders in your working directory: database and war
- Copy [p_myHealthAlerts_Docker_Install.sh](p_myHealthAlerts_Docker_Install.sh) and the [p_myHealthAlerts_Docker_File.txt](p_myHealthAlerts_Docker_File.txt) to your base directory and <a href=http://ec2-54-175-250-1.compute-1.amazonaws.com/files/myHealthAlerts.war>the WAR file</a> into war directory
- Run [p_myHealthAlerts_Docker_Install.sh](p_myHealthAlerts_Docker_Install.sh) to generate the new docker image and deploy the war file
