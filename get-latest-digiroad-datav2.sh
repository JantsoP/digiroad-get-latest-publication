#!/bin/bash

# Assign the filename
filename="/root/digiroad.sh"

# Get offline version info
offlineversion=0

# Get latest data from Digiroad server
onlineversion=$(curl -s -I  https://ava.vaylapilvi.fi/ava/Tie/Digiroad/Aineistojulkaisut/latest/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip | awk '/last-modified/{ date=""; for(i=2;i<=NF;++i) date=(date " " $i); print date;}' | xargs -I{} date -d {} +"%s")

# Compare if online version is newer than previously recorded
if [ $onlineversion -gt $offlineversion ]
        then
            echo New KokoSuomi_DIGIROAD_R_EUREF-FIN.zip detected. Downloading to /opt/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip
            curl -o /opt/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip https://ava.vaylapilvi.fi/ava/Tie/Digiroad/Aineistojulkaisut/latest/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip
            # Change latest digiroad version for downloaded version
            sed -i "s/$offlineversion/$onlineversion/" $filename

        else 
            echo No new version of KokoSuomi_DIGIROAD_R_EUREF-FIN.zip found.
        fi
    echo Done
