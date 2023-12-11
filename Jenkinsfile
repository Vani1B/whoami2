pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = 'AKIA3ZLZ7WJMF7OWEA5H'
        AWS_SECRET_ACCESS_KEY = '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'
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Clone Git Repository') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], gitTool: 'Default', userRemoteConfigs: [[url: 'https://github.com/Vani1B/whoami2.git']])
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh "docker build -t whoami -f /var/lib/jenkins/workspace/project1/Dockerfile ."
                    sh "eval $(aws ecr get-login --no-include-email --region us-east-1)"
                    sh "docker tag whoami:latest 810394038872.dkr.ecr.us-east-1.amazonaws.com/my-docker-repo:latest"
                    sh "docker push 810394038872.dkr.ecr.us-east-1.amazonaws.com/my-docker-repo:latest"
                }
            }
        }
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
