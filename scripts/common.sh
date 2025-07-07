#!/bin/bash

# Configuration
CONTAINER_NAME="roadmap_front"
DEV_SERVICE="dev"
PROD_PORT=80
DEV_PORT=5173

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Error handling
handle_error() {
  echo -e "${RED}❌ Error: $1${NC}"
  exit 1
}