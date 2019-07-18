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
    def scannerHome = tool 'SonarScanner 4.0';
    withSonarQubeEnv('sonar-runner') { // If you have configured more than one global server connection, you can specify its name
      sh "${scannerHome}/bin/sonar-scanner"
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

