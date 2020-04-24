#!/bin/bash
##--------------------------------------------------- VARIÁVEIS -------------------------------------------------##
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_STEAM="https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
URL_VIRTUAL_BOX="https://download.virtualbox.org/virtualbox/6.1.4/virtualbox-6.1_6.1.4-136177~Ubuntu~bionic_amd64.deb"
URL_MINECRAFT="https://launcher.mojang.com/download/Minecraft.deb"
URL_TELEGRAM="https://telegram.org/dl/desktop/linux"
URL_TEMAS_MINT="https://github.com/MrFYou/Themes_of_Linux_Mint/archive/master.zip"
URL_DISCORD="https://dl.discordapp.net/apps/linux/0.0.10/discord-0.0.10.deb"
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
## --------------------------------------------------------------------------------------------------------------------##

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando arquitetura de 32 bits ##

##Adicionando repositorios e PPAs##

##Removendo pacotes pre-instalados##
sudo apt remove firefox -y

##Escolhendo interface##
aux=1
until [ $aux -eq 0 ]
do
    echo -n "Qual interface instalar? 0 - Ubuntu, 1 - Gnome, 2 - Cinnamon: "
    read resposta
    case "$resposta" in
     0|"Ubuntu"|"ubuntu"|"")
            aux=$[ $aux - 1]
     ;;
      1|"Gnome"|"gnome")
            aux=$[ $aux - 1]
            sudo apt remove ubuntu-session -y
            sudo apt install gnome-session gnome-shell gnome-terminal gnome-software gdm3 gnome-tweaks gnome-shell-extensions -y
            sudo snap remove snap-store
     ;;
     2|"Cinnamon"|"cinnamon")
            aux=$[ $aux - 1]
            sudo apt remove gnome-shell gdm3 nautilus gnome-startup-applications gnome-control-center gnome-font-viewer yelp im-config -y
            sudo apt install lightdm lightdm-settings slick-greeter redshift redshift-gtk samba cinnamon -y
     ;;
      *)
            echo "Opção inválida"
     ;;
    esac
done

##Instalando Temas e icones do Linux Mint##
sudo wget -c "$URL_TEMAS_MINT"       -P "$DIRETORIO_DOWNLOADS"
sudo unzip $DIRETORIO_DOWNLOADS/master.zip -d $DIRETORIO_DOWNLOADS
sudo cp -r $DIRETORIO_DOWNLOADS/Themes_of_Linux_Mint-master/icons /usr/share/
sudo cp -r $DIRETORIO_DOWNLOADS/Themes_of_Linux_Mint-master/themes /usr/share/

## Download de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_STEAM"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VIRTUAL_BOX"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DISCORD"       -P "$DIRETORIO_DOWNLOADS"

##Instalando pacotes apt##
sudo apt install flatpak -y
sudo apt install git -y
sudo apt install gedit -y
sudo apt install transmission -y
sudo apt install nano -y
sudo apt install synaptic -y
sudo apt install usb-creator-gtk -y ##Criador de discos de inicalização##
sudo apt install p7zip p7zip-full p7zip-rar -y ##Suporte para arquivos .7z e .rar##

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

##Limpar e atualizar##
sudo rm -r $DIRETORIO_DOWNLOADS
sudo apt update
sudo apt autoremove -y
sudo apt upgrade -y

##reiniciar##
aux=1
until [ $aux -eq 0 ]
do
    echo -n "Dejesa reiniciar agora? (S/N): "
    read resposta
    case "$resposta" in
     "S"|"s"|"Y"|"y"|"sim"|"Sim"|"Yes"|"yes"|"")
            aux=$[ $aux - 1]
            sudo reboot
     ;;
     2|"N"|"n"|"Nao"|"nao"|"no"|"No")
            aux=$[ $aux - 1]
     ;;
      *)
            echo "Opção inválida"
     ;;
    esac
done