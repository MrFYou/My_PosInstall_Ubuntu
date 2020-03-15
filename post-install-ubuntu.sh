#!/usr/bin/env bash
##--------------------------------------------------- VARIÁVEIS -------------------------------------------------##
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_STEAM="https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
URL_VIRTUAL_BOX="https://download.virtualbox.org/virtualbox/6.1.4/virtualbox-6.1_6.1.4-136177~Ubuntu~bionic_amd64.deb"
URL_MINECRAFT="https://launcher.mojang.com/download/Minecraft.deb"
URL_TEMAS_MINT="https://github.com/MrFYou/Themes_of_Linux_Mint/archive/master.zip"
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
## --------------------------------------------------------------------------------------------------------------------##

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386 ##Minecraft-bedrock##

##Removendo pacotes pre-instalados##
sudo apt remove firefox -y

##Adicionando repositorios e PPAs##
wget -O - https://mcpelauncher.mrarm.io/apt/conf/public.gpg.key | sudo apt-key add - ##Minecraft-bedrock##
sudo add-apt-repository 'deb http://mcpelauncher.mrarm.io/apt/ubuntu/ bionic main' ##Minecraft-bedrock##
sudo add-apt-repository ppa:embrosyn/cinnamon -y ##Cinnamon##

## Download de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_STEAM"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VIRTUAL_BOX"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT"       -P "$DIRETORIO_DOWNLOADS"

##Instalando pacotes apt##
sudo apt install flatpak vlc git vim winff transmission cinnamon msa-daemon msa-ui-qt mcpelauncher-client mcpelauncher-ui-qt libegl1-mesa:i386 libegl1-mesa-dev:i386 -y

##Instalando Temas e icones do Linux Mint##
sudo wget -c "$URL_TEMAS_MINT"       -P "$DIRETORIO_DOWNLOADS"
sudo unzip $DIRETORIO_DOWNLOADS/master.zip -d $DIRETORIO_DOWNLOADS
sudo cp -r $DIRETORIO_DOWNLOADS/Themes_of_Linux_Mint-master/icons /usr/share/
sudo cp -r $DIRETORIO_DOWNLOADS/Themes_of_Linux_Mint-master/themes /usr/share/

## Instalando pacotes .deb baixados##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

##Consertando dependencias faltando/quebradas##
sudo apt --fix-broken install -y

##Instalando asdf-vm##
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.7
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
sudo apt install automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev unzip curl -y

## Instalando pacotes Snap ##
snap install spotify
snap install photogimp
snap install telegram-desktop
snap install code --classic ##Visual-Studio-Code##

## Instalando pacotes Flatpak ##
sudo flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref -y ##GIMP##

##Limpeza a atualização##
sudo rm -r $DIRETORIO_DOWNLOADS
sudo apt autoremove -y
sudo apt upgrade -y
