# dotfiles

This repository centralizes configurations to be shared across multiple devices.

## Usage

First, add the following block at the top of ~/.zshrc:
```bash
##############################
# start custom dotfiles
if [ -f $HOME/.dotfiles/my_zshrc ]; then source $HOME/.dotfiles/my_zshrc; fi
# end custom dotfiles
##############################
```

Second, execute the following command>
```bash 
bash setup.sh
```
This will generate and distribute the `dotfiles` and other configuration files to the appropriate locations. If an error occurs complaining about a missing environment variables, it means some required variable is not properly filled at ```$HOME/.dotfiles/variables```.