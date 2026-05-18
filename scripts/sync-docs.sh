#!/bin/bash

# sync-docs.sh — Synchronize shared documentation between web and api repos
# Usage: ./sync-docs.sh [direction] [--commit] [--verbose]
#
# direction: web-to-api (default) | api-to-web | both
# --commit: Auto-commit changes after sync
# --verbose: Show file details

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_REPO="$REPO_ROOT/web"
API_REPO="$REPO_ROOT/api"

# Configuration
SHARED_DOCS=(
  "docs/memory/context.md"
  "docs/memory/decisions.md"
  "docs/memory/pending.md"
  "docs/ROADMAP-TIERS.md"
)

REF_DOCS=(
  "docs/tech/adr/"
  "docs/legal/compliance/"
)

# Parse arguments
DIRECTION="${1:-web-to-api}"
AUTO_COMMIT=false
VERBOSE=false

while [[ $# -gt 1 ]]; do
  case "$2" in
    --commit) AUTO_COMMIT=true ;;
    --verbose) VERBOSE=true ;;
  esac
  shift
done

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  SINAGENCIAS.ES — Documentation Sync${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [[ ! -d "$WEB_REPO" ]] || [[ ! -d "$API_REPO" ]]; then
  echo -e "${RED}✗ Error: web/ and api/ directories not found${NC}"
  echo "  Run from: /Documents/Personal/Proyectos/SinAgencias"
  exit 1
fi

sync_shared() {
  local source_repo="$1"
  local target_repo="$2"
  local source_name="${source_repo##*/}"
  local target_name="${target_repo##*/}"

  echo -e "\n${YELLOW}Syncing shared docs: $source_name → $target_name${NC}"

  local synced=0
  local failed=0

  for doc in "${SHARED_DOCS[@]}"; do
    local source_file="$source_repo/$doc"
    local target_file="$target_repo/$doc"

    if [[ ! -f "$source_file" ]]; then
      echo -e "${RED}✗ Source not found: $doc${NC}"
      ((failed++))
      continue
    fi

    cp "$source_file" "$target_file"
    if [[ $VERBOSE == true ]]; then
      echo -e "${GREEN}✓ Synced: $doc${NC}"
    fi
    ((synced++))
  done

  echo -e "${GREEN}✓ Synced $synced files${NC}"
  [[ $failed -gt 0 ]] && echo -e "${RED}✗ Failed: $failed files${NC}"

  return $failed
}

sync_refs() {
  local source_repo="$1"
  local target_repo="$2"
  local source_name="${source_repo##*/}"
  local target_name="${target_repo##*/}"

  echo -e "\n${YELLOW}Syncing reference docs: $source_name → $target_name${NC}"

  local synced=0
  local failed=0

  for doc_dir in "${REF_DOCS[@]}"; do
    local source_dir="$source_repo/$doc_dir"
    local target_dir="$target_repo/$doc_dir"

    if [[ ! -d "$source_dir" ]]; then
      echo -e "${RED}✗ Source not found: $doc_dir${NC}"
      ((failed++))
      continue
    fi

    mkdir -p "$(dirname "$target_dir")"
    rm -rf "$target_dir"
    cp -r "$source_dir" "$target_dir"

    if [[ $VERBOSE == true ]]; then
      echo -e "${GREEN}✓ Synced: $doc_dir${NC}"
    fi
    ((synced++))
  done

  echo -e "${GREEN}✓ Synced $synced directories${NC}"
  [[ $failed -gt 0 ]] && echo -e "${RED}✗ Failed: $failed directories${NC}"

  return $failed
}

auto_commit_if_needed() {
  local repo="$1"
  local repo_name="${repo##*/}"

  if [[ $AUTO_COMMIT != true ]]; then
    return 0
  fi

  cd "$repo"
  if git diff --quiet docs/memory/ docs/ROADMAP-TIERS.md 2>/dev/null; then
    echo -e "${YELLOW}No changes in $repo_name${NC}"
    cd - > /dev/null
    return 0
  fi

  git add docs/memory/ docs/ROADMAP-TIERS.md 2>/dev/null || true
  git commit -m "docs: auto-sync shared documentation" 2>/dev/null || true
  echo -e "${GREEN}✓ Auto-committed in $repo_name${NC}"
  cd - > /dev/null
}

# Main sync logic
case "$DIRECTION" in
  web-to-api)
    sync_shared "$WEB_REPO" "$API_REPO"
    sync_refs "$WEB_REPO" "$API_REPO"
    auto_commit_if_needed "$API_REPO"
    ;;
  api-to-web)
    sync_shared "$API_REPO" "$WEB_REPO"
    # Don't sync refs from api to web (web is source of truth)
    auto_commit_if_needed "$WEB_REPO"
    ;;
  both)
    # Sync web → api (full)
    sync_shared "$WEB_REPO" "$API_REPO"
    sync_refs "$WEB_REPO" "$API_REPO"
    # Sync api → web (shared only, not refs)
    sync_shared "$API_REPO" "$WEB_REPO"
    auto_commit_if_needed "$API_REPO"
    auto_commit_if_needed "$WEB_REPO"
    ;;
  *)
    echo -e "${RED}✗ Invalid direction: $DIRECTION${NC}"
    echo "Valid options: web-to-api (default) | api-to-web | both"
    exit 1
    ;;
esac

echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Sync complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
