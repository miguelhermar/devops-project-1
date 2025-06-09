pipeline {
    agent any // Run this pipeline on any available Jenkins agent (could be a Docker container, EC2, Jenkins server, etc.).

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clean workspace before cloning (optional)
                deleteDir()

                // Clone the Git repository
                git branch: 'main',
                    url: 'https://github.com/miguelhermar/devops-project-1.git'

                sh "ls -lart" // Lists directory contents so you can verify it worked.
            }
        }

        stage('Terraform Init') {
                    steps {
                        // This securely injects AWS credentials into the shell environment so terraform can authenticate with AWS.
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentails-miguel']]){
                            dir('infra') {
                            sh 'echo "=================Terraform Init=================="'
                            sh 'terraform init'
                        }
                    }
                }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentails-miguel']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Plan=================="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        // 	Only runs if the APPLY_TERRAFORM box is ticked.

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentails-miguel']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Apply=================="'
                                sh 'terraform apply --auto-approve'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentails-miguel']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Destroy=================="'
                                sh 'terraform destroy --auto-approve'
                            }
                        }
                    }
                }
            }
        }
    }
}
