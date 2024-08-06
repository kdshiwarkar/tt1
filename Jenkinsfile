pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'git fsck --full'
            }
        }
        stage('Build') {
            steps {
                sh '/home/kunalshiwarkar/Documents/Devops_software/tar/apache-maven-3.9.7/bin/mvn install'
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
    }
}
