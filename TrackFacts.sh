#!/bin/zsh --no-rcs
# shellcheck shell=bash
#set -x

# TrackFacts.sh by: Trevor Sysock
# 2025-09-03
# v.0.0

# Configuration
trackerPlist="/var/tmp/tracker.plist"

# Variables
pBuddy="/usr/libexec/PlistBuddy"

# Functions
function initialize_plist(){
    # If our tracker file doesn't exist or isn't valid xml, then we create a new file
    if [ ! -e "$trackerPlist" ] || ! plutil -lint "$trackerPlist"  > /dev/null 2>&1; then
        # Delete it if its corrupt
        rm -rf "$trackerPlist"  > /dev/null 2>&1
        # Create the tracker and initialize it with a start date
        "$pBuddy" -c "Add CreationDate string $(date +%Y-%m-%d_%H:%M:%S)"  "$trackerPlist" > /dev/null 2>&1
    fi
}

function write_value(){
    # $1 is the key to write
    # $2 is the value of the key
    # $3 is the value type (Optional. Defaults to string if not provided)
    local key="$1"
    local value="$2"
    local type="string"

    # Check if type option is provided
    if [ -n "$3" ]; then
        local type="$3"
    fi

    # Delete the key if it already exists.
    "$pBuddy" -c "Delete $key" "$trackerPlist"  > /dev/null 2>&1
    # Write the value
    "$pBuddy" -c "Add $key $type $value" "$trackerPlist" 
}

function delete_value(){
    # $1 is the key to delete
    local key="$1"
    # Delete the key if it already exists.
    "$pBuddy" -c "Delete $key" "$trackerPlist"  > /dev/null 2>&1
}

# Script Starts Here

initialize_plist

write_value BaselineCompleted true bool

write_value SetupDuration 254 integer

write_value SophosRemovalDate "$(date)" date

write_value CoolestGuyInTheRoom "Brock"

delete_value CoolestGuyInTheRoom




