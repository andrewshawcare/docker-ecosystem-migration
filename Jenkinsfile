node {
  git(
    credentialsId: env.GIT_CREDENTIALS_ID,
    url: 'https://github.com/andrewshawcare/docker-ecosystem-migration.git',
    poll: true
  )

  env.IMAGE_NAME = env.JOB_NAME
  env.IMAGE_TAG = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
  env.SERVICE_NAME = env.IMAGE_NAME

  stage('build') {
    sh "docker build --tag \"${REGISTRY_HOST}/${IMAGE_NAME}:${IMAGE_TAG}\" ."
    sh "docker push \"${REGISTRY_HOST}/${IMAGE_NAME}:${IMAGE_TAG}\""
  }
  stage('test') {
    sh 'docker-compose pull'
    sh "docker-compose run --rm \"${SERVICE_NAME}\" test"
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
