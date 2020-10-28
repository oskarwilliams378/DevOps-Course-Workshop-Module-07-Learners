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
            stages{
                stage('Checkout') {
                    steps {
                        checkout scm
                    }
                }
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
            agent {
                docker { image 'node:14-alpine' }
            }
            stages{
                stage('Checkout') {
                    steps {
                        checkout scm
                    }
                }
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
}