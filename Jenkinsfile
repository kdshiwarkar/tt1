pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh '/home/kunalshiwarkar/Documents/Devops_software/tar/apache-maven-3.9.7/bin/mvn install'
            }
        }
        stage('Deployment') {
            steps {
                sh 'cp target/tt1.war /home/kunalshiwarkar/Documents/Devops_software/tar/apache-tomcat-9.0.89/webapps'
            }
        }
        stage('Docker build') {
            steps {
                sh 'docker build -t kunalsh/pipetest1 .'
            }
        }
        stage('Container creation') {
            steps {
                sh 'docker run -dit --name=containerpipe1 kunalsh/pipetest1 /bin/bash'
            }
        }
    }
}	
