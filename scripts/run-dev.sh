#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW}➜ Removing any existing dev container...${NC}"
docker rm -f $DEV_CONTAINER 2>/dev/null || true

# Build the development image
echo -e "${YELLOW}➜ Building development image...${NC}"
docker build -t $DEV_IMAGE -f Dockerfile.dev . || handle_error "Failed to build Docker image"

# Run the container with colorful output
echo -e "${YELLOW}➜ Starting development container...${NC}"
docker run -it --rm \
  -p 8080:8080 \
  -v "$(pwd):/app" \
  -v /app/node_modules \
  --name $DEV_CONTAINER \
  $DEV_IMAGE

# Success message (only shown if container exits cleanly)
echo -e "${GREEN}✔ Development container stopped${NC}"