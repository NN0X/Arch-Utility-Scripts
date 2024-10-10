#!/bin/bash
yay -Sy
updates=$(yay -Qu)
echo $(date +%Y-%m-%d) > ~/.config/last_checkupdates
updates_count=$(echo "$updates" | grep -c .)
if [ $updates_count -gt 0 ]; then
	if [ $updates_count -eq 1 ]; then
		echo "There is 1 update available."
		read -p "Would you like to view it? [Y/n] " -r
	else
		echo "There are $updates_count updates available."
		read -p "Would you like to view them? [Y/n] " -r
	fi
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "$updates"
	fi
	read -p "Would you like to update? [Y/n] " -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		sudo pacman -Syu
		yay -Syu
		/home/nox/Scripts/reset_settings.sh
	fi
fi
