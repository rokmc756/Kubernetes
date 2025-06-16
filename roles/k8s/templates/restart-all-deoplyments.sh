#!/bin/bash

# Execute
# for i in `kubectl get ns | sed 1d | awk '{print $1}'`; do sh restart-all-deployments.sh $i ;done


# Define the namespace
NAMESPACE="$1"

# Get a list of deployments in the specified namespace
DEPLOYMENTS=$(kubectl get deployments -n $NAMESPACE -o=jsonpath='{.items[*].metadata.name}')

# Iterate through the deployments and trigger a rollout restart
for DEPLOYMENT in $DEPLOYMENTS; do
    echo "Rolling out restart for deployment: $DEPLOYMENT"
    kubectl rollout restart deployment $DEPLOYMENT -n $NAMESPACE

    # Wait for the rollout to complete
    while ! kubectl rollout status deployment $DEPLOYMENT -n $NAMESPACE | grep "successfully rolled out"; do
        echo "Waiting for rollout of $DEPLOYMENT to complete..."
        sleep 5
    done

    echo "Rollout for $DEPLOYMENT completed"
done

