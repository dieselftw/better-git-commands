#!/bin/bash

#Add your GitHub API key here. Optional.
better_git_commands_api_key="123456abcdef"

url=$1
url=${url%.git}
owner=$(echo $url | sed -E 's/.*github.com\/([^\/]+)\/.*/\1/')
repo=$(echo $url | sed -E 's/.*\/([^\/]+)(\.git)?$/\1/')

# Fetch repository details from GitHub API
api_url="https://api.github.com/repos/$owner/$repo"

# If an API key is provided, it is included in the request. This is purely to overcome the 60 req/hour rate limit.
if [[ -n $better_git_commands_api_key ]]; then
    response=$(curl -s -H "Authorization: token $better_git_commands_api_key" "$api_url")
else    
    response=$(curl -s "$api_url")
fi

# Extract metadata using jq
description=$(echo "$response" | jq -r '.description')
default_branch=$(echo "$response" | jq -r '.default_branch')
size=$(echo "$response" | jq '.size')

# Check if size is a number
if [[ $size =~ ^[0-9]+$ ]]; then
    size_mb=$(echo "scale=2; $size / 1024" | bc)
else
    size_mb="Unknown"
fi

# Display repository metadata :)
echo "Cloning repository: $repo"
echo "Description: $description"
echo "Default Branch: $default_branch"
echo "Repository Size: ${size_mb} MB"
echo

# Proceed with cloning the repository
git clone "$@"