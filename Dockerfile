FROM tomcat:9

COPY target/healthy-hens-1.0.war /usr/local/tomcat/webapps/healthy-hens.war

EXPOSE 8000
