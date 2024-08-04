pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Local') {
            steps {
                sh '/home/kunalshiwarkar/Documents/Devops_software/tar/apache-maven-3.9.7/bin/mvn install'
            }
        }
        stage('Deploy Local') {
            steps {
                sh 'cp target/tt1.war /home/kunalshiwarkar/Documents/Devops_software/tar/apache-tomcat-9.0.89/webapps'
            }
        }
        stage('Build Project') {
            steps {
                sh '/download/extract/maven/bin/mvn install'
            }
        }
        stage('Copy WAR to Tomcat') {
            steps {
                sh 'cp target/tt1.war /download/extract/tomcat/webapps/'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t kunalsh/pipetest1 .'
            }
        }
        stage('Run Docker Container') {
            steps {
                sh 'docker run -dit --name=containerpipe1 -p 8080:8080 kunalsh/pipetest1 /bin/bash'
            }
        }
    }
}


