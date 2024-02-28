# colors
BLACK='\033[0;30m'
RED='\033[1;31m'
GREEN='\033[1;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[1;30m'
NC='\033[0m' # No Color

function success {
    echo -e "${GREEN}✅ $1${NC}"
}

function warning {
    echo -e "${ORANGE}⚠️ $1${NC}"
}

function info {
    echo -e "${GRAY}==== $1${NC}"
}

function debug {
    echo -e "${CYAN}==== $1${NC}"
}

function error {
    echo -e "${RED}❌ $1${NC}"
}