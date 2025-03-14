# Use the Tomcat 10.1 official image
FROM tomcat:10.1

# Copy the built WAR file into Tomcat’s webapps directory
COPY MyWebApp.war /usr/local/tomcat/webapps/MyWebApp.war
