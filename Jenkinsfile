pipeline {
    agent any
    
    environment {
        APP_DIR='/var/lib/jenkins/workspace/my-jenkins/demo-jenkins'
        JAR_FILE='myapp-0.0.1-SNAPSHOT.jar'
    }

    stages {
        stage('Clean Workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Cloning Git Repo') {
            steps {
                script {
                    sh 'git clone "https://github.com/SravyaPola/demo-jenkins.git"'
                }
            }
        }
        stage('Build Application') {
            steps {
                script {
                    sh 'cd demo-jenkins && mvn clean install'
                }
            }
        }
        stage('Run Application') {
            steps {
                script {
                    sh 'cd $APP_DIR/target && java -jar $JAR_FILE'
                }
            }
        }
    }
}
