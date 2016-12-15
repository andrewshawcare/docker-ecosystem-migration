node {
  env.REGISTRY_HOST = 'registry:5000'
  env.IMAGE_NAME = env.JOB_NAME
  env.IMAGE_TAG = env.GIT_COMMIT

  stage('build') {
    sh "docker build --tag \"${REGISTRY_HOST}/${IMAGE_NAME}:${IMAGE_TAG}\" ."
    sh "docker push \"${REGISTRY_HOST}/${IMAGE_NAME}:${IMAGE_TAG}\""
  }
  stage('test') {
    sh 'docker-compose pull'
    sh 'docker-compose run --rm test'
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