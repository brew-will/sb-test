#!/bin/bash

current_branch=$(git rev-parse --abbrev-ref HEAD)
base_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

title=""
template="new-module.md"

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

echo "https://github.com/brewdigital/adaptavist-monorepo/compare/$base_branch...$current_branch?quick_pull=1&title=$title&template=$template"


echo $title $template $current_branch

# REF: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/using-query-parameters-to-create-a-pull-request

# open 