pipeline {
    agent {
        docker {
            image 'python'
        }
    }

    stages {
        stage('Build') {
            steps {
                echo 'Baixando as dependências do projeto'
                pip install -r requirements.txt
            }
        }
        stage('Test') {
            steps {
                echo 'Executando testes de regressão'
                sh 'robot -d ./log tests/'
            }
        }
        stage('UAT') {
            steps {
                echo 'Aprovação dos testes de aceitação'
            }
        }
        stage('Production') {
            steps {
                echo 'API OK em produção!'
            }
        }
    }
}