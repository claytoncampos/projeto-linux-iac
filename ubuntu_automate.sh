#!/bin/bash
echo '================================='
echo 'Starting custom machine creation.'
echo '================================='
echo ''
echo 'Creating directories...'
mkdir /adm
mkdir /conv
mkdir /publico

echo 'Creating users group...'
groupadd GRP_ADM
groupadd GRP_CONV

echo 'Creating users'
useradd clay -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
useradd convidado -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_CONV

echo 'Specifying directories permission...'
chown root:GRP_ADM /adm
chown root:GRP_CONV /conv

echo 'Setting permissions...'
chmod 770 /adm
chmod 770 /conv
chmod 777 /publico

echo 'Starting update of repositories and creation of the environment'
sudo apt update -y

echo 'Install Git Ansible and Unzip'
sudo apt install git ansible unzip -y

echo 'clonando repositorio de automatizacao do github'
git clone https://github.com/claytoncampos/projeto-linux-iac.git

echo 'Creation of the enviroment initiated wich Ansible - Please wait'
ansible-playbook projeto-linux-iac/ubuntu.yml --ask-become-pass
echo '====================================='
echo 'Creatinon of the finished environment'
echo '====================================='
