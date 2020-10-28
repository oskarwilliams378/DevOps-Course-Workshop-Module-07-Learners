pipeline {
    agent {
        docker { image 'mocoding/dotnet-node:3.1-12.x-dev' }
    }

    environment {
        DOTNET_CLI_HOME = '/tmp/DOTNET_CLI_HOME'
    }

    stages {
        stage('Restore C#') {
            steps {
                sh 'dotnet restore'
            }
        }
        stage('Build C#') {
            steps {
                sh 'dotnet build'
            }
        }
        stage('Test C#') {
            steps {
                sh 'dotnet test'
            }
        }
        stage('Install npm') {
            steps {
                dir('DotnetTemplate.Web') {
                    sh 'sudo chown -R 1000:1000 "/.npm"'
                    sh 'npm install'
                }
            }
        }
        stage('Build npm') {
            steps {
                dir('DotnetTemplate.Web') {
                    sh 'npm run build'
                }
            }
        }
        stage('Run Lint') {
            steps {
                dir('DotnetTemplate.Web') {
                    sh 'npm run lint'
                }
            }
        }
        stage('Test typescript') {
            steps {
                dir('DotnetTemplate.Web') {
                    sh 'npm test'
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