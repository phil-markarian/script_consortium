#!/bin/bash
# filepath: create-pr-from-cherry-pick.sh

# Check if commit SHA is provided
if [ -z "$1" ]; then
    echo "Error: Please provide a commit SHA"
    echo "Usage: ./create-pr-from-cherry-pick.sh <commit-sha>"
    exit 1
fi

# Store the commit SHA from input
COMMIT_SHA="$1"

# Validate if the commit exists
if ! git cat-file -e "$COMMIT_SHA^{commit}" 2>/dev/null; then
    echo "Error: Invalid commit SHA"
    exit 1
fi

# Get the commit message and body
COMMIT_TITLE=$(git log -1 --pretty=%s "$COMMIT_SHA")
COMMIT_BODY=$(git log -1 --pretty=%b "$COMMIT_SHA")

# Push the current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "Pushing branch: $CURRENT_BRANCH"
git push -u origin "$CURRENT_BRANCH"

# Create the PR
echo "Creating PR with title: $COMMIT_TITLE"
gh pr create \
    --title "$COMMIT_TITLE" \
    --body "$COMMIT_BODY" \
    --label bug \
    --assignee @me

# Open PR in browser
gh pr view --web
