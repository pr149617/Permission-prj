pipeline {
    agent any

    environment {
        PROJECT_ID = 'canvas-primacy-466005-f9'      // Your GCP project ID
        SECRET_NAME = 'terraformsvckey'              // Name of secret in Secret Manager
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
                        call gcloud auth activate-service-account --key-file=%JENKINS_GCP_KEY%
                        call gcloud config set project canvas-primacy-466005-f9
                        echo Authenticated Jenkins to GCP
                    '''
                }
            }
        }

        stage('Fetch Terraform SA Key from Secret Manager') {
            steps {
                bat '''
                    call gcloud secrets versions access latest --secret=terraformsvckey --project=canvas-primacy-466005-f9 > terraform-sa.json
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
