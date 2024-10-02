#!/bin/bash
if [ -f ~/.config/last_checkupdates ]; then
	updates_check=$(cat ~/.config/last_checkupdates)
else
	updates_check=""
fi

sudo pacman -Sy
if [ "$updates_check" != "$(date +%Y-%m-%d)" ]; then
	updates=$(yay -Qu)
	echo $(date +%Y-%m-%d) > ~/.config/last_checkupdates
	updates_count=$(echo "$updates" | grep -c .)
	if [ $updates_count -gt 0 ]; then
		if [ $updates_count -eq 1 ]; then
			echo "There is 1 update available."
			read -p "Would you like to view it? [T/n] " -r
		else
			echo "There are $updates_count updates available."
			read -p "Would you like to view them? [T/n] " -r
		fi
		echo
		if [[ $REPLY =~ ^[Tt]$ ]]; then
			echo "$updates"
		fi
		read -p "Would you like to update? [T/n] " -r
		echo
		if [[ $REPLY =~ ^[Tt]$ ]]; then
			sudo pacman -Syu
			yay -Syu
			/home/nox/Scripts/reset_settings.sh
		fi
	fi
fi

