pipeline {
    agent {
        node {
            label 'dockerhost-build-server'
        }
    }
    tools {
        // Se usa 'maven' (debes haberlo configurado en Manage Jenkins -> Tools con ese nombre)
        maven 'maven'
    }
    stages {
        stage('Packaging') {
            steps {
                echo 'Packaging..'
                sh 'mvn clean package'
            }
        }
        stage('Copying file') {
            steps {
                echo 'Copying artifact..'
                // Usamos cp para que sea más seguro y soporte .war o .jar
                sh 'cp target/*.?ar .'
            }
        }
        stage('cleanup') {
            steps {
                echo 'Cleaning up old containers..'
                // Borra el contenedor anterior si existe para evitar errores de nombre duplicado
                sh 'docker rm -f devops-web-project-server || true'
                sh 'docker system prune -f --filter "label=devops-web-project-server"'
            }
        }
        stage('build image') {
            steps {
                echo 'Building Docker image..'
                sh 'docker build -t davids884/devops-web-project:v1 --label devops-web-project-server .'
            }
        }
        stage('run container') {
            steps {
                echo 'Running container..'
                // Mapeamos al puerto 8081 para que no choque con el Tomcat que ya tienes en el 8080
                sh 'docker run -d --name devops-web-project-server --label devops-web-project-server -p 8081:8080 davids884/devops-web-project:v1'
            }
        }
    }
}
