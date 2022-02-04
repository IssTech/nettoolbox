pipeline {
 agent {
  kubernetes {
    label "nettoolbox-${UUID.randomUUID().toString()}"
    yaml '''
      apiVersion: v1
      kind: Pod
      metadata:
      labels:
        component: ci
      spec:
        containers:
        - name: jnlp
          image: jenkins/inbound-agent:4.11-1
        - name: kaniko
          image: gcr.io/kaniko-project/executor:debug
          imagePullPolicy: IfNotPresent
          command:
          - sleep
          args:
          - 999999
          volumeMounts:
          - name: kaniko-secret
            mountPath: /kaniko/.docker
          - name: workspace-volume
            mountPath: /home/jenkins/kaniko
            readOnly: false
        restartPolicy: Never
        dnsConfig:
          options:
          - name: ndots
            value: "1"
        volumes:
        - name: kaniko-secret
          secret:
              secretName: dockercred
              items:
              - key: .dockerconfigjson
                path: config.json
        - emptyDir:
            medium: ""
          name: "workspace-volume"
      '''
    }
  }

 environment {
    DOCKER_ORGANIZATION_NAME = "isstech"
    SERVICE_NAME = "nettoolbox"
    GIT_ORGANIZATION_NAME = "IssTech"
    DOCKER_REGISTRY = "$DOCKER_ORGANIZATION_NAME/$SERVICE_NAME"
    NAMESPACE = "nettoolbox"
    ANNOTATIONS = "kubernetes.io/ingress.class: traefik"
 }

 stages {

  stage('Build and Push main image to Docker Hub') {
    when { branch 'main' }
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor --context git://github.com/$DOCKER_REGISTRY.git#refs/heads/$GIT_BRANCH --destination $DOCKER_REGISTRY:$GIT_TAG --destination $DOCKER_REGISTRY:latest
          '''
        }
      }
  }

  stage('Build and Push image to Docker Hub') {
    when { not { branch 'main' } }
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor --context git://github.com/$DOCKER_REGISTRY.git#refs/heads/$GIT_BRANCH --destination $DOCKER_REGISTRY:$GIT_BRANCH
          '''
        }
      }
  }
 }
}
