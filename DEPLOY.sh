#!/bin/bash
source .env

source ./scripts/common.sh

echo -e "${YELLOW} Deploying Roadmap Front...${NC}"
echo -e "${RED} WARNING: You must be part of the google cloud run project to de able to run this script, in case of error contact the project admin $1${NC}"
echo -e "${RED} WARNING: Make sure to run this script in the root of the project$1${NC}"


gcloud run deploy $GCP_SERVICE \
  --project=$GCP_PROJECT \
  --region=$GCP_REGION \
  --source . 2>&1 || handle_error "Failed to deploy to Google Cloud Run"

echo -e "${GREEN} Deployment Complete!${NC}"