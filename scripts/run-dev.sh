#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW}Starting development server...${NC}"

# Clean only if container exists
if [ "$(docker ps -aq -f name=${DEV_SERVICE})" ]; then
  docker compose stop $DEV_SERVICE || handle_error "Failed to stop dev container"
fi

# Build and start
docker compose build $DEV_SERVICE || handle_error "Build failed"
docker compose up $DEV_SERVICE || handle_error "Failed to start dev server"

echo -e "${GREEN}✅ Dev server running at http://localhost:$DEV_PORT${NC}"