# Written to monitor when Ngenic comes in to stock at Tibber store
# Script that monitors webpage for change and notifies with pushover for mobile notifications.
# Initial creation of reference webpage, diff changes against it with push notice if changed.
# Creates new refence webpage upon change to continue monitoring.
# All actions are logged to local file, schedule run with crontab at desired interval recommended once per minute.
# Crontab syntax: */1  * * * * /<path>/ngenic_diff.sh 
