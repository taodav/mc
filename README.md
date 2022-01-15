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

### ADDITIONAL STUFF
To set yourself as OP, get your `xuid` from the server logs, then in `permissions.json` under the server folder, add the following:
```
[
  {
"permission": "operator",
"xuid": "xxxxxxxx"
}
]
```

#### IAM access for other users to start/stop server
If you're launching a new instance, set a IAM policy as follows:
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:PassRole",
                "ec2:Describe*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "ec2:RebootInstances",
                "ec2:StartInstances",
                "ec2:StopInstances"
            ],
            "Resource": "arn:aws:ec2:<REGION>:<ACCOUNT_ID>:instance/<INSTANCE_ID>"
        }
    ]
}
```
TODO: backup on system shutdown.
