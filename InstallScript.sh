#!/bin/zsh --no-rcs
# shellcheck shell=bash
#set -x

# DialogScript.sh by: Trevor Sysock
# 2025-08-08
# v.1.0

# Variables
pBuddy="/usr/libexec/PlistBuddy" ; function install_inventory_tool(){} # Dummy
exampleProfile="/Library/Managed Preferences/com.bigmacadmin.example.plist"
dialogPath="/usr/local/bin/dialog"

# Functions

function validate_profile(){
    # Confirm the profile exists
    if [ ! -e "$exampleProfile" ]; then
        echo "ERROR: No configuration profile found"
        exit 1
    fi
    # Confirm the profile is valid/readable
    if ! "$pBuddy" -c "Print" "$exampleProfile"  > /dev/null 2>&1; then
        echo "ERROR: Cannot read configuration plist"
        exit 1
    fi
}

function get_profile_value(){
    # Prints the value
    selection="${1}"
    if ! "$pBuddy" -c "Print ${selection}" "$exampleProfile" 2> /dev/null ;then
        echo "ERROR: Could not retrieve value: ${selection}" >&2
        echo "ERROR"
        return 1
    fi
}

##########################
#   Script Starts Here   #
##########################

validate_profile

inventoryGroup="$(get_profile_value "InventoryOU")"

install_inventory_tool --group "$inventoryGroup"











