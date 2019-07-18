node {
    
 notify('Started') 
 
   stage('Pull Git Latest Changes in the Repo') {
       
   git 'https://github.com/Ajaynano/DevOpsClassCodes.git'
 }
 
  stage('Clean old Packages') { 
    sh label: '', script: 'mvn clean'
  }
  
  stage('Package Build') {
   sh label: '', script: 'mvn package'
   }
   
   stage('Code Quality') {
   sh label: '', script: 'mvn verify'
   }
    
   stage('SonarQube analysis') {
    def mvnHome = tool name: 'mvn', type: 'maven'
    withSonarQubeEnv('sonarqube'){
    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.6.0.1398:sonar'
    }
   }

   
   stage('Parallel Jobs')
   parallel "Test Results Publish": {
   junit 'target/surefire-reports/TEST-*.xml'
   }
   
   stage('Deploy Atmosphere in stage - Docker Env') {
   sh label: '', script: 'docker-compose up -d --build'
   }
   
   stage('Archive Artifacts') {
   archiveArtifacts 'target/*.war'
       
   }
   
   notify('Completed') 
}

def notify(status){ 
    emailext(
        to: "ajaynano.ajay7@gmail.com",
        subject: "${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
        body: """<p>${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check Console output at <a href='${env.BUILD_URL}'> ${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>""",
        )   
}

