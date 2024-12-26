#!/bin/bash
updates_official=$(checkupdates)
updates_aur=$(yay -Qum)
updates_count_official=$(echo "$updates_official" | grep -c .)
updates_count_aur=$(echo "$updates_aur" | grep -c .)
if [ $updates_count_official -eq 0 ] && [ $updates_count_aur -eq 0 ]; then
	if [ $updates_count_official -eq 1 ] && [ $updates_count_aur -lt 1 ]; then
		echo "There is 1 official update available."
		read -p "Would you like to view it? [T/n] " -r
	fi
	if [ $updates_count_official -gt 1 ] && [ $updates_count_aur -lt 1 ]; then
		echo "There are $updates_count_official updates available."
		read -p "Would you like to view them? [T/n] " -r
	fi
	if [ $updates_count_official -eq 1 ] && [ $updates_count_aur -eq 1 ]; then
		echo "There is 1 official update and 1 AUR update available."
		read -p "Would you like to view them? [T/n] " -r
	fi
	if [ $updates_count_official -gt 1 ] && [ $updates_count_aur -eq 1 ]; then
		echo "There are $updates_count_official official updates and 1 AUR update available."
		read -p "Would you like to view them? [T/n] " -r
	fi
	if [ $updates_count_official -eq 1 ] && [ $updates_count_aur -gt 1 ]; then
		echo "There is 1 official update and $updates_count_aur AUR updates available."
		read -p "Would you like to view them? [T/n] " -r
	fi
	if [ $updates_count_official -gt 1 ] && [ $updates_count_aur -gt 1 ]; then
		echo "There are $updates_count_official official updates and $updates_count_aur AUR updates available."
		read -p "Would you like to view them? [T/n] " -r
	fi
	echo
	if [[ $REPLY =~ ^[Tt]$ ]]; then
		if [ $updates_count_official -gt 0 ]; then
			echo "Official updates:"
			echo "$updates_official"
		fi
		if [ $updates_count_aur -gt 0 ]; then
			echo "AUR updates:"
			echo "$updates_aur"
		fi
	fi
	read -p "Would you like to update? [T/n] " -r
	echo
	if [[ $REPLY =~ ^[Tt]$ ]]; then
		yay -Syu
		~/Scripts/reset_settings.sh
	fi
fi
