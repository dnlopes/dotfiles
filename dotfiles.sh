#!/usr/bin/env bash
set -eo pipefail

########################
# start of variables
requiredVariables=(
    DOTFILES_GITCONFIG_EMAIL
    DOTFILES_GITCONFIG_SIGNING_KEY
    DOTFILES_GITHUB_PAT
    DOTFILES_LOCALSTACK_PRO_TOKEN
    DOTFILES_YUBIKEY_MFA_DEVICE_NAME
    DOTFILES_YUBIKEY_SERIAL_NUMBER
    DOTFILES_SSHCONFIG_GITHUB_IDENTITY_FILE_NAME
)
unixTimestamp=$(date +%s)
dotfilesFolder="$HOME/.dotfiles"
dotFilesBackupLocation="$HOME/.dotfiles-backups"
variablesFile="$dotfilesFolder/variables"
scriptDir=$(dirname $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}"))
autoCompletesFile="$HOME/.dotfiles/auto-completes.autogenerated"

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

########################
# start of main methods
function replaceVariablesAndCopyFile() {
    local sourceFile="$scriptDir/dotfiles/$1"
    local targetLocation="$2"
    if [[ ! "$sourceFile" = /* ]]; then echoFatal "source file must be an absolute path"; exit 1; fi
    if [[ ! "$targetLocation" = /* ]]; then echoFatal "target location must be an absolute path"; exit 1; fi

    backupFile "$targetLocation"
    envsubst < "$sourceFile" > "$targetLocation"
    echoSuccess "generated and copied file '$sourceFile' to '$targetLocation'"
}

function copyFile() {
    local sourceFile="$scriptDir/dotfiles/$1"
    local targetLocation="$2"
    if [[ ! "$sourceFile" = /* ]]; then echoFatal "source file must be an absolute path"; exit 1; fi
    if [[ ! "$targetLocation" = /* ]]; then echoFatal "target location must be an absolute path"; exit 1; fi

    backupFile "$targetLocation"
    cp "$sourceFile" "$targetLocation"
    echoSuccess "copied '$sourceFile' to '$targetLocation'"
}

function backupFile() {
    local fileToBackup="$1"
    local fileName="$(basename "$fileToBackup")"
    local backupFilePath="$dotFilesBackupLocation/$fileName.$unixTimestamp"
    if [ -f "$fileToBackup" ]; then
        cp $targetLocation $backupFilePath
        echoInfo "backed up file '$fileToBackup' to '$backupFilePath'"
    fi
}

function checkVariables() {
    local hasMissingVariables="false"
    if [ ! -f "$variablesFile" ]; then touch $variablesFile; fi
    source $variablesFile

    for requiredVariable in "${requiredVariables[@]}"; do
        if [[ -z "${!requiredVariable}" ]]; then
            hasMissingVariables="true"
            echoWarning "environment variable '$requiredVariable' not set"

            # fill a placeholder for the missing variable
            if ! grep -q "$requiredVariable" "$variablesFile"; then
                echo "export $requiredVariable=\"\"" >> $variablesFile
            fi
        fi
    done

    if [ "$hasMissingVariables" = "true" ]; then
        echoFatal "set the required environment variables at file '$variablesFile' before proceeding"
        exit 1
    fi
}

function setupAutoCompletes() {
    rm -f $autoCompletesFile
    touch $autoCompletesFile
    curl -fs "https://raw.githubusercontent.com/99designs/aws-vault/master/contrib/completions/zsh/aws-vault.zsh" >> $autoCompletesFile
}
# end of main methods
########################


function main() {
    echoInfo "starting distributing dotfiles and common configurations" && echo ""
    mkdir -p $dotfilesFolder
    mkdir -p $dotFilesBackupLocation
    checkVariables

    setupAutoCompletes

    # replace variables and copy files
    replaceVariablesAndCopyFile "gitconfig" "$HOME/.gitconfig"
    replaceVariablesAndCopyFile "aws_config" "$HOME/.aws/config"
    replaceVariablesAndCopyFile "ssh_config" "$HOME/.ssh/config"
    replaceVariablesAndCopyFile "exports" "$dotfilesFolder/exports.autogenerated"
    replaceVariablesAndCopyFile "secrets" "$dotfilesFolder/secrets.autogenerated"

    # copy files as is
    copyFile "my_zshrc" "$dotfilesFolder/my_zshrc.autogenerated"
    copyFile "gitignore" "$HOME/.gitignore"
    copyFile "vimrc" "$HOME/.vimrc"
    copyFile "aliases" "$dotfilesFolder/aliases.autogenerated"
    copyFile "gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"
    copyFile "gpg.conf" "$HOME/.gnupg/gpg.conf"
    copyFile "starship.toml" "$dotfilesFolder/starship.toml.autogenerated"

    cp $scriptDir/Taskfile.yaml $HOME/Taskfile.yaml
    echoSuccess "copied 'Taskfile.yaml' to '$HOME/Taskfile.yaml'"

    echo "" && echoSuccess "dotfiles and common configurations distributed successfully"

}

main