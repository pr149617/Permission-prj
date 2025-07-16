pipeline {
    agent any

    environment {
        PROJECT_ID = 'canvas-primacy-466005-f9'     // 🔁 Replace this with your GCP project ID
        SECRET_NAME = 'terraformsvckey'           // 🔁 Replace with the actual GCP secret name
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Authenticate Jenkins to GCP') {
            steps {
                withCredentials([file(credentialsId: 'jenkinssvckey', variable: 'JENKINS_GCP_KEY')]) {
                    bat '''
                        gcloud auth activate-service-account --key-file=%JENKINS_GCP_KEY%
                        gcloud config set project %PROJECT_ID%
                        echo Authenticated Jenkins to GCP
                    '''
                }
            }
        }

        stage('Fetch Terraform SA Key from Secret Manager') {
            steps {
                bat '''
                    gcloud secrets versions access latest --secret=%SECRET_NAME% > terraform-sa.json
                    echo Fetched terraform-sa.json from GCP Secret Manager
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                bat '''
                    set GOOGLE_APPLICATION_CREDENTIALS=terraform-sa.json
                    terraform init
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                bat '''
                    set GOOGLE_APPLICATION_CREDENTIALS=terraform-sa.json
                    terraform plan -out=tfplan.out
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Apply Terraform changes?"
                bat '''
                    set GOOGLE_APPLICATION_CREDENTIALS=terraform-sa.json
                    terraform apply -auto-approve tfplan.out
                '''
            }
        }
    }

    post {
        always {
            bat 'del terraform-sa.json'
        }
    }
}
