#!/bin/sh

pw user add jackett -c jackett -u 818 -d /nonexistent -s /usr/bin/nologin

fetch  https://github.com/jailmanager/jailmanager.github.io/releases/download/v0.0.1/mono-6.8.0.105.txz -o /usr/local/share
pkg install -y /usr/local/share/mono-6.8.0.105.txz
rm /usr/local/share/mono-6.8.0.105.txz

# Initialise defaults
FILE_NAME=$(curl -s https://api.github.com/repos/Jackett/Jackett/releases/latest | jq -r ".assets[] | select(.name | contains(\"Mono.tar.gz\")) | .name")
DOWNLOAD=$(curl -s https://api.github.com/repos/Jackett/Jackett/releases/latest | jq -r ".assets[] | select(.name | contains(\"Mono.tar.gz\")) | .browser_download_url")

fetch -o /usr/local/share "${DOWNLOAD}"
tar -xzvf /usr/local/share/${FILE_NAME} -C /usr/local/share
# Need to make jackett user own /usr/local/share/jackett folder
# this is needed for update to work properly
rm /usr/local/share/"${FILE_NAME}"

chmod u+x /usr/local/etc/rc.d/jackett
sysrc "jackett_enable=YES"