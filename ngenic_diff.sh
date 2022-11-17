#!/bin/bash
# Written to monitor when Ngenic comes in to stock at Tibber store
# Script that monitors webpage for change and notifies with pushover for mobile notifications.
# Initial creation of reference webpage, diff changes against it with push notice if changed.
# Creates new refence webpage upon change to continue monitoring.
# All actions are logged to local file, schedule run with crontab at desired interval recommended once per minute.
# Crontab syntax: */1  * * * * /<path>/ngenic_diff.sh 
# Stefan B 2022-10-29
LOG_FILE="ngenic_diff.log"
exec 3>&1 1>>${LOG_FILE} 2>&1
TIME_STAMP=$(date '+%d/%m/%Y %H:%M:%S')
MESSAGE="Tibbers Ngenic sida har ändrats!"
TITLE="Ngenic"
APP_TOKEN="<insert your pushover app token>"
USER_TOKEN="<insert your pushover user token>"

WEB_PAGE="https://tibber.com/se/store/produkt/ngenic-tune-smart-termostat"
REF_HTML=/<path>/ref_ngenic.html
COMPARE_HTML=/<path>/compare_ngenic.html
if test -f "$REF_HTML"; then
        w3m -dump $WEB_PAGE > $COMPARE_HTML
        diff -s $REF_HTML $COMPARE_HTML > /dev/null
        if [ $? -eq 0 ]; then
                echo "$TIME_STAMP" "No changes on webpage" 1>&2
        else
                echo "$TIME_STAMP" "Webpage changed!" 1>&2
                wget https://api.pushover.net/1/messages.json --post-data="token=$APP_TOKEN&user=$USER_TOKEN&message=$MESSAGE&title=$TITLE" -qO- > /dev/null 2>&1 &
        echo "$TIME_STAMP" "Generating new reference HTML to find changes" 1>&2
        w3m -dump $WEB_PAGE > $REF_HTML

        fi
else
        w3m -dump $WEB_PAGE > $REF_HTML
        w3m -dump $WEB_PAGE > $COMPARE_HTML
        echo "$TIME_STAMP" "Generating reference and compare HTML to find future changes" 1>&2
fi
