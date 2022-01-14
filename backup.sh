#!/usr/bin/env bash

# ensure AWS CLI is installed

REQUIRED_PKG="awscli"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get update
  sudo apt-get --yes install $REQUIRED_PKG
  echo "Run aws configure before running this script again!"
  exit 0
fi

aws s3 cp --recursive ~/server s3://bedrock-1.18plus/

