pipeline {
  agent any
    tools { 
        maven 'maven' 
    }
  environment {    
    registryCredentials = "nexus3"
    AWS_ACCESS_KEY_ID     = credentials('aws-cred')
    AWS_SECRET_ACCESS_KEY = credentials('aws-cred')
  }

 stages {
 
    stage('git Clone') {
      steps {
        echo 'Getting Project from Git'
        git branch: "main", url: 'https://github.com/olasalah73/project-ops.git'
      }
    }
    stage('mvn clean') {
      steps {
        echo 'Maven Clean'
        sh 'mvn clean install'
      }
    }
   stage('junit test') {
      steps {
        echo 'Maven Test JUnit'
        sh 'mvn test'
      }
    }

    stage ('test sonar') {
    	steps {
	   withSonarQubeEnv('sonar') {
	    sh """
          mvn sonar:sonar
	        cat target/sonar/report-task.txt
        """
        }
      }
    }
	 
    stage('mvn package') {
      steps {
        echo 'Maven Packaging'
        sh 'mvn package -Dmaven.test.skip=true'
      }
    }   

    stage('Push Docker Images to Nexus Registry'){
	  steps{	
            sh """
              docker login  -u admin -p ola1 54.173.143.147:8082
              docker build -t java:latest .
              docker tag java:latest 54.173.143.147:8082/java:latest
              docker push 54.173.143.147:8082/java:latest
            """
          }
        }
    
    stage('deploy to eks') {
       steps {
        script {
    withCredentials([
       file(credentialsId: 'kubeconfig', variable: 'kubeconfig') ]) 
	     {
                sh """ 
                     aws eks --region us-east-1 update-kubeconfig --name terraform-eks-demo
		     kubectl apply -f java-pod.yml --kubeconfig=$kubeconfig
                     kubectl apply -f  java-app-deploy.yml --kubeconfig=$kubeconfig
                     kubectl apply -f  java-app-svc.yml --kubeconfig=$kubeconfig
                     echo "done ya lolo"
                     """
	       } 
            }
          }    
       }            
    }
}
