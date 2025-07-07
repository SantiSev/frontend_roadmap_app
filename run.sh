#!/bin/bash

# Configuration
CONTAINER_NAME="roadmap_front"
DEV_SERVICE="dev"
PROD_PORT=80
DEV_PORT=5173

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Reset everything (containers, volumes, build cache)
reset_environment() {
  echo -e "${YELLOW}Resetting Docker environment...${NC}"
  
  # Stop and remove all containers
  docker compose down -v --remove-orphans
  
  # Remove all unused images, networks, and build cache
  docker system prune -af
  
  # Remove specific production image if exists
  if docker image inspect $CONTAINER_NAME >/dev/null 2>&1; then
    docker rmi -f $CONTAINER_NAME
  fi
  
  echo -e "${GREEN}✅ Environment reset complete${NC}"
}

# Development mode with hot reload
run_dev() {
  echo -e "${YELLOW}Starting development server with hot reload...${NC}"
  
  # Only remove containers if they exist
  if [ "$(docker ps -aq -f name=roadmap_front-dev)" ]; then
    docker compose stop $DEV_SERVICE
  fi
  
  # Build with cache (remove --no-cache) and start
  if docker compose build $DEV_SERVICE && docker compose up $DEV_SERVICE; then
    echo -e "${GREEN}✅ Dev server running at http://localhost:$DEV_PORT${NC}"
    echo -e "${YELLOW}ℹ️  Hot reload enabled - edit files and changes will appear automatically${NC}"
  else
    echo -e "${RED}❌ Failed to start dev server${NC}"
    reset_environment
    exit 1
  fi
}

# Build production image
run_build() {
  echo -e "${YELLOW}Building production image...${NC}"
  if docker build --target prod -t $CONTAINER_NAME .; then
    echo -e "${GREEN}✅ Successfully built production image: $CONTAINER_NAME${NC}"
  else
    echo -e "${RED}❌ Failed to build production image${NC}"
    reset_environment
    exit 1
  fi
}

# Run production container
run_prod() {
  echo -e "${YELLOW}Starting production container...${NC}"
  
  # Build if image doesn't exist
  if ! docker image inspect $CONTAINER_NAME >/dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Image not found. Building first...${NC}"
    run_build
  fi
  
  # Stop if already running
  if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo -e "${YELLOW}⚠️  Stopping existing container...${NC}"
    docker stop $CONTAINER_NAME >/dev/null
  fi
  
  # Run new container
  if docker run -d --rm -p $PROD_PORT:80 --name $CONTAINER_NAME $CONTAINER_NAME; then
    echo -e "${GREEN}✅ Production container running at http://localhost${NC}"
    echo -e "${YELLOW}ℹ️  To stop: docker stop $CONTAINER_NAME${NC}"
  else
    echo -e "${RED}❌ Failed to start production container${NC}"
    reset_environment
    exit 1
  fi
}

# Main execution
case "$1" in
  dev)
    run_dev
    ;;
  build)
    run_build
    ;;
  prod)
    run_prod
    ;;
  reset)
    reset_environment
    ;;
  *)
    echo -e "${RED}Usage: $0 {dev|build|prod|reset}${NC}"
    echo "  dev   - Start development server with hot reload"
    echo "  build - Build production image"
    echo "  prod  - Run production container (builds first if needed)"
    echo "  reset - Full cleanup of all Docker artifacts"
    exit 1
    ;;
esac