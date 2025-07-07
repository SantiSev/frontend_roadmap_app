#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW}⚙️ Starting development server...${NC}"

# Check if container is already running
if [ "$(docker ps -q -f name=${DEV_SERVICE})" ]; then
  echo -e "${GREEN}✅ Dev server already running at http://localhost:$DEV_PORT${NC}"
  exit 0
fi

# Only build if the image does not exist or source files changed
if [ -z "$(docker images -q ${DEV_IMAGE})" ]; then
  echo -e "${YELLOW}📦 Building image ${DEV_IMAGE}...${NC}"
  docker compose build $DEV_SERVICE || handle_error "Build failed"
fi

# Start the container
echo -e "${YELLOW}🚀 Launching dev server...${NC}"
docker compose up $DEV_SERVICE || handle_error "Failed to start dev server"

echo -e "${GREEN}✅ Dev server running at http://localhost:$DEV_PORT${NC}"
