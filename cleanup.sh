#!/usr/bin/env bash
set -eo pipefail

########################
# start of variables
dotFilesBackupLocation="$HOME/.dotfiles-backups"
# end of variables
########################

########################
# start of aux functions
function echoInfo() {
    echo -e "\033[34m■ $1\033[0m"
}

function echoSuccess() {
    echo -e "\033[32m✔ $1\033[0m"
}

function echoFatal() {
    echo -e "\033[31m✖ $1\033[0m"
}

function echoWarning() {
    echo -e "\033[33m! $1\033[0m"
}
# end of aux functions
########################

function main() {
    echoInfo "starting system cleanup" && echo ""

    rm -f $dotFilesBackupLocation/*
    brew cleanup

    echo "" && echoSuccess "system cleanup executed successfully"
}

main