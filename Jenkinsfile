pipeline{
    parameters {
  choice choices: ['master', 'develop', 'qa'], name: 'india'
}
    agent any
    stages{
        stage("git clone"){
            when{
                expression{
                    params.india == "master"
                }
            }
            steps{
                git url:"https://github.com/imadityavarma/prasad-multi-repo.git"
            }
        }
        stage("maven built"){
            when{
                expression{
                    params.india == "develop"
                }
            }
            steps{
                sh "mvn clean package -DskipTests=true"
            }
        }
        stage("tomcat9 deploy"){
            when{
                expression{
                    params.india == "qa"
                }
            }
            steps{
               sshagent(['5th sep']) {
            // copy tar file
            sh "scp -o StrictHostKeyChecking=no target/*.war ec2-user@172.31.90.204:/opt/tomcat9/webapps"
            // server shutdown
            sh "ssh ec2-user@172.31.90.204 /opt/tomcat9/bin/shutdown.sh"
            // server startup
            sh "ssh ec2-user@172.31.90.204 /opt/tomcat9/bin/startup.sh"
}
            }
        }
    }
}
