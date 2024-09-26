#!/bin/bash
amixer get Master | grep "Front Left" | awk -F'[][]' '{print $2}' | tr -d '%\n'
