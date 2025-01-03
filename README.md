# dotfiles

This repository centralizes configurations to be shared across multiple devices.

## Usage

### dotfiles and configurations

First, add the following block at the top of ~/.zshrc:
```bash
##############################
# start custom dotfiles
if [ -f $HOME/.dotfiles/my_zshrc.autogenerated ]; then source $HOME/.dotfiles/my_zshrc.autogenerated; fi
# end custom dotfiles
##############################
```

Second, execute the following command:
```bash
bash setup.sh
```
This will generate and distribute the `dotfiles` and other configuration files to the appropriate locations. If an error occurs complaining about a missing environment variables, it means some required variable is not properly filled at ```$HOME/.dotfiles/variables```.

### Install applications
There is also a script to install applications and common settings. Run:
```bash
bash reconcile.sh
```

to install/upgrade existing apps as well as setup some sensible defaults on them.
