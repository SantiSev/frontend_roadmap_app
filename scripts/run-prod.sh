#!/bin/bash
source ./scripts/common.sh

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