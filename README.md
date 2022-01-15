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
You also have to ensure that the correct ports are open, both from the server side of things and AWS.

In the server:
```
sudo ufw allow 19132/udp
sudo ufw allow OpenSSH
sudo ufw enable
```

On the AWS side of things, in the EC2 instance panel, go to Security -> click the security group your EC2 instance is linked to -> Edit inbound rules -> Add rule

The rule you'll be adding is:
Type: Custom UDP
Port range: 19132
Address: 0.0.0.0/0

Then you should be good to go!

TODO: backup on system shutdown.
