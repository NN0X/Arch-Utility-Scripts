#!/bin/bash

# for all devices
for id in $(xinput --list | grep -i mouse | grep -o 'id=[0-9]*' | cut -d= -f2); do
    xinput --set-prop $id 'libinput Accel Profile Enabled' 0, 1 &> /dev/null
    xinput --set-prop $id 'libinput Tapping Enabled' 1 &> /dev/null
done
