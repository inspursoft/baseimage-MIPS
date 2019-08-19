FROM inspursoft/baseimage-mips:1.0

MAINTAINER Rainy

WORKDIR /root/rainy/tomcat8

RUN yum install java-1.8.0-openjdk.mips64el -y

WORKDIR /root/rainy/tomcat8

COPY apache-tomcat-8.5.43 /root/rainy/tomcat8/apache-tomcat-8.5.43

ADD MyServlet.war /root/rainy/tomcat8/apache-tomcat-8.5.43/webapps

ENV CATALINA_HOME /root/rainy/tomcat8/apache-tomcat-8.5.43
ENV PATH $PATH:$CATALINA_HOME/lib:$CATALINA_HOME/bin

EXPOSE 8080

CMD ["/root/rainy/tomcat8/apache-tomcat-8.5.43/bin/catalina.sh","run"]