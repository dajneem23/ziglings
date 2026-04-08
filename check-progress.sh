#!/usr/bin/env bash

# Script to check and update Ziglings progress
# Usage: ./check-progress.sh [exercise_number]

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get current progress
if [ -f .progress.txt ]; then
    CURRENT=$(cat .progress.txt)
else
    CURRENT=0
fi

# Count total exercises (excluding 999_the_end.zig)
TOTAL=$(find exercises -name "*.zig" -type f ! -name "999_*.zig" | wc -l | tr -d ' ')

# Check if completed (either reached TOTAL or special marker 999)
if [ $CURRENT -eq 999 ] || [ $CURRENT -ge $TOTAL ]; then
    CURRENT=$TOTAL
    IS_COMPLETE=true
else
    IS_COMPLETE=false
fi

# Calculate remaining and percentage
REMAINING=$((TOTAL - CURRENT))
if [ $TOTAL -gt 0 ]; then
    PERCENTAGE=$((CURRENT * 100 / TOTAL))
else
    PERCENTAGE=0
fi

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📊 Ziglings Progress Report${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}✅ Completed:${NC} ${CURRENT}/${TOTAL} exercises"
echo -e "${BLUE}📈 Progress:${NC}  ${PERCENTAGE}%"
echo -e "${YELLOW}⏳ Remaining:${NC} ${REMAINING} exercises"
echo ""

# Show progress bar
BAR_LENGTH=40
FILLED=$((PERCENTAGE * BAR_LENGTH / 100))
printf "${BLUE}["
for ((i=0; i<$FILLED; i++)); do printf "█"; done
for ((i=$FILLED; i<$BAR_LENGTH; i++)); do printf "░"; done
printf "] ${PERCENTAGE}%%${NC}\n"
echo ""

if [ "$IS_COMPLETE" = "true" ]; then
    echo -e "${GREEN}🎉 Congratulations! All exercises completed! 🎊${NC}"
else
    echo -e "${YELLOW}🎯 Keep going! You've got this! 💪${NC}"
    
    # Show next exercise
    NEXT=$((CURRENT + 1))
    NEXT_FILE=$(find exercises -name "$(printf "%03d" $NEXT)_*.zig" -type f | head -1)
    if [ -n "$NEXT_FILE" ]; then
        echo -e "${BLUE}📝 Next exercise:${NC} $(basename $NEXT_FILE)"
    fi
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# If argument provided, update progress
if [ $# -eq 1 ]; then
    NEW_PROGRESS=$1
    
    # Validate input
    if ! [[ "$NEW_PROGRESS" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Error: Exercise number must be a positive integer${NC}"
        exit 1
    fi
    
    if [ $NEW_PROGRESS -gt $TOTAL ]; then
        echo -e "${RED}Error: Exercise number cannot exceed total ($TOTAL)${NC}"
        exit 1
    fi
    
    echo ""
    echo -e "${BLUE}Updating progress to exercise ${NEW_PROGRESS}...${NC}"
    echo $NEW_PROGRESS > .progress.txt
    
    NEW_PERCENTAGE=$((NEW_PROGRESS * 100 / TOTAL))
    echo -e "${GREEN}✅ Progress updated!${NC} (${CURRENT} → ${NEW_PROGRESS}, ${NEW_PERCENTAGE}%)"
    echo ""
    echo -e "${YELLOW}Don't forget to commit and push:${NC}"
    echo "  git add .progress.txt"
    echo "  git commit -m \"Completed exercise $NEW_PROGRESS\""
    echo "  git push"
fi

echo ""
