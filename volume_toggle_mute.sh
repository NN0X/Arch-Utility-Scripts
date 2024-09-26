#!/bin/bash

if amixer get Master | grep -q off
then
	amixer set Master on
	if [ -f /home/nox/Scripts/.volume_previous ]
	then
		VOLUME=$(cat /home/nox/Scripts/.volume_previous)
		amixer set Master $VOLUME
	fi
else
	amixer get Master | grep -o -m 1 -E [0-9]+% > /home/nox/Scripts/.volume_previous
	amixer set Master 0
	amixer set Master off
fi
