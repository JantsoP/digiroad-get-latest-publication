#!/bin/bash

# Check if latest-vayla.txt and email-template.txt exists in /opt

vaylatxt=/opt/latest-vayla.txt
if [ -f "$vaylatxt" ]; then
    echo "$vaylatxt exists."
else 
    echo "$vaylatxt does not exist. Creating it."
    echo 0 > /opt/latest-vayla.txt

fi

emailtemplate=/opt/email-template.txt
if [ -f "$emailtemplate" ]; then
    echo "$emailtemplate exists."
else 
    echo "$emailtemplate does not exist. Creating it."
    cat << 'EOF' > /opt/email-template.txt
To: email@example.tld
Subject: New Digiroad publication has been detected & downloaded

Downloaded .zip can be found on server called changeme at /opt/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip
EOF

fi


# Get offline version info
offlineversion=$(cat /opt/latest-vayla.txt)

# Get latest data from Digiroad server
onlineversion=$(curl -s -I  https://ava.vaylapilvi.fi/ava/Tiest%C3%B6tiedot/Digiroad/Digiroad-irrotusaineistot/latest/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip | awk '/Last-Modified/{ date=""; for(i=2;i<=NF;++i) date=(date " " $i); print date;}' | xargs -I{} date -d {} +"%s")

# Compare if online version is newer than previously recorded
if [ $onlineversion -gt $offlineversion ]
        then
            echo New KokoSuomi_DIGIROAD_R_EUREF-FIN.zip detected. Downloading to /opt/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip
            curl -o /opt/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip https://ava.vaylapilvi.fi/ava/Tiest%C3%B6tiedot/Digiroad/Digiroad-irrotusaineistot/latest/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip
            echo Setting new latest-vayla.txt file
            curl -s -I  https://ava.vaylapilvi.fi/ava/Tiest%C3%B6tiedot/Digiroad/Digiroad-irrotusaineistot/latest/KokoSuomi_DIGIROAD_R_EUREF-FIN.zip | 
            awk '/Last-Modified/{ date=""; for(i=2;i<=NF;++i) date=(date " " $i); print date;}' | 
            xargs -I{} date -d {} +"%s" > /opt/latest-vayla.txt
            # Send email 
            /usr/sbin/ssmtp email@example.tld -F "Digiroad Aineisto" < /opt/email-template.txt
        else 
            echo No new version of KokoSuomi_DIGIROAD_R_EUREF-FIN.zip found.
        fi
    echo Done
