node{
   
    stage('Scm Checkout'){
     git branch: 'main', credentialsId: 'git_hub', url: 'https://github.com/manoranjanmajumdar/jenkinsprojectfile.git'
    }
    stage('Mvn Package'){
     def mvnHome = tool name: 'maven-3', type: 'maven'
     def mvnCMD = "${mvnHome}/bin/mvn"
     sh "${mvnCMD} clean package"
    }
    
    stage('Build Docker Image'){
     sh 'docker build -t manoranjanmajumdar/locuz:8.0.0 .'
    }
    stage('Push Docker Image'){
     withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
     sh "docker login -u manoranjanmajumdar -p ${dockerHubPwd}"
    }
     sh 'docker push manoranjanmajumdar/locuz:8.0.0'
   }
   stage('deploy'){
     sshagent(['dev-server']){
     sh "ssh -o StrictHostKeyChecking=no root@54.90.50.221 'whoami'"
     sh "ssh -o StrictHostKeyChecking=no root@54.90.50.221 'sudo yum update -y'"
     sh "ssh -o StrictHostKeyChecking=no root@54.90.50.221 'ls -l'"
     sh "ssh -o StrictHostKeyChecking=no root@54.90.50.221 'docker pull manoranjanmajumdar/locuz:8.0.0'"
     sh "ssh -o StrictHostKeyChecking=no root@54.90.50.221 'docker run -d --net=host -p 80:8080 --name=cymune manoranjanmajumdar/locuz:8.0.0'"
            
        }
    }
}
