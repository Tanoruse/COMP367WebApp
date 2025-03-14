FROM tomcat:10.1
COPY target/MyWebApp.war /usr/local/tomcat/webapps/MyWebApp.war
