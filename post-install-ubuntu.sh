#!/bin/bash
##--------------------------------------------------- VARIÁVEIS -------------------------------------------------##
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_STEAM="https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
URL_MINECRAFT="https://launcher.mojang.com/download/Minecraft.deb"
URL_TELEGRAM="https://telegram.org/dl/desktop/linux"
URL_TEMAS_MINT="https://github.com/MrFYou/Themes_of_Linux_Mint/archive/master.zip"
URL_DISCORD="https://dl.discordapp.net/apps/linux/0.0.11/discord-0.0.11.deb"
URL_STREMIO="https://dl.strem.io/shell-linux/v4.4.116/stremio_4.4.116-1_amd64.deb"
URL_VIRUTALBOX="https://download.virtualbox.org/virtualbox/6.1.14/virtualbox-6.1_6.1.14-140239~Ubuntu~eoan_amd64.deb"
URL_VISUALSTUDIOCODE="https://az764295.vo.msecnd.net/stable/a0479759d6e9ea56afa657e454193f72aef85bd0/code_1.48.2-1598353430_amd64.deb"
## --------------------------------------------------------------------------------------------------------------------##

mkdir "$DIRETORIO_DOWNLOADS"

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

##Adicionando repositorios e PPAs##


##Removendo pacotes pre-instalados##


##Escolhendo interface##
aux=1
until [ $aux -eq 0 ]
do
    echo -n "Qual interface instalar? Ubuntu, Gnome ou Cinnamon: "
    read resposta
    case "$resposta" in
     "Ubuntu"|"ubuntu")
              aux=$[ $aux - 1]
              sudo apt install menulibre gnome-tweaks gnome-system-tools gnome-shell-extensions -y
     ;;
      "Gnome"|"gnome")
            aux=$[ $aux - 1]
            sudo apt remove ubuntu-session -y
            sudo apt install gnome-session menulibre gnome-shell gnome-terminal gnome-software-plugin-flatpak gnome-system-tools gnome-software gdm3 gnome-tweaks gnome-shell-extensions -y
            sudo snap remove snap-store
     ;;
     "Cinnamon"|"cinnamon")
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
##sudo wget -c "$URL_TEMAS_MINT"       -P "$DIRETORIO_DOWNLOADS"##
##sudo unzip $DIRETORIO_DOWNLOADS/master.zip -d $DIRETORIO_DOWNLOADS##
##sudo cp -r $DIRETORIO_DOWNLOADS/Themes_of_Linux_Mint-master/icons /usr/share/##
##sudo cp -r $DIRETORIO_DOWNLOADS/Themes_of_Linux_Mint-master/themes /usr/share/##

## Download de programas externos ##
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_STEAM"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINECRAFT"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DISCORD"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_STREMIO"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VIRUTALBOX"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VISUALSTUDIOCODE"       -P "$DIRETORIO_DOWNLOADS"

##OBS Studio##
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt update
sudo apt install obs-studio ffmpeg -y


##WINE##
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' -y
sudo apt update
sudo apt install --install-recommends winehq-stable -y


##Instalando pacotes apt##
sudo apt install flatpak -y
sudo apt install git -y
sudo apt install gedit -y
sudo apt install transmission -y
sudo apt install nano -y
sudo apt install curl -y
sudo apt install synaptic -y
sudo apt install p7zip p7zip-full p7zip-rar -y ##Suporte para arquivos .7z e .rar##

## Instalando pacotes .deb baixados##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
sudo apt --fix-broken install -y ##Consertando dependencias faltando/quebradas##

##Telegram##
cd "$DIRETORIO_DOWNLOADS"
wget -c "$URL_TELEGRAM" -O telegram.tar.xz
sudo tar Jxf $DIRETORIO_DOWNLOADS/telegram.tar.xz -C /opt/
sudo ln -sf /opt/Telegram/Telegram /usr/bin/Telegram
echo -e '[Desktop Entry]\n Version=1.0\n Exec=/opt/Telegram/Telegram\n Name=Telegram\n Icon=Telegram\n Type=Application\n Categories=Application;Network;' | sudo tee /usr/share/applications/telegram.desktop
sudo chmod +x /usr/share/applications/telegram.desktop
cd ~

##asdf-vm##
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0-rc1
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
sudo apt install automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev unzip curl -y

##Instalando pacotes Snap ##
sudo snap install spotify
sudo snap install photogimp
sudo snap install authy --beta

##Instalando pacotes Flatpak ##
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub org.gimp.GIMP -y ##GIMP##
sudo flatpak install flathub org.videolan.VLC -y ##VLC##
sudo flatpak install flathub org.tlauncher.TLauncher -y ##Tlauncher##

##Limpar e atualizar##
sudo rm -r $DIRETORIO_DOWNLOADS
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

##reiniciar##
aux=1
until [ $aux -eq 0 ]
do
    echo -n "Dejesa reiniciar agora? (S/N): "
    read resposta
    case "$resposta" in
     "S"|"s"|"Y"|"y"|"sim"|"Sim"|"Yes"|"yes")
            aux=$[ $aux - 1]
            sudo reboot
     ;;
     "N"|"n"|"Nao"|"nao"|"no"|"No")
            aux=$[ $aux - 1]
     ;;
      *)
            echo "Opção inválida"
     ;;
    esac
done