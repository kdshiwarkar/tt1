# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables
ENV MAVEN_VERSION 3.9.7
ENV TOMCAT_VERSION 9.0.89

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget tar openjdk-11-jdk git

# Install Maven
RUN wget https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -P /tmp && \
    tar xf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Install Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -P /tmp && \
    tar xf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt && \
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat

# Set environment variables for Maven and Tomcat
ENV MAVEN_HOME /opt/maven
ENV CATALINA_HOME /opt/tomcat
ENV PATH $MAVEN_HOME/bin:$CATALINA_HOME/bin:$PATH

# Clone the repository
RUN git clone https://github.com/kdshiwarkar/tt1.git /usr/src/app

# Set the working directory
WORKDIR /usr/src/app

# Build the application
RUN mvn install

# Copy the WAR file to the Tomcat webapps directory
RUN cp target/tabletennis.war $CATALINA_HOME/webapps/

# Expose the Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]




