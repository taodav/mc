# mc
minecraft server for the frens

To get `start.sh` running on reboot, make sure you do the following:
```
crontab -e
```
then when editing the cron job, add the line
```
@reboot ./~/mc/start.sh
```
