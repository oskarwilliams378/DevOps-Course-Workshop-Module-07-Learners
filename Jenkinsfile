pipeline {
    agent {
        docker { image 'mocoding/dotnet-node:3.1-12.x-prod' }
    }

    environment {
        DOTNET_CLI_HOME = '/tmp/DOTNET_CLI_HOME'
    }

    stages {
        stage('Build and test C#') {
            stages{
                stage('Restore') {
                    steps {
                        sh 'dotnet restore'
                    }
                }
                stage('Build') {
                    steps {
                        sh 'dotnet build'
                    }
                }
                stage('Test') {
                    steps {
                        sh 'dotnet test'
                    }
                }
            }
        }
        stage('Build and test npm') {
            stages{
                stage('Install') {
                    steps {
                        dir('DotnetTemplate.Web') {
                            sh 'npm install'
                        }
                    }
                }
                stage('Build') {
                    steps {
                        dir('DotnetTemplate.Web') {
                            sh 'npm run build'
                        }
                    }
                }
                stage('Lint') {
                    steps {
                        dir('DotnetTemplate.Web') {
                            sh 'npm run lint'
                        }
                    }
                }
                stage('Test') {
                    steps {
                        dir('DotnetTemplate.Web') {
                            sh 'npm test'
                        }
                    }
                }
            }
        }
    }
    post { 
        success { 
            slackSend (color: '#00FF00', message: "Succeeded: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        failure { 
            slackSend (color: '#FF0000', message: "Failed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        aborted { 
            slackSend (color: '#0000FF', message: "Aborted: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }
}