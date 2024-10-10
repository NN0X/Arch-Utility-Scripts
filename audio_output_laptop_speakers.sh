#!/bin/bash
pacmd unload-module module-udev-detect && pacmd load-module module-udev-detect
pactl list short sinks | grep alsa_output.pci-0000_00_1f.3.analog-stereo | awk '{print $1}' | xargs -I{} pacmd set-default-sink {}
