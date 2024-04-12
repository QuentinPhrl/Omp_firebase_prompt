#!/bin/zsh

local json_file=$HOME/.config/configstore/firebase-tools.json
local project_path="$1"

if [[ -f "$json_file" ]]; then
    local json=$(jq -r ".activeProjects" "$json_file")

    project_name=$(echo "$json" | jq --arg path "$project_path" 'to_entries[] | .key as $k | select(($path | startswith($k)))' | jq -r '.value')

    if [[ -n $project_name ]]; then
        echo "$project_name"
    fi
fi