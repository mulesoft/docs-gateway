#!/bin/bash

# =============================
# Script to compare changes between two versioned pdk directories using docs-team-wiki/handy-scripts/check-changes.sh script
#
# NOTE: This script depends on the main script located at:
#   docs-team-wiki/handy-scripts/check-changes.sh
# Ensure that script is available and up to date.
#
# Usage: Run this script to check if all changes made to pdk/curr-rel in the 'latest' branch
# after the new PDK release branch is created are also applied to pdk/new-rel in the
# 'RELEASE_BRANCH' branch.
#
# For example, for the PDK 1.4.0 release:
#    Checks that changes made under the pdk/1.3 directory in branch 'latest',
#    after the 'pdk-1-4-release' release branch is created are also applied in the
#    pdk/1.4 release folder in the 'pdk-1-4-release' release branch.
#
# To update the script to work after creating a new release (e.g., 1.5):
#   1. Update branch names (LATEST_BRANCH and RELEASE_BRANCH).
#   2. Update version numbers (OLD_VERSION and NEW_VERSION).
#   3. Update BASE_COMMIT to the commit hash where the new release branch
#      (RELEASE_BRANCH for next release) split from 'latest'.  To find the commit
#      hash, use command 'git merge-base latest RELEASE_BRANCH'. For example:
#        git merge-base latest pdk-1-4-release
#
# =============================

# Error check for dependency script
if [ ! -f "../../../docs-team-wiki/handy-scripts/check-changes.sh" ]; then
  echo "Error: Required script 'docs-team-wiki/handy-scripts/check-changes.sh' not found. Please ensure it exists and is up to date." >&2
  exit 1
fi

# Commit hash where the release branch split from 'latest'.
# To update for a new release, set this to the commit where the new release branch was created.
# To find the commit hash, use command 'git merge-base latest RELEASE_BRANCH'.
# For example:
BASE_COMMIT=ed60617a8219dc89414e71698c77e31d55983a0c

# Name of the main branch (usually 'latest')
LATEST_BRANCH=latest
# Name of the release branch (e.g., 'pdk-1-4-release')
RELEASE_BRANCH=pdk-1-4-release

# Previous version directory (e.g., '1.3')
OLD_VERSION=1.3
# New version directory (e.g., '1.4')
NEW_VERSION=1.4

# Call the generic check-changes.sh script with the appropriate arguments
../../../docs-team-wiki/handy-scripts/check-changes.sh \
  --folder pdk \
  --old-version "$OLD_VERSION" \
  --new-version "$NEW_VERSION" \
  --latest-branch "$LATEST_BRANCH" \
  --release-branch "$RELEASE_BRANCH" \
  --base-commit "$BASE_COMMIT"
