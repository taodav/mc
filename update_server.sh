#!/usr/bin/env bash

MC_BEDROCK_URL=($1)

curl $MC_BEDROCK_URL --output $HOME/
echo $MC_BEDROCK_URL
echo $HOME