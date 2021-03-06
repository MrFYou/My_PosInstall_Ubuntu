#!/bin/bash
##--------------------------------------------------- VARIÁVEIS -------------------------------------------------##
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_STEAM="https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
URL_MINECRAFT="https://launcher.mojang.com/download/Minecraft.deb"
URL_TELEGRAM="https://telegram.org/dl/desktop/linux"
URL_MINT_THEME="https://nccrzw.bn.files.1drv.com/y4munJH7VUbkpc58Jt1b2krvC0LsHNar602vK4DFmRdg85RaqHvEdQezeeIoR_4SliWgEhD_LNhcECiZxroMr-Ddg4HTbFq51zDwPMKFrNQpgqY_T_l5PcmvuCz8BWlpoHir3-hG4dKVMhyT2HSfg3R9AEgZ36edeFkCTHztLB5jrBQ0As6so_58Brf7PAt0rK31ak7p8gPfhoL9bTSmkv_0Q"
URL_YARU_COLORS="https://github.com/Jannomag/Yaru-Colors/releases/download/20.04.5/Complete-Yaru-Colors-20.04.5.tar.xz"
URL_MACOS_THEME="https://cvel2q.bn.files.1drv.com/y4mcQBCjVM_v8hkHm1-Upl6rgjhoFRWOdSvUcQqo9QMqQNSI-qhqpOr_iOl6k92rJxTO5KZ6fISeQbmuM8JuS7LEmRc3wU3WoVJAyDYdrqh82tqW5oQmkxM_1cZKT2ol9Q5DvY8VeBWbxhrc3iw4ve5GcRj2YbOstC_rnmnG5wZvygow3p2-SoVoV4sOAt0KLMBEuKqrf38zBkd8YQ92pQ5PQ"
URL_DISCORD="https://dl.discordapp.net/apps/linux/0.0.12/discord-0.0.12.deb"
URL_STREMIO="https://dl.strem.io/shell-linux/v4.4.116/stremio_4.4.116-1_amd64.deb"
URL_VIRUTALBOX="https://download.virtualbox.org/virtualbox/6.1.14/virtualbox-6.1_6.1.14-140239~Ubuntu~eoan_amd64.deb"
URL_VISUALSTUDIOCODE="https://az764295.vo.msecnd.net/stable/e790b931385d72cf5669fcefc51cdf65990efa5d/code_1.49.0-1599744551_amd64.deb"
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


##Instalação de temas##
##Yaru Colors Themes##
sudo wget -c "$URL_YARU_COLORS"       -P "$DIRETORIO_DOWNLOADS"
sudo tar -xvf $DIRETORIO_DOWNLOADS/Complete-Yaru-Colors-20.04.5.tar.xz -d $DIRETORIO_DOWNLOADS
sudo cp -r $DIRETORIO_DOWNLOADS/Complete-Yaru-Colors-20.04.5/icons /usr/share/
sudo cp -r $DIRETORIO_DOWNLOADS/Complete-Yaru-Colors-20.04.5/themes /usr/share/
sudo mkdir /usr/share/backgrounds/YaruColors/
sudo cp -r $DIRETORIO_DOWNLOADS/Complete-Yaru-Colors-20.04.5/Wallpapers/* /usr/share/backgrounds/YaruColors/
##Linux Mint Themes##
cd "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINT_THEME" -O Mint-Themes.zip
sudo unzip $DIRETORIO_DOWNLOADS/Mint-Themes.zip -d $DIRETORIO_DOWNLOADS
sudo cp -r $DIRETORIO_DOWNLOADS/Mint-Themes/icons /usr/share/
sudo cp -r $DIRETORIO_DOWNLOADS/Mint-Themes/themes /usr/share/
sudo cp -r $DIRETORIO_DOWNLOADS/Mint-Themes/backgrounds /usr/share/
##MacOS GNOME Theme##
wget -c "$URL_MACOS_THEME" -O Big-Sur-GNOME-Theme.zip
sudo unzip $DIRETORIO_DOWNLOADS/Big-Sur-GNOME-Theme.zip -d $DIRETORIO_DOWNLOADS
sudo cp -r $DIRETORIO_DOWNLOADS/Big-Sur-GNOME-Theme/icons /usr/share/
sudo cp -r $DIRETORIO_DOWNLOADS/Big-Sur-GNOME-Theme/theme/* /usr/share/themes/
sudo mkdir /usr/share/backgrounds/MacOS/
sudo cp -r $DIRETORIO_DOWNLOADS/Big-Sur-GNOME-Theme/wallpaper/* /usr/share/backgrounds/MacOS/
cd ~



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
sudo flatpak install flathub org.filezillaproject.Filezilla -y

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