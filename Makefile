SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec
.DEFAULT_GOAL := help
PROJECT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Targets
.PHONY: dotfiles
dotfiles: ## distributes dotfiles
	bash dotfiles.sh

.PHONY: setup
setup: ## install/update software and configurations
	bash setup-system.sh

.PHONY: cleanup
cleanup: ## cleanup system
	bash cleanup.sh

.PHONY: all
all: setup dotfiles cleanup ## setup, dotfiles, and cleanup

##@ System Management
register-yubikey-oath: ## register a yubikey oath device on the root account
	bash ./scripts/register-yubikey-oath.sh
