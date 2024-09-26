#!/bin/bash
pacmd unload-module module-udev-detect && pacmd load-module module-udev-detect
pactl list short sinks | grep alsa_output.usb-audio-technica_AT2020USB_-00.analog-stereo | awk '{print $1}' | xargs -I{} pacmd set-default-sink {}
