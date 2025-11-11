#!/bin/bash
SUBFOLDER="public"

CURRENT_TIME=$(date "+%d-%m-%Y %H:%M")

COMMIT_MESSAGE="chore(blog): update content - $CURRENT_TIME"

cd "$SUBFOLDER" || { echo "❌ Directory $SUBFOLDER does not exist!"; exit 1; }

if [[ -n $(git status --porcelain) ]]; then
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push origin main
    echo "✅ Successfully pushed with commit: '$COMMIT_MESSAGE'"
else
    echo "⚠️ No changes to commit."
fi

cd ..

read -p "Press enter to exit..."
