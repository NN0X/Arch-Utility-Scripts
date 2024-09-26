#!/bin/bash
data=$(cat .weather_data)

is_day=$(echo $data | jq -r '.current.is_day')

if [ $is_day == "true" ]; then
    theme="^b#0c0d30^"
else
    theme="^b#1a1b1c^"
fi

printf $theme
