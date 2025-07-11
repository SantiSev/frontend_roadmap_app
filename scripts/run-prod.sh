#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW}⚙️ Starting production container...${NC}"

# Build prod image if not exists
if ! docker image inspect $CONTAINER_NAME >/dev/null 2>&1; then
  echo -e "${YELLOW} Building production image...${NC}"
  ./scripts/run-build || handle_error "Build failed"
fi

# Stop and remove existing container
if docker ps --filter "name=$CONTAINER_NAME" --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
  echo -e "${YELLOW} Stopping existing production container...${NC}"
  docker stop $CONTAINER_NAME >/dev/null
fi

# Run production container
docker run -d \
  --name $CONTAINER_NAME \
  -p $PROD_PORT:80 \
  $CONTAINER_NAME && {
    echo -e "${GREEN} Production container running at http://localhost${NC}"
    echo -e "${YELLOW}ℹ  To stop: docker stop $CONTAINER_NAME${NC}"
  } || {
    echo -e "${RED} Failed to start production container${NC}"
    exit 1
  }
