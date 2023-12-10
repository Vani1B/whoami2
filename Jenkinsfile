pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AKIA4OHZLZFFNGRJ5V4G')
        AWS_SECRET_ACCESS_KEY = credentials('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')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    #Give the location of terraform scripts directory relative 
                    #to the repo
                    dir('part2-cluster-from-terraform-and-jenkins/terraform-for-cluster') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    #Give the location of kubernetes scripts directory relative 
                    #to the repo
                    dir('part2-cluster-from-terraform-and-jenkins/kubernetes') {
                        sh "aws eks update-kubeconfig --name whoami-eks-cluster"
                        sh "kubectl apply -f deployment.yaml"
                        sh "kubectl apply -f service.yaml"
                    }
                }
            }
        }
    }
}
