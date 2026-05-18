#!/bin/bash

# setup-env.sh — Helper to configure .env files with Supabase credentials
# Usage: ./setup-env.sh
# Interactively prompts for Supabase credentials and updates both repos

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  SINAGENCIAS.ES — Environment Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
API_ENV="$REPO_ROOT/api/.env"
WEB_ENV="$REPO_ROOT/web/.env.local"

# Check files exist
if [[ ! -f "$API_ENV" ]]; then
  echo -e "${RED}✗ api/.env not found${NC}"
  exit 1
fi

if [[ ! -f "$WEB_ENV" ]]; then
  echo -e "${RED}✗ web/.env.local not found${NC}"
  exit 1
fi

echo -e "${YELLOW}Get these values from Supabase dashboard:${NC}"
echo "  1. Go to: https://app.supabase.com"
echo "  2. Click your project"
echo "  3. Settings → API"
echo "  4. Copy: Project URL, anon key, service_role key\n"

# Supabase URL
read -p "$(echo -e ${YELLOW}SUPABASE_URL${NC}) (https://xxx.supabase.co): " supabase_url
if [[ -z "$supabase_url" ]]; then
  echo -e "${RED}✗ SUPABASE_URL is required${NC}"
  exit 1
fi

# Anon Key
read -p "$(echo -e ${YELLOW}SUPABASE_ANON_KEY${NC}) (eyJ...): " supabase_anon_key
if [[ -z "$supabase_anon_key" ]]; then
  echo -e "${RED}✗ SUPABASE_ANON_KEY is required${NC}"
  exit 1
fi

# Service Key
read -p "$(echo -e ${YELLOW}SUPABASE_SERVICE_KEY${NC}) (eyJ...): " supabase_service_key
if [[ -z "$supabase_service_key" ]]; then
  echo -e "${RED}✗ SUPABASE_SERVICE_KEY is required${NC}"
  exit 1
fi

# Resend API Key (optional)
read -p "$(echo -e ${YELLOW}RESEND_API_KEY${NC}) (re_... or leave empty): " resend_api_key

# Update API .env
echo -e "\n${YELLOW}Updating api/.env...${NC}"
sed -i.bak \
  -e "s|SUPABASE_URL=.*|SUPABASE_URL=$supabase_url|" \
  -e "s|SUPABASE_ANON_KEY=.*|SUPABASE_ANON_KEY=$supabase_anon_key|" \
  -e "s|SUPABASE_SERVICE_KEY=.*|SUPABASE_SERVICE_KEY=$supabase_service_key|" \
  "$API_ENV"

if [[ ! -z "$resend_api_key" ]]; then
  sed -i.bak "s|RESEND_API_KEY=.*|RESEND_API_KEY=$resend_api_key|" "$API_ENV"
fi

rm -f "$API_ENV.bak"
echo -e "${GREEN}✓ Updated api/.env${NC}"

# Verify API .env
echo -e "\n${YELLOW}Verification (api/.env):${NC}"
grep "SUPABASE_URL\|SUPABASE_ANON_KEY\|RESEND_API_KEY" "$API_ENV" | sed 's/=.*/= [hidden]/g'

echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Setup complete!${NC}\n"

echo -e "${BLUE}Next steps:${NC}"
echo "  1. Verify values are correct: cat api/.env"
echo "  2. Create Supabase table: See SUPABASE-SETUP.md (Step 3)"
echo "  3. Start API: cd api && npm run start:dev"
echo "  4. Test endpoint: curl -X POST http://localhost:3001/subscribers ..."
echo -e "\n${BLUE}See:${NC} api/SUPABASE-SETUP.md for detailed instructions"
