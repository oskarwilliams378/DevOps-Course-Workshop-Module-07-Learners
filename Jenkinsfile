pipeline {
    agent none
    stages {
        stage('Build and test C#') {
            agent {
                docker { image 'mcr.microsoft.com/dotnet/core/sdk:3.1' }
            }
            steps {
                checkout scm
                dotnet restore
                dotnet build
                dotnet test
            }
        }
        stage('Build and test npm') {
            agent {
                docker { image 'node:14-alpine' }
            }
            steps {
                checkout scm
                cd DotnetTemplate.Web
                npm install
                npm run build
                npm run lint
                npm test
            }
        }
    }
}