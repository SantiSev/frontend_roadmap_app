#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW}Resetting environment...${NC}"

docker compose down -v --remove-orphans || echo "No containers to remove"
docker system prune -af || echo "Prune failed"
docker rmi -f $CONTAINER_NAME 2>/dev/null || echo "No image to remove"

echo -e "${GREEN}✅ Environment reset complete${NC}"