node{
    stage('Scm Checkout'){
     git branch: 'main', credentialsId: 'git_hub', url: 'https://github.com/manoranjanmajumdar/probike.git'
    }
    stage('Mvn Package'){
     def mvnHome = tool name: 'maven-3', type: 'maven'
     def mvnCMD = "${mvnHome}/bin/mvn"
     sh "${mvnCMD} clean package"
    }
     stage('Build Docker Image'){
     sh 'docker build -t manoranjanmajumdar/cymune:6.0.0 .'
    }
    stage('Push Docker Image'){
     withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
     sh "docker login -u manoranjanmajumdar -p ${dockerHubPwd}"
    }
     sh 'docker push manoranjanmajumdar/cymune:6.0.0'
    }
    stage('deploy'){
     sshagent(['dev-server']){
     sh "ssh -o StrictHostKeyChecking=no root@100.26.174.247 'whoami'"
     sh "ssh -o StrictHostKeyChecking=no root@100.26.174.247 'sudo yum update -y'"
     sh "ssh -o StrictHostKeyChecking=no root@100.26.174.247 'ls -l'"
     sh "ssh -o StrictHostKeyChecking=no root@100.26.174.247 'docker pull manoranjanmajumdar/cymune:6.0.0'"
     sh "ssh -o StrictHostKeyChecking=no root@100.26.174.247 'docker run -d -p 8000:8000 --name=majumdar manoranjanmajumdar/cymune:6.0.0'"
            
        }
    }
}
