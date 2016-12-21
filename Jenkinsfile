node {
  git credentialsId: '11d1f04e-b933-4f33-8545-4c989449c859', url: 'https://github.com/andrewshawcare/docker-ecosystem-migration.git'

  env.REGISTRY_HOST = 'localhost:5000'
  env.IMAGE_NAME = env.JOB_NAME
  env.IMAGE_TAG = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()

  stage('build') {
    sh "docker build --tag \"${REGISTRY_HOST}/${IMAGE_NAME}:${IMAGE_TAG}\" ."
    sh "docker push \"${REGISTRY_HOST}/${IMAGE_NAME}:${IMAGE_TAG}\""
  }
  stage('test') {
    sh 'docker-compose pull'
    sh "docker-compose run --rm \"${REGISTRY_HOST}/${IMAGE_NAME}:${IMAGE_TAG}\" test"
  }
  stage('push') {
    sh "docker tag \"${REGISTRY_HOST}/${IMAGE_NAME}:${IMAGE_TAG}\" \"${REGISTRY_HOST}/${IMAGE_NAME}:latest\""
    sh "docker push \"${REGISTRY_HOST}/${IMAGE_NAME}:latest\""
  }
  stage('deploy') {
    sh 'docker-compose pull'
    sh 'docker-compose up -d'
  }
}
