pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AKIA4OHZLZFFLQMPWWUR')
        AWS_SECRET_ACCESS_KEY = credentials('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')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
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
