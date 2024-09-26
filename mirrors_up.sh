#!/bin/bash
sudo reflector --verbose --country PL,DE,GB --protocol https --sort rate --latest 20 --download-timeout 6 --save /etc/pacman.d/mirrorlist

