# Use Tomcat 10.1 as the base image
FROM tomcat:10.1

# Copy the WAR file into Tomcat's webapps directory
COPY MyWebApp.war /usr/local/tomcat/webapps/MyWebApp.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
