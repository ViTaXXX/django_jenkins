pipeline {
    environment {
        LOGIN = 'USER_DOCKERHUB'
    }
    agent any
    stages {
        stage("Imagen") {
            agent {
                docker {
                    image "python:3"
                    args '-u root:root'
                }
            }
            stages {
                stage('repositorio') {
                    steps {
                        git branch: 'practica', url: 'https://github.com/ViTaXXX/django_jenkins.git'
                    }
                }
                stage('Requisitos') {
                    steps {
                        sh 'pip install -r django_tutorial/requirements_test.txt'
                    }
                }
                stage('Test') {
                    steps {
                        sh 'python manage.py test'
                    }
                }
            }
        }
        stage("Crear_la_imagen") {
            agent any
            stages {
                stage('Construir_imagen') {
                    steps {
                        script {
                            newApp = docker.build("andresdocker77/django_icdc:latest")
                        }
                    }
                }
                stage('Subirla') {
                    steps {
                        script {
                            docker.withRegistry('', LOGIN) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('Borrarla') {
                    steps {
                        sh "docker rmi andresdocker77/django_icdc:latest"
                    }
                }
            }
        }
    }
    post {
        always {
            mail to: 'andresfernandezds@gmail.com',
            subject: "Aviso jenkins: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
