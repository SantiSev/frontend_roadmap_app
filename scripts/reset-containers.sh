#!/bin/bash
source ./scripts/common.sh

echo -e "${YELLOW} Resetting environment...${NC}"

docker stop $DEV_CONTAINER 2>/dev/null || echo "No dev container running"
docker stop $CONTAINER_NAME 2>/dev/null || echo "No prod container running"

docker rm $DEV_CONTAINER 2>/dev/null
docker rm $CONTAINER_NAME 2>/dev/null

docker rmi -f $DEV_IMAGE 2>/dev/null || echo "No dev image to remove"
docker rmi -f $CONTAINER_NAME 2>/dev/null || echo "No prod image to remove"

docker system prune -af || echo "Docker prune failed"

echo -e "${GREEN} Environment reset complete${NC}"
