#!/bin/bash
echo 'INICIANDO INSTALACAO ZSH E OH MY ZSH'
echo 'Realizando update e upgrade do sistema'
sudo apt update && sudo apt upgrade
echo 'Update e Upgrade Finaliado'
echo 'Instalando ZSH'
sudo apt install zsh
echo 'Configurando o terminal zsh como default.'
chsh -s $(which zsh)
echo 'Instalando Oh My Zsh'
sudo apt install curl git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 'INSTALANDO Plugins do ZSH'
echo 'Instalando o zinit'
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
echo 'Adicionando os plugins no zsh'
echo 'zinit light zdharma-continuum/fast-syntax-highlighting' >> ~/.zshrc
echo 'zinit light zsh-users/zsh-autosuggestions' >> ~/.zshrc
echo 'zinit light zsh-users/zsh-completions' >> ~/.zshrc
echo 'INSTALANDO Nerd e fira Code FONTES'
mkdir ~/.fonts
wget -P ~/.fonts 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/BitstreamVeraSansMono.zip'
unzip ~/.fonts/BitstreamVeraSansMono.zip -d ~/.fonts
sudo apt install fonts-firacode
echo 'Instalando o thema powerlevel10k'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cat ~/.zshrc | grep '^ZSH_THEME=' | sed 's/robbyrussell/powerlevel10k\/powerlevel10k/' -i ~/.zshrc
echo 'Instalacao finalizada - Reinicie o terminal \n se Quizer configurar o thema use "pk10 configure"'
