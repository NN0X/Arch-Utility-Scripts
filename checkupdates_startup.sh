#!/bin/bash
if [ -f /home/nox/.config/last_checkupdates ]; then
	updates_check=$(cat /home/nox/.config/last_checkupdates)
else
	updates_check=""
fi

if [ "$updates_check" != "$(date +%Y-%m-%d)" ]; then
	echo $(date +%Y-%m-%d) > /home/nox/.config/last_checkupdates
	~/Scripts/checkupdates.sh
fi

