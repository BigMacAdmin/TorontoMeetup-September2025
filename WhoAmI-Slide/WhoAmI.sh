#!/bin/zsh --no-rcs
# shellcheck shell=bash
#set -x

# WhoAmI.sh by: Trevor Sysock
# 2025-09-01
# v.0.0

/usr/local/bin/dialog \
    --title none \
    --message "WhoAmI-Slide/WhoAmI.md" \
    --icon "Icons/speakerPortrait.JPG" \
    --overlayicon "Icons/BigMacAdmin.png" \
    --infobox "WhoAmI-Slide/WhoAmI.Info.MD" \
    --moveable --ontop \
    --height 650 \
    --width 1200 \
    --iconsize 300 \
    #--builder
