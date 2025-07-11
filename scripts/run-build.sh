#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW}🔨 Building production image...${NC}"

docker build -f Dockerfile --target prod -t $PROD_IMAGE . || handle_error "Build failed"


echo -e "${GREEN}✅ Built production image: $PROD_CONTAINER${NC}"
