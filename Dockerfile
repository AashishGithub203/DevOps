# 1. Deploying a html static page
FROM nginx:latest
MAINTAINER "aashishkumar.nist@gmail.com"
COPY . /usr/share/nginx/html
# Or COPY test.html /user/share/nginx/html   Dot(.) means all the files from the current location
# ADD . /user/share/nginx/html   - is also possible
EXPOSE 
# The container will run internally at 8080
# docker build -t myhtmlpage:v1 .
# docker run -it -d --name myhtml_page -p 7070:8080 myhtmlpage:v1     [conatiner will be exposed for user at 7070]

--------------------------------------------------------------------------------------------------------
# Best use case [VVI] Deploying a war file over tomcat server

FROM tomcat:8
COPY target/*.war /user/local/tomcat/webapps

------------------------------------------------------------------------------------------------------

# 3. Deploying .jar/.war    
FROM java:8.0
# COPY path-to-your-application-jar path-to-webapps-in-docker-jar
COPY target/myproject-name_0.0.1_SNAPSHOT.jar /app/myproject_name.jar     
# once job will be run in jenkins a target folder would be created that contains .jar compiled packaged file   
CMD ["java","-jar","/app/myproject_name.jar"] 
# docker build -t myweb1:v1 .
# docker run -it -d --name myapp -p 9090:8080 myweb1:v1 
# Your application can be accessed on <IpOfInstance:9090> 

-------------------------------------------------------------------------------------------------------------

# 4. deploying a spring website
FROM anapsix/alpine-java 
LABEL maintainer="aashishkumar.nist@gmail.com" 
COPY /target/spring-petclinic-1.5.1.jar /home/spring-petclinic-1.5.1.jar 
CMD ["java","-jar","/home/spring-petclinic-1.5.1.jar"]
# docker build -t myweb3:v1 .
# docker run -it -d --name myapp2 -p 9091:8080 myweb3:v1 
# Your application can be accessed in <IpOfInstance:9091>

-------------------------------------------------------------------------------------------------------

# 2. Deploying a webapp into tomcat server
FROM tomcat:latest
MAINTAINER "aashishkumar.nist@gmail.com"
RUN yum install java -y
WORKDIR /opt/tomcat 
ADD <TarUrlOfTomact> /opt/tomcat    
# COPY <TarUrlOfTomact> /opt/tomcat  - is not possible as URL can't be used in COPY command.           
RUN tar -xvzf apachr-tomcat-9.0.54.tar.gz
RUN mv apachr-tomcat-9.0.54.tar.gz/* /opt/tomcat
# RUN command will be executed during the creation of the container
EXPOSE 8080
# The container will be running at 8080 port internally
COPY ./webapp.war /opt/tomcat/webapps
# ADD ./webapp.war /opt/tomcat/webapps  - is also possible 
CMD ["/opt/tomcat/bin/cataline.sh","run"]
# CMD command will be executed once container is all set and running
# ENTRYPOINT ["/opt/tomcat/bin/catalina.sh","run"] will also work only in case the user will not pass 
# any argumant while running the container. only difference is the user can override the CMD 
# command through docker run command parameter, but entrypoint can't be overridden by user.
# docker build -t myweb1:v1 .
# docker run -it -d --name mywebsite -p 9090:8080 myweb1:v1 

-------------------------------------------------------------------------------------------------------

