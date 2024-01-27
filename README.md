# Workstation Tools

This repository contains scripts to automate and speedup the workflow and preparation for my machine.

> **_Disclaimer_** :  
> Those scripts are ubuntu related with major version 18+, for other distributions you'll need to adapt it
___

## Prepare Workstation

> Read the `ubuntu.yml` file before applying and be sure to understand everything that will be done.

1. Install Ansible, unzip and git
```bash
sudo apt update && sudo apt install ansible unzip git -y
```
2. Clone this repository
```bash
git clone https://github.com/claytoncampos/projeto-linux-iac.git
```
3. Apply the configuration
```bash
ansible-playbook projeto-linux-iac/workstation_linux.yml --ask-become-pass
```
>Type your password when asked to give root permissions for some actions.
___

4. alternatively run the script ubuntu.automate.sh to create user, directories and workstation
```bash
sh projeto-linux-iac/ubuntu_automate.sh
```

5. Install zsh, OhMyZsha and plugins
```bash
sh projeto-linux-iac/install_zsh.sh
```


# Author Information
Created by [Clayton Campos](https://github.com/claytoncampos)

Contributions are more than welcome!
