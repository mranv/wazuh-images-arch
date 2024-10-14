#!/bin/bash

# Check if you're in a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Not a git repository. Please run this script inside a git repo."
  exit 1
fi

# Get the list of modified, added, and untracked files
files=$(git status --porcelain | grep -E '^(M|A|\?\?) ' | sed 's/^.. //')

if [ -z "$files" ]; then
  echo "No modified, new, or untracked files to commit."
  exit 0
fi

# Array of professional phrases for commit messages
phrases=(
  "Refined changes in"
  "Updated functionality of"
  "Performed adjustments to"
  "Improved handling of"
  "Enhanced structure of"
  "Revised code in"
  "Made optimizations to"
  "Implemented changes for"
  "Synchronized updates with"
  "Polished aspects of"
)

# Iterate over each file
for file in $files; do
  echo "Processing: $file"
  
  # Add the file to the staging area
  git add "$file"

  # Generate a random professional commit message
  random_phrase=${phrases[$RANDOM % ${#phrases[@]}]}
  commit_message="$random_phrase '$file'"

  # Commit the file with the generated message
  git commit -m "$commit_message"

  echo "Committed: $file with message: $commit_message"
done

echo "All files processed."
