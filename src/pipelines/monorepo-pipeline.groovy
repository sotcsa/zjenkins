pipeline {
    agent any
    tools {
        jdk "openjdk15"
    }
    environment {
        REPO_URL = "https://github.com/sotcsa/zjenkins.git"
        REPO_DIR = "monorepo"
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    sh """
                        git clone $REPO_URL $REPO_DIR || \
                            (cd $REPO_DIR && git pull)
                    """
                }
            }
        }
        stage('Build') {
            steps {
                dir(REPO_DIR) {
                    script {
                        sh "mvn clean install -DskipTests"
                    }
                }
            }
        }
}