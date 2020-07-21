#!/usr/local/bin/bash
# This file contains the install script for jackett

#init jail
initplugin "$1"

iocage exec "$1" chown -R jackett:jackett /usr/local/share/Jackett /config
iocage exec "$1" service jackett restart

exitplugin "$1"
