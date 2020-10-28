pipeline {
    agent none

    environment {
        DOTNET_CLI_HOME = '/tmp/DOTNET_CLI_HOME'
    }

    stages {
        stage('Build and test C#') {
            agent {
                docker { image 'mcr.microsoft.com/dotnet/core/sdk:3.1' }
            }
            steps {
                checkout scm
                sh 'dotnet restore'
                sh 'dotnet build'
                sh 'dotnet test'
            }
        }
        stage('Build and test npm') {
            agent {
                docker { image 'node:14-alpine' }
            }
            steps {
                checkout scm
                sh 'cd DotnetTemplate.Web'
                sh 'npm install'
                sh 'npm run build'
                sh 'npm run lint'
                sh 'npm test'
            }
        }
    }
}