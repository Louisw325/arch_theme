#!/usr/bin/env bash
# Initialize a git repository, create an initial commit, and push to a remote GitHub URL supplied by the user.
set -euo pipefail

REPO_ROOT="$(dirname "$0")/.."
cd "$REPO_ROOT"

if [ -z "${1-}" ]; then
  echo "Usage: $0 <git-remote-url>"
  echo "Example: $0 git@github.com:username/arch_theme.git"
  exit 1
fi

REMOTE_URL="$1"

if [ ! -d .git ]; then
  git init
  git add .
  git commit -m "Initial import of sanitized dotfiles and theme generators"
  git branch -M main
else
  echo "Git repo already initialized."
fi

if git remote | grep -q origin; then
  git remote remove origin
fi

git remote add origin "$REMOTE_URL"

echo "Pushing to $REMOTE_URL"
git push -u origin main

echo "Push complete."
