#!/bin/bash
# Setup Jenkins Project
if [ "$#" -ne 5 ]; then
    echo "Usage:"
    echo "  $0 GUID REPO CLUSTER USER PASSWORD"
    echo "  Example: $0 wkha https://github.com/redhat-gpte-devopsautomation/advdev_homework_template.git shared.na.openshift.opentlc.com wkulhane-redhat.com secret-password"
    exit 1
fi

GUID=$1
REPO=$2
CLUSTER=$3
USER=$4
PASSWORD=$5
echo "Setting up Jenkins in project ${GUID}-jenkins from Git Repo ${REPO} and user ${USER} for Cluster ${CLUSTER}"

# Set up Jenkins with sufficient resources
# TBD

# Create custom agent container image with skopeo
# TBD

# Create Secret with credentials to access the private repository
# TBD

# Create pipeline build config pointing to the ${REPO} with contextDir `openshift-tasks`
# TBD

# Make sure that Jenkins is fully up and running before proceeding!
while : ; do
  echo "Checking if Jenkins is Ready..."
  AVAILABLE_REPLICAS=$(oc get dc jenkins -n ${GUID}-jenkins -o=jsonpath='{.status.availableReplicas}')
  if [[ "$AVAILABLE_REPLICAS" == "1" ]]; then
    echo "...Yes. Jenkins is ready."
    break
  fi
  echo "...no. Sleeping 10 seconds."
  sleep 10
done