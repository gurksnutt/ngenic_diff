#!/bin/bash
LOG_FILE="/<path>/ngenic_diff.log"
exec 3>&1 1>>${LOG_FILE} 2>&1
TIME_STAMP=$(date '+%d/%m/%Y %H:%M:%S')
MESSAGE="Tibbers Ngenic page has changed!"
TITLE="Ngenic"
APP_TOKEN="<app token>"
USER_TOKEN="<user token>"

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
