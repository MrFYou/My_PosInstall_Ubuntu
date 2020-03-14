#!/usr/bin/env bash
##--------------------------------------------------- VARIÁVEIS -------------------------------------------------##
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_STEAM="https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
URL_VIRTUAL_BOX="https://download.virtualbox.org/virtualbox/6.1.4/virtualbox-6.1_6.1.4-136177~Ubuntu~bionic_amd64.deb"
URL_MINECRAFT="https://launcher.mojang.com/download/Minecraft.deb"
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
## --------------------------------------------------------------------------------------------------------------------##

##------------------------------------------------ COMANDOS COMENTADOS -------------------------------------------------##
## Removendo travas eventuais do apt ##
##sudo rm /var/lib/dpkg/lock-frontend##
##sudo rm /var/cache/apt/archives/lock##
#-------------------------------------------------------------------------------------------------------------------------#

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

##Removendo pacotes pre-instalados##
sudo apt remove firefox -y

##Adicionando repositorios e PPAs##
wget -O - https://mcpelauncher.mrarm.io/apt/conf/public.gpg.key | sudo apt-key add -
sudo add-apt-repository 'deb http://mcpelauncher.mrarm.io/apt/ubuntu/ bionic main'
sudo add-apt-repository ppa:embrosyn/cinnamon -y

## Download de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_STEAM"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VIRTUAL_BOX"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT"       -P "$DIRETORIO_DOWNLOADS"

##Instalando pacotes apt##
sudo apt install flatpak vlc git vim winff cinnamon msa-daemon msa-ui-qt mcpelauncher-client mcpelauncher-ui-qt libegl1-mesa:i386 libegl1-mesa-dev:i386 -y

## Instalando pacotes Snap ##
sudo snap install spotify
sudo snap install photogimp
sudo snap install telegram-desktop
sudo snap install code

## Instalando pacotes Flatpak ##
flatpak install flathub org.gimp.GIMP/x86_64/stable -y

## Instalando pacotes .deb baixados##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

## Finalização e limpeza##
sudo rm -r $DIRETORIO_DOWNLOADS
sudo apt upgrade -y
sudo apt autoclean -y
sudo apt autoremove -y
