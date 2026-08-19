#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: ./save.sh \"your commit message\""
  exit 1
fi

BRANCH=$(git branch --show-current)

if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
  echo "⚠️  You're on $BRANCH. This script refuses to run here."
  echo "   Create a feature branch first: git checkout -b feature/xyz"
  exit 1
fi

echo "── Changes to be committed ──"
git status -s
echo "──────────────────────────────"
read -p "Proceed with commit + push on '$BRANCH'? [y/N] " confirm
if [ "$confirm" != "y" ]; then
  echo "Aborted."
  exit 1
fi

git add .
git commit -m "$1"
git pull origin "$BRANCH" --rebase
git push origin "$BRANCH"

echo "✅ Pushed to $BRANCH"