#!/usr/bin/env bash

SERVER_PATH="$HOME/server"
SERVER_SCRIPT="$SERVER_PATH/bedrock_server"

if [ ! -d "$SERVER_PATH" ]; then
    echo "$SERVER_PATH does not exist. Run ./update_server BEDROCK_URL first."
    exit 0
fi



if [ ! -f "$SERVER_SCRIPT" ]; then
    echo "$SERVER_SCRIPT does not exist, for some reason???"
    exit 0
fi

echo "Starting server from $SERVER_SCRIPT"
tmux new-session -d -s server
tmux send-keys -t server "cd $SERVER_PATH" C-m
tmux send-keys -t server "LD_LIBRARY_PATH=. ./bedrock_server" C-m


