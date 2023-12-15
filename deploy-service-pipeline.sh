#! /bin/sh
# This script installs all prerequisites for cmdb service deployment pipeline
# Pre-requisites
# - aws secrets in kubernetes
# - kaniko secret for docker push

SERIVCENAME=common-workflow
NAMESPACE=tekton-pipelines

echo Name of the Service: ${SERIVCENAME}
echo Namespace: ${NAMESPACE}

if kubectl get ns ${NAMESPACE} ; then
    echo ${NAMESPACE} namespace exists
else
    echo Creating ${NAMESPACE}
    kubectl create ns ${NAMESPACE}
fi

if kubectl -n ${NAMESPACE} get task git-clone ; then
    echo git-clone task exists
else    
    echo exit.., required task git-clone not present
    exit 1
fi

if kubectl -n ${NAMESPACE} get task build-kaniko ; then
    echo build-kaniko task exists
else    
    echo exit.., required task build-kaniko not present
    exit 1
fi

# echo Add common-workflow specific tasks
# kubectl apply -f tasks/common-workflow-install.yaml
# echo Add the pipeline
# kubectl apply -f pipelinerun/common-workflow-service-deployment.yaml