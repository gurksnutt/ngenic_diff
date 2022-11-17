# Ngenic diff
Simple shell script to monitor webpage for changes and notify user. Written to monitor stock of Ngenic at Tibber (https://tibber.com/) which been notoriously difficult to purchase. However the script could be applied for other static webpages to monitor change. 

### Description: 
Script to monitor webpage for change and notifies with Pushover for mobile notifications.
Initial creation of reference webpage, diff changes against it with push notice if changed.
Creates new refence webpage upon change to continue monitoring.
All actions are logged to local file, schedule run with crontab at desired interval.

### Usage:
*	Modify variables to reflect the <path> where you place logfiles and html dumps
*	Create Pushover account and a project to get a app token
*	Modify variables with your <app token> and <user token>
*	Schedule the script to run at desired interval, example for every minute: `*/1  * * * * /<path>/ngenic_diff.sh`

Use the Pushover app on your device of choice to get notified once changes occur on the monitored webpage. 
Best of luck!
