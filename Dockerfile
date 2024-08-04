# Use the latest Ubuntu image as the base image
FROM ubuntu:latest

# Maintainer information
MAINTAINER kdshiwarkar@gmail.com

# Update all packages and install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    vim \
    git \
    ssh \
    openjdk-11-jdk \
    maven \
    docker.io

# Set up Docker stable repository and update packages
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Start SSH service
RUN service ssh start

# Create working directory
WORKDIR /download/extract/

# Install Maven, Java, and Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.tar.gz && \
    tar -xvzf apache-tomcat-9.0.89.tar.gz && \
    mv apache-tomcat-9.0.89 tomcat && \
    wget https://downloads.apache.org/maven/maven-3/3.9.7/binaries/apache-maven-3.9.7-bin.tar.gz && \
    tar -xvzf apache-maven-3.9.7-bin.tar.gz && \
    mv apache-maven-3.9.7 maven

# Environment variables
ENV MAVEN_HOME=/download/extract/maven
ENV PATH=$MAVEN_HOME/bin:$PATH

# Copy the application files
COPY . /download/extract/

# Stage names in Dockerfile
RUN /download/extract/maven/bin/mvn install
RUN cp /download/extract/target/tt1.war /download/extract/tomcat/webapps/

# Expose ports (example: Tomcat default port 8080)
EXPOSE 8080

# Start Tomcat
CMD ["/download/extract/tomcat/bin/catalina.sh", "run"]


