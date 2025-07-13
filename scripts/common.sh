#!/bin/bash

# Configuration
PROD_IMAGE="roadmap_front"            # Final production image name
PROD_CONTAINER="roadmap_front"        # Container name for prod (same name is OK)

DEV_IMAGE="roadmap_front-dev"         # Local dev image
DEV_CONTAINER="roadmap_front-dev"     # Container name for dev

PROD_PORT=8080
DEV_PORT=5173

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Error handling
handle_error() {
  echo -e "${RED} Error: $1${NC}"
  exit 1
}
