terraform {
  backend "s3" {
    bucket = "dev-proj-1-jenkins-remote-state-bucket-miguel-eu-central"
    key    = "devops-project-1/jenkins/terraform.tfstate"
    region = "eu-central-1"
  }
}