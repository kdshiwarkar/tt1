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
                sh 'mvn install'
            }
        }
        stage('Deployment'){
            steps {
                sh 'cp target/tabletennis.war /home/kunalshiwarkar/Documents/Devops_software/tar/apache-tomcat-9.0.89/webapps'
            }
        }
        stage('Docker build'){
            steps {
                sh 'docker build -t kunalsh/containerpipe2 .'
            }
        }
        stage('Container creation'){
            steps {
                sh 'docker run -dit --name=kunalcont kunalsh/containerpipe2 /bin/bash'
            }
        }
        stage('deploy in container ') {
            steps {
                sh 'cp target/tabletennis.war /opt/download/apache-tomcat-9.0.91/webapps'
            }
        }
    }
}
