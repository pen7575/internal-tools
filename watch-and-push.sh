#!/bin/bash
REPO="$(cd "$(dirname "$0")" && pwd)"

echo "Watching $REPO for changes..."

fswatch -o "$REPO" --exclude ".git" | while read; do
  cd "$REPO"
  if ! git diff --quiet || git ls-files --others --exclude-standard | grep -q .; then
    git add -A
    git commit -m "update $(date '+%Y-%m-%d %H:%M')"
    git push
    echo "Pushed at $(date '+%H:%M:%S')"
  fi
done
