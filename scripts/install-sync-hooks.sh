#!/bin/bash

# install-sync-hooks.sh — Install git post-commit hooks for auto-sync
# Usage: ./install-sync-hooks.sh

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_REPO="$REPO_ROOT/web"
API_REPO="$REPO_ROOT/api"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Installing sync hooks${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Check repos exist
if [[ ! -d "$WEB_REPO/.git" ]] || [[ ! -d "$API_REPO/.git" ]]; then
  echo -e "${RED}✗ Error: git repos not found${NC}"
  exit 1
fi

# Web repo hook
echo -e "${YELLOW}Installing hook in web repo...${NC}"
cat > "$WEB_REPO/.git/hooks/post-commit" << 'EOF'
#!/bin/bash
# Auto-sync shared docs from web to api after commit
cd "$(git rev-parse --show-toplevel)/.."
./sync-docs.sh web-to-api --commit --verbose 2>/dev/null || true
EOF

chmod +x "$WEB_REPO/.git/hooks/post-commit"
echo -e "${GREEN}✓ Installed in web/.git/hooks/post-commit${NC}"

# API repo hook
echo -e "${YELLOW}Installing hook in api repo...${NC}"
cat > "$API_REPO/.git/hooks/post-commit" << 'EOF'
#!/bin/bash
# Auto-sync shared docs from api to web after commit
cd "$(git rev-parse --show-toplevel)/.."
./sync-docs.sh api-to-web --commit --verbose 2>/dev/null || true
EOF

chmod +x "$API_REPO/.git/hooks/post-commit"
echo -e "${GREEN}✓ Installed in api/.git/hooks/post-commit${NC}"

# Verify
echo -e "\n${YELLOW}Verifying installation...${NC}"
if [[ -x "$WEB_REPO/.git/hooks/post-commit" ]] && [[ -x "$API_REPO/.git/hooks/post-commit" ]]; then
  echo -e "${GREEN}✓ Both hooks installed and executable${NC}"
else
  echo -e "${RED}✗ Hook installation failed${NC}"
  exit 1
fi

echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Setup complete!${NC}"
echo -e "\n${BLUE}Next steps:${NC}"
echo "  1. Make a test commit: cd web && git commit --allow-empty -m 'test: sync hook'"
echo "  2. Check both repos synced: git log --oneline (should show auto-sync commits)"
echo "  3. See details in: SYNC-DOCS-README.md"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
