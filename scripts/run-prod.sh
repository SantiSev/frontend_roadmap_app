#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW} Starting production enviorment server with ...${NC}"


echo -e "${YELLOW} Building prod image...${NC}"
docker build -f Dockerfile -t $PROD_IMAGE . || handle_error "Build failed"


echo -e "${YELLOW} Launching prod server...${NC}"
docker run -d \
  --name $PROD_CONTAINER \
  -p 8080:8080 \
  $PROD_IMAGE || handle_error "Failed to start prod server"

echo -e "${GREEN} Prod server running at http://localhost:8080${NC}"

# Trap Ctrl+C to stop and remove the container
trap 'echo -e "\n${YELLOW}Stopping and removing $PROD_CONTAINER...${NC}"; docker stop $PROD_CONTAINER >/dev/null; docker rm $PROD_CONTAINER >/dev/null; exit 0' INT

docker logs -f $PROD_CONTAINER