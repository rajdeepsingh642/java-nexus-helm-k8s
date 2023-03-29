
pipeline{
    
    agent any 
    tools {
            maven 'mymaven'
        }
    
    stages {
        
        
        stage('Git Checkout'){
            
            steps{
                
               git branch: 'rajdeep', url: 'https://github.com/rajdeepsingh642/java-test.git'
                    
                    
                }
            }
        
        

         stage('build image'){
            steps{
                sh 'docker build -t 192.168.1.228:8083/springboot:$BUILD_ID .'

            }
       }

        stage('push to nexus'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'nexus-token', variable: 'nexus_token')]) {
                   sh "docker login -u admin -p $nexus_token 192.168.1.228:8083"
                   sh "docker push 192.168.1.228:8083/springboot:$BUILD_ID"
                   sh "docker rmi 192.168.1.228:8083/springboot:$BUILD_ID"
                    }
                }
            }
        }
        
         
        stage('pushin helm chart to nexus'){
           steps{
               script{
                   withCredentials([string(credentialsId: 'nexus-token', variable: 'nexus_token')]) {

                    dir(' helm/') {
                    
                     sh '''
                     helmversion=$(helm show chart singh | grep version | cut -d: -f 2 | tr -d ' ')
                     tar -cvzf singh-${helmversion}.tgz singh/
                     curl -u admin:${nexus_token} http://192.168.1.228:8081/repository/helm-hosted/ --upload-file singh-${helmversion}.tgz -v
                       '''     
                     }
                  } 
               }
           }
        
        }

      

    }
}  

