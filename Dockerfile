def call (ip)
@Library("liger-fighter") _
pipeline{
    agent any
    stages{
        stage("git"){
            steps{
                git url:"https://github.com/imadityavarma/my-app"
            }
        }
        stage("maven"){
            steps{
                sh "mvn clean package -DskipTests=true"
            }
        }
        stage("maven"){
            steps{
                sshagent(['pipeline-cred']) {
                 // copy war
                 sh "scp target/*.war ec2-user@${}:/opt/tomcat9/webapps"
                 // stop
                 sh "ssh ec2-user@${ip} /opt/tomcat9/bin/shutdown.sh"
                 // start
                 sh "ssh ec2-user@${ip} /opt/tomcat9/bin/startup.sh"
                 
}
            }
        }
    }
}
