#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW}Building production image...${NC}"
docker build --target prod -t $CONTAINER_NAME . || handle_error "Build failed"
echo -e "${GREEN}✅ Built production image: $CONTAINER_NAME${NC}"