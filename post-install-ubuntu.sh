#!/usr/bin/env bash
##--------------------------------------------------- VARIÁVEIS -------------------------------------------------##
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_STEAM="https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
URL_VIRTUAL_BOX="https://download.virtualbox.org/virtualbox/6.1.4/virtualbox-6.1_6.1.4-136177~Ubuntu~bionic_amd64.deb"
URL_MINECRAFT="https://launcher.mojang.com/download/Minecraft.deb"
URL_TELEGRAM="https://telegram.org/dl/desktop/linux"
URL_TEMAS_MINT="https://github.com/MrFYou/Themes_of_Linux_Mint/archive/master.zip"
URL_DISCORD="https://dl.discordapp.net/apps/linux/0.0.10/discord-0.0.10.deb"
URL_MINECRAFT_BEDROCK1="https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/amd64.ubuntu.20.04/mcpelauncher-client-45f9d98-Linux.deb"
URL_MINECRAFT_BEDROCK2="https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/amd64.ubuntu.20.04/mcpelauncher-core-45f9d98-Linux.deb"
URL_MINECRAFT_BEDROCK3="https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/amd64.ubuntu.20.04/mcpelauncher-ui-qt-8b7543e-Linux.deb"
URL_MINECRAFT_BEDROCK4="https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/amd64.ubuntu.20.04/msa-daemon-029fde6-Linux.deb"
URL_MINECRAFT_BEDROCK5="https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/amd64.ubuntu.20.04/msa-ui-qt-029fde6-Linux.deb"
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
## --------------------------------------------------------------------------------------------------------------------##

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386 ##Dependencia Minecraft-bedrock##

##Removendo pacotes pre-instalados##
sudo apt remove firefox gnome-shell gdm3 nautilus gnome-startup-applications gnome-control-center gnome-font-viewer yelp im-config -y

##Adicionando repositorios e PPAs##


## Download de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_STEAM"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VIRTUAL_BOX"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DISCORD"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT_BEDROCK1"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT_BEDROCK2"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT_BEDROCK3"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT_BEDROCK4"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT_BEDROCK5"       -P "$DIRETORIO_DOWNLOADS"

##Instalando pacotes apt##
sudo apt install flatpak -y
sudo apt install git -y
sudo apt install gedit -y
sudo apt install winff -y
sudo apt install transmission -y
sudo apt install nano -y
sudo apt install redshift redshift-gtk -y
sudo apt install lightdm lightdm-settings slick-greeter -y
sudo apt install synaptic -y
sudo apt install usb-creator-gtk -y ##Criador de discos de inicalização##
sudo apt install libc6-i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 pulseaudio libegl1-mesa-dev:i386 -y ##Dependencias Minecraft-bedrock##
sudo apt install p7zip p7zip-full p7zip-rar -y ##Suporte para arquivos .7z e .rar##
sudo apt install cinnamon -y
sudo apt install samba -y

##Instalando Temas e icones do Linux Mint##
sudo wget -c "$URL_TEMAS_MINT"       -P "$DIRETORIO_DOWNLOADS"
sudo unzip $DIRETORIO_DOWNLOADS/master.zip -d $DIRETORIO_DOWNLOADS
sudo cp -r $DIRETORIO_DOWNLOADS/Themes_of_Linux_Mint-master/icons /usr/share/
sudo cp -r $DIRETORIO_DOWNLOADS/Themes_of_Linux_Mint-master/themes /usr/share/

## Instalando pacotes .deb baixados##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

##Consertando dependencias faltando/quebradas##
sudo apt --fix-broken install -y

##Instalando Telegram##
cd "$DIRETORIO_DOWNLOADS"
wget -c "$URL_TELEGRAM" -O telegram.tar.xz
sudo tar Jxf $DIRETORIO_DOWNLOADS/telegram.tar.xz -C /opt/
sudo ln -sf /opt/Telegram/Telegram /usr/bin/Telegram
echo -e '[Desktop Entry]\n Version=1.0\n Exec=/opt/Telegram/Telegram\n Icon=Telegram\n Type=Application\n Categories=Application;Network;' | sudo tee /usr/share/applications/telegram.desktop
sudo chmod +x /usr/share/applications/telegram.desktop
cd ~

##Instalando asdf-vm##
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.7
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
sudo apt install automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev unzip curl -y

## Instalando pacotes Snap ##
sudo snap install spotify
sudo snap install photogimp
sudo snap install vlc
sudo snap install code --classic ##Visual-Studio-Code##

## Instalando pacotes Flatpak ##
sudo flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref -y ##GIMP##
sudo flatpak install https://flathub.org/repo/appstream/com.github.maoschanz.drawing.flatpakref -y ##drawing##

##Limpar, atualizar e reiniciar##
sudo rm -r $DIRETORIO_DOWNLOADS
sudo apt update
sudo apt autoremove -y
sudo apt upgrade -y
sudo reboot