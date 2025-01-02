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
    brew install --cask aws-vault
    brew install --cask firefox
    brew install --cask font-fira-code
    brew install --cask iterm2
    brew install --cask rancher
    brew install --cask spotify
    brew install --cask visual-studio-code
    brew install --cask maccy
}

function installUpdateFormulas() {
    #brew update
    brew install coreutils
    brew install pinentry-mac
    brew install pre-commit
    brew install fzf
    brew install fluxcd/tap/flux
    brew install awscli
    brew install azure-cli
    brew install kubernetes-cli
    brew install kyverno
    brew install chainsaw
    brew install localstack
    brew install vim
    brew install ykman    
    brew install yq    
    brew install gnu-getopt
    brew install gnupg
    brew install helm
    brew install k3d
    brew install k9s
    brew install jq
    brew install pyenv
    brew install starship
    brew install opentofu
    brew install pre-commit
    brew install trivy
    brew install operator-sdk
    brew install packer
}
# end of main methods
########################


function main() {
    echoInfo "starting reconciling configurations" && echo ""

    installUpdateFormulas
    installUpdateCasks

    pyenv install 3.12 --skip-existing
    pyenv install 3.13 --skip-existing
    pyenv global 3.12
    
    echo "" && echoSuccess "configurations reconciled successfully"
}

main