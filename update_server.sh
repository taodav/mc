#!/usr/bin/env bash

# This script assumes you pass in the URL to the zip file containing the new bedrock server files.

MC_BEDROCK_URL=($1)
BEDROCK_SERVER_PATH="$HOME/server"

BEDROCK_ZIP_PATH="$HOME/bedrock_server.zip"

# Check if the session exists, discarding output
# We can check $? for the exit status (zero for success, non-zero for failure)
tmux has-session -t server 2>/dev/null

# If server session exists, kill it before updating
if [ $? != 0 ]; then
  tmux kill-session -t server
fi

if [ -z "$1" ]
  then
    echo "No Bedrock server URL supplied. Exiting."
    exit 0
fi

# Download the passed in URL to zip file
curl $MC_BEDROCK_URL --output $BEDROCK_ZIP_PATH

echo "Bedrock server zip downloaded from $MC_BEDROCK_URL to $BEDROCK_ZIP_PATH"

# Install unzip if we don't have it already
REQUIRED_PKG="unzip"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG
fi


# Unzip our file, output it to BEDROCK_SERVER_PATH
unzip $BEDROCK_ZIP_PATH -d $BEDROCK_SERVER_PATH

echo "Unzipped to $BEDROCK_SERVER_PATH"
