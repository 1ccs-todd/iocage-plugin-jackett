#!/usr/local/bin/bash
# This file contains the install script for jackett

#init jail
initblueprint "$1"

chown -R jackett:jackett /usr/local/share/Jackett /config
service jackett restart

exitblueprint "$1"
