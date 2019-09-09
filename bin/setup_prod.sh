#!/bin/bash
# Setup Production Project (initial active services: Green)
if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "  $0 GUID"
    exit 1
fi

GUID=$1
echo "Setting up Tasks Production Environment in project ${GUID}-tasks-prod"

# Set up Production Project
oc policy add-role-to-group system:image-puller system:serviceaccounts:${GUID}-tasks-prod -n ${GUID}-tasks-dev
oc policy add-role-to-user edit system:serviceaccount:${GUID}-jenkins:jenkins -n ${GUID}-tasks-prod

# Set up Blue Application
oc apply -f manifests/tasks-cm-blue.yaml -n ${GUID}-tasks-prod
oc apply -f manifests/tasks-dc-blue.yaml -n ${GUID}-tasks-prod
oc apply -f manifests/tasks-svc-blue.yaml -n ${GUID}-tasks-prod

# Set up Green Application
oc apply -f manifests/tasks-cm-green.yaml -n ${GUID}-tasks-prod
oc apply -f manifests/tasks-dc-green.yaml -n ${GUID}-tasks-prod
oc apply -f manifests/tasks-svc-green.yaml -n ${GUID}-tasks-prod

# Expose Green service as route -> Force Green -> Blue deployment on first run
oc apply -f manifests/tasks-route-prod.yaml -n ${GUID}-tasks-prod
