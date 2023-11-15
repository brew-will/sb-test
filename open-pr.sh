#!/bin/bash

current_branch=$(git rev-parse --abbrev-ref HEAD)
base_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

title=""
template=""
pro=$(basename $(git rev-parse --show-toplevel))
repository_url=$(git remote get-url origin)
org=$(echo "$repository_url" | awk -F'/' '{print $1}' | sed 's/.*://')

if [ "$current_branch" == $base_branch ]; then
    echo "You can not run this script from the main branch"
    exit 1
fi

git ls-remote --exit-code origin "$current_branch"

if [ $? -ne 0 ]; then
    echo "There is no remote version of the branch, please commit any changes and push."
    exit 1
fi

if [ -n "$1" ]; then
    title=$(echo "$1" | sed 's/ /+/g')
else
    echo "Please provide a title as the first argument" 
    exit 1
fi

if [ -n "$2" ]; then
    template=$2
fi

<<<<<<< Updated upstream
echo "https://github.com/$org/$pro/compare/$base_branch...$current_branch?quick_pull=1&title=$title&template=$template"
=======
ghUrl="https://github.com/$org/$pro/compare/$base_branch...$current_branch?quick_pull=1&title=$title"

if [ -n "$template" ]; then
    ghUrl="$ghUrl&template=$template"
fi

open $ghUrl
>>>>>>> Stashed changes
