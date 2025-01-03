#!/usr/bin/env bash
set -eo pipefail

# source: https://github.com/99designs/aws-vault/blob/master/USAGE.md#using-a-yubikey

########################
# start of variables
awsRootAccountId="156589501431"
deviceName=""
# end of variables
########################

read -p "Enter device name: " deviceName
if [ -z "$deviceName" ]; then echo "device name cannot be empty" && echo ""; exit 1; fi

ykman oath accounts add arn:aws:iam::$awsRootAccountId:mfa/$deviceName
ykman oath accounts rename arn:aws:iam::$awsRootAccountId:mfa/$deviceName $deviceName
#ykman oath accounts code $deviceName