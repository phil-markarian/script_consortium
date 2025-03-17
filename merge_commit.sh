#!/bin/bash

# Check if the PR number is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <PR_NUMBER>"
  exit 1
fi

pr_number="$1"

# Check if gh and jq are installed
if ! command -v gh &> /dev/null; then
  echo "gh command not found. Please install gh CLI."
  exit 1
fi

if ! command -v jq &> /dev/null; then
  echo "jq command not found. Please install jq."
  exit 1
fi

# Get the merge commit hash using gh and jq
merge_commit_hash=$(gh pr view "$pr_number" --json mergeCommit -q .mergeCommit.oid)

# Check if the command was successful and the hash was retrieved
if [ -n "$merge_commit_hash" ]; then
  echo "$merge_commit_hash"
else
  echo "Failed to retrieve the merge commit hash for PR $pr_number."
  exit 1
fi
