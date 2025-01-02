#!/usr/bin/env bash
set -eo pipefail

########################
# start of variables
requiredVariables=(
    GITCONFIG_EMAIL
    GITCONFIG_SIGNING_KEY
    GITHUB_PAT
    LOCALSTACK_PRO_TOKEN
)
unixTimestamp=$(date +%s)
dotfilesFolder="$HOME/.dotfiles"
dotFilesBackupLocation="$HOME/.dotfiles-backups"
variablesFile="$dotfilesFolder/variables"
scriptDir=$(dirname $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}"))
# end of variables
########################

function runForfile() {
    local sourceFile="$scriptDir/dotfiles/$1"
    local targetLocation="$2"
    if [[ ! "$sourceFile" = /* ]]; then echo "source file must be an absolute path"; exit 1; fi
    if [[ ! "$targetLocation" = /* ]]; then echo "target location must be an absolute path"; exit 1; fi

    backupFile "$targetLocation"
    envsubst < "$sourceFile" > "$targetLocation"
}

function backupFile() {
    local fileToBackup="$1"
    local fileName="$(basename "$fileToBackup")"
    local backupFilePath="$dotFilesBackupLocation/$fileName.$unixTimestamp"
    if [ -f "$fileToBackup" ]; then
        echoInfo "Backing up '$fileToBackup' to '$backupFilePath'"
        cp $targetLocation $backupFilePath
    fi
}

function echoInfo() {
    echo "$1"
}

function checkVariables() {
    if [ ! -f "$variablesFile" ]; then touch $variablesFile; fi
    source $variablesFile
    for requiredVariable in "${requiredVariables[@]}"; do
        if [[ -z "${!requiredVariable}" ]]; then
            echo "$requiredVariable environment variables is not set!"
            exit 1
        fi
    done
}

function main() {
    mkdir -p $dotfilesFolder
    mkdir -p $dotFilesBackupLocation

    checkVariables

    # run for files
    runForfile "gitconfig" "$HOME/.gitconfig"
    runForfile "gitignore" "$HOME/.gitignore"
    runForfile "vimrc" "$HOME/.vimrc"
    runForfile "aliases" "$dotfilesFolder/aliases"
    runForfile "exports" "$dotfilesFolder/exports"
    runForfile "secrets" "$dotfilesFolder/secrets"
    runForfile "my_zshrc" "$dotfilesFolder/my_zshrc"
    runForfile "aws_config" "$HOME/.aws/config"
    runForfile "gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"
    runForfile "gpg.conf" "$HOME/.gnupg/gpg.conf"
    runForfile "ssh_config" "$HOME/.ssh/config"
    runForfile "spaceshiprc.zsh" "$HOME/.spaceshiprc.zsh"
}

main