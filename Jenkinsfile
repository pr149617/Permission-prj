pipeline {
    agent any

    environment {
        PROJECT_ID = 'canvas-primacy-466005-f9'  // Replace with your GCP project ID
        SECRET_NAME = 'terraformsvckey'        // Name of the secret in GCP
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
                    sh '''
                        gcloud auth activate-service-account --key-file=$JENKINS_GCP_KEY
                        gcloud config set project $PROJECT_ID
                        echo "Jenkins authenticated to GCP using jenkinssvc key"
                    '''
                }
            }
        }

        stage('Fetch Terraform SA Key from Secret Manager') {
            steps {
                sh '''
                    gcloud secrets versions access latest --secret=$SECRET_NAME > terraform-sa.json
                    export GOOGLE_APPLICATION_CREDENTIALS=terraform-sa.json
                    echo "Fetched terraform service account key from Secret Manager"
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                    export GOOGLE_APPLICATION_CREDENTIALS=terraform-sa.json
                    terraform init
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                    export GOOGLE_APPLICATION_CREDENTIALS=terraform-sa.json
                    terraform plan -out=tfplan.out
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Apply Terraform changes?"
                sh '''
                    export GOOGLE_APPLICATION_CREDENTIALS=terraform-sa.json
                    terraform apply -auto-approve tfplan.out
                '''
            }
        }
    }

    post {
        always {
            sh 'rm -f terraform-sa.json'
        }
    }
}
