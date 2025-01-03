#!/usr/bin/env bash
set -eo pipefail

########################
# start of variables
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
function installUpdateCasks() {
    brew upgrade --cask aws-vault
    brew upgrade --cask firefox
    brew upgrade --cask font-fira-code
    brew upgrade --cask iterm2
    brew upgrade --cask rancher
    brew upgrade --cask spotify
    brew upgrade --cask visual-studio-code
    brew upgrade --cask maccy
    brew upgrade --cask whatsapp
    brew upgrade --cask slack
    brew upgrade --cask discord
    brew upgrade --cask drawio
    brew upgrade --cask proton-mail
    brew upgrade --cask proton-pass
    brew upgrade --cask protonvpn
}

function installUpdateFormulas() {
    brew update
    brew upgrade coreutils
    brew upgrade pinentry-mac
    brew upgrade pre-commit
    brew upgrade fzf
    brew upgrade fluxcd/tap/flux
    brew upgrade awscli
    brew upgrade azure-cli
    brew upgrade kubernetes-cli
    brew upgrade kyverno
    brew upgrade chainsaw
    brew upgrade localstack/tap/localstack-cli
    brew upgrade vim
    brew upgrade ykman    
    brew upgrade yq    
    brew upgrade gnu-getopt
    brew upgrade gnupg
    brew upgrade helm
    brew upgrade k3d
    brew upgrade k9s
    brew upgrade jq
    brew upgrade pyenv
    brew upgrade starship
    brew upgrade opentofu
    brew upgrade pre-commit
    brew upgrade trivy
    brew upgrade operator-sdk
    brew upgrade packer
    brew upgrade go-task
}

function setupPython() {
    pyenv install 3.12 --skip-existing
    echoSuccess "python 3.12 installed successfully"
    pyenv install 3.13 --skip-existing
    echoSuccess "python 3.13 installed successfully"
    pyenv global 3.12
    echoSuccess "python 3.12 is now the default version"
}
# end of main methods
########################

function main() {
    echoInfo "starting reconciling configurations" && echo ""

    installUpdateFormulas
    installUpdateCasks
    setupPython   
    
    echo "" && echoSuccess "configurations reconciled successfully"
}

main