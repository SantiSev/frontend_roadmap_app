#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW} Building production image...${NC}"

docker build -f Dockerfile -t $CONTAINER_NAME . --target prod || handle_error "Build failed"

echo -e "${GREEN} Built production image: $CONTAINER_NAME${NC}"
