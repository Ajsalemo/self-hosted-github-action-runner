#!/bin/bash

# Create the job
az containerapp job create -n "$JOB_NAME" -g "$RESOURCE_GROUP" --environment "$ENVIRONMENT" \
    --trigger-type Event \
    --replica-timeout 1800 \
    --replica-retry-limit 1 \
    --replica-completion-count 1 \
    --parallelism 1 \
    --image "$CONTAINER_REGISTRY_NAME.azurecr.io/$CONTAINER_IMAGE_NAME" \
    --min-executions 0 \
    --max-executions 10 \
    --polling-interval 30 \
    --scale-rule-name "github-runner" \
    --scale-rule-type "github-runner" \
    --scale-rule-metadata "github-runner=https://api.github.com" "owner=$REPO_OWNER" "runnerScope=repo" "repos=$REPO_NAME" "targetWorkflowQueueLength=1" \
    --scale-rule-auth "personalAccessToken=personal-access-token" \
    --cpu "2.0" \
    --memory "4Gi" \
    --secrets "personal-access-token=$GITHUB_PAT" \
    --env-vars "GITHUB_PAT=secretref:personal-access-token" "REPO_URL=https://github.com/$REPO_OWNER/$REPO_NAME" "REGISTRATION_TOKEN_API_URL=https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runners/registration-token" \
    --registry-server "$CONTAINER_REGISTRY_NAME.azurecr.io"

# Get the current job status
az containerapp job execution list \
    --name "$JOB_NAME" \
    --resource-group "$RESOURCE_GROUP" \
    --output table \
    --query '[].{Status: properties.status, Name: name, StartTime: properties.startTime}'

# Create a Service Principal
az ad sp create-for-rbac --name some-aca-gh-runner-job --role contributor --scopes "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/some-rg" --sdk-auth --output json