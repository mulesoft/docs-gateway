#!/bin/bash

# =============================
# Script to compare changes between two versioned pdk directories
#
# Usage: Run this script to check if all changes made to pdk/1.3 in the 'latest' branch
# after the 1.4 release branch was created have also been applied to pdk/1.4 in the
# 'RELEASE_BRANCH' branch.
#
# When creating a new release (e.g., 1.5):
#   1. Update BASE_COMMIT to the commit hash where the new release branch (RELEASE_BRANCH for the next release) split from 'latest'.
#      To find the commit hash, use:
#        git merge-base latest RELEASE_BRANCH
#   2. Update the branch names (LATEST_BRANCH and RELEASE_BRANCH) as needed.
#   3. Update the OLD_VERSION and NEW_VERSION variables to match the previous and new version numbers.
# =============================

# Commit hash where the release branch split from 'latest'.
# To update for a new release, set this to the commit where the new release branch was created.
# To find the commit hash, run:
#   git merge-base latest RELEASE_BRANCH
BASE_COMMIT=ed60617a8219dc89414e71698c77e31d55983a0c

# Name of the main branch (usually 'latest')
LATEST_BRANCH=latest
# Name of the release branch (e.g., 'pdk-1-4-release')
RELEASE_BRANCH=pdk-1-4-release

# Previous version directory (e.g., '1.3')
OLD_VERSION=1.3
# New version directory (e.g., '1.4')
NEW_VERSION=1.4

# Get the list of changed files in the previous version directory since the split
# For a new release, update $OLD_VERSION and $NEW_VERSION accordingly

changed_files=$(git diff --name-only $BASE_COMMIT..$LATEST_BRANCH -- pdk/$OLD_VERSION)
if [ -z "$changed_files" ]; then
  echo "No changes found in pdk/$OLD_VERSION since the release branch was created."
else
  echo "$changed_files" | while read file; do
    file_new=${file/$OLD_VERSION/$NEW_VERSION}
    echo "Comparing $file ($LATEST_BRANCH) to $file_new ($RELEASE_BRANCH):"
    diff_output=$(git diff $LATEST_BRANCH:"$file" $RELEASE_BRANCH:"$file_new")
    if [ -z "$diff_output" ]; then
      echo "  No missing changes."
    else
      echo "$diff_output"
    fi
    echo "----------------------------------------"
  done
fi

