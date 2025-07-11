#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW} Starting development server...${NC}"


# Check if dev container is already running
if docker ps --filter "name=$DEV_CONTAINER" --format '{{.Names}}' | grep -q "^$DEV_CONTAINER$"; then
  echo -e "${GREEN} Dev server already running at http://localhost:$DEV_PORT${NC}"
  trap 'echo -e "\n${YELLOW}Stopping and removing $DEV_CONTAINER...${NC}"; docker stop $DEV_CONTAINER >/dev/null; docker rm $DEV_CONTAINER >/dev/null; exit 0' INT
  docker logs -f $DEV_CONTAINER
  exit 0
fi

# Remove stopped container with the same name if it exists
if docker ps -a --filter "name=$DEV_CONTAINER" --format '{{.Names}}' | grep -q "^$DEV_CONTAINER$"; then
  echo -e "${YELLOW} Removing old stopped container $DEV_CONTAINER...${NC}"
  docker rm $DEV_CONTAINER || handle_error "Failed to remove old dev container"
fi

# Build dev image if missing
if ! docker image inspect $DEV_IMAGE >/dev/null 2>&1; then
  echo -e "${YELLOW} Building dev image...${NC}"
  docker build -f Dockerfile.dev -t $DEV_IMAGE . || handle_error "Build failed"
fi

# Run container with volume mounting and hot reload support
echo -e "${YELLOW} Launching dev server...${NC}"
docker run -d \
  --name $DEV_CONTAINER \
  -v $(pwd):/app \
  -v /app/node_modules \
  -p $DEV_PORT:$DEV_PORT \
  $DEV_IMAGE || handle_error "Failed to start dev server"

echo -e "${GREEN} Dev server running at http://localhost:$DEV_PORT${NC}"
docker logs -f $DEV_CONTAINER
