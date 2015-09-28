FROM ubuntu
MAINTAINER Shiva Prasad <shiva.prasad-l-k@hpe.com>
 
# setup WildFly
RUN mkdir /opt/wildfly
COPY wildfly-8.2.0.Final /opt/wildfly
 
# install example app on wildfy
COPY car-service.war /opt/wildfly/standalone/deployments/
 
# setup Java
 
RUN mkdir /opt/java
 
COPY jdk-8u60-linux-x64.tar.gz /opt/java/
 
# change dir to Java installation dir
 
WORKDIR /opt/java/
 
RUN tar -zxf jdk-8u60-linux-x64.tar.gz
 
# setup environment variables
 
RUN update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_60/bin/javac 100
 
RUN update-alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_60/bin/java 100
 
RUN update-alternatives --display java
 
RUN java -version
 
# Expose the ports we're interested in
EXPOSE 8080 9990
 
# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0"]
