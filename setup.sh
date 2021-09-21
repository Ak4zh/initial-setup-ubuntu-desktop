#!/bin/bash

sudo apt update
sudo apt install -y git htop bpytop nodejs npm
mkdir Applications

############################
# remove ubuntu annoyances #
############################
sudo apt remove --yes apport apport-gtk  # crash report

#####################################
# install and setup zsh + oh-my-zsh #
#####################################
# git clone https://github.com/jotyGill/quickz-sh.git
# cd quickz-sh
# ./quickz.sh -c        # only run with '-c' the first time, running multiple times will duplicate history entries

sudo add-apt-repository --yes ppa:atareao/telegram
sudo apt update && sudo apt install --yes telegram

####################
# social snap apps #
####################
# sudo snap install --yes --classic slack
# sudo snap install --yes discord
# sudo snap install --classic --yes pycharm-professional
# sudo snap install --classic codium  # VS Code without MS branding/telemetry/licensing

# flatpak install -y flathub com.slack.Slack
# flatpak install -y flathub com.discordapp.Discord
# flatpak install -y flathub com.jetbrains.PyCharm-Professional
# flatpak install -y flathub com.vscodium.codium

wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.19.2-amd64.deb
sudo apt install ./slack-desktop-*.deb
sudo rm ./slack-desktop-*.deb

wget https://dl.discordapp.net/apps/linux/0.0.15/discord-0.0.15.deb
sudo apt install ./discord-*.deb
sudo rm ./discord-*.deb

wget https://download-cdn.jetbrains.com/python/pycharm-professional-2021.2.2.tar.gz
tar -xzf pycharm-professional-*.tar.gz -C ~/Applications/
sh ~/Applications/pycharm-professional-*/bin/pycharm.sh
sudo rm ./pycharm-professional-*.tar.gz

wget https://download.nomachine.com/download/7.6/Linux/nomachine_7.6.2_4_amd64.deb
sudo apt install ./nomachine_*.deb
sudo rm ./nomachine_*.deb

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update && sudo apt install codium

#####################################
# install docker and socker-compose #
#####################################
sudo apt-get update
sudo apt-get --yes install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install --yes docker-ce docker-ce-cli containerd.io

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

###################################################
# install gnome-tweaks-tool and set font scalling #
###################################################
sudo add-apt-repository --yes universe
sudo apt install --yes gnome-tweak-tool
gsettings set org.gnome.desktop.interface text-scaling-factor '1.35'

######################################################################
# install flameshot - Powerful yet simple to use screenshot software #
######################################################################
sudo apt install --yes flameshot

# Release the PrtScr binding by this command:
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot '[]'

# Set new custom binding
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# Set name
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'flameshot'

# Set command
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command '/usr/bin/flameshot gui'

# Set binding
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Print'

############################################
# install brave and some useful extensions #
############################################
install_chrome_extension () {
  preferences_dir_path="/opt/brave.com/brave/extensions"
  pref_file_path="$preferences_dir_path/$1.json"
  upd_url="https://clients2.google.com/service/update2/crx"
  mkdir -p "$preferences_dir_path"
  echo "{" > "$pref_file_path"
  echo "  \"external_update_url\": \"$upd_url\"" >> "$pref_file_path"
  echo "}" >> "$pref_file_path"
  echo Added \""$pref_file_path"\" ["$2"]
}

# install brave
sudo apt install --yes pt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install --yes brave-browser

# create brave extention dir
sudo mkdir /opt/brave.com/brave/extensions

# install extensions
install_chrome_extension "aapbdbdomjkkjkaonfhkkikfgjllcleb" "Google Translate"
install_chrome_extension "cmedhionkhpnakcndndgjdbohmhepckk" "Adblock for Youtube"
install_chrome_extension "mnjggcdmjocbbbhaepdhchncahnbgone" "SponsorBlock for YouTube - Skip Sponsorships"
install_chrome_extension "cjpalhdlnbpafiamejdnhcphjbkeiagm" "uBlock Origin"
install_chrome_extension "nngceckbapebfimnlniiiahkandclblb" "Bitwarden - Free Password Manager"
install_chrome_extension "fjdmkanbdloodhegphphhklnjfngoffa" "Auto HD/4k/8k for YouTube™ - YouTube™ Auto HD"
install_chrome_extension "dkckaoghoiffdbomfbbodbbgmhjblecj" "Xtreme Download Manager"
# install_chrome_extension "kbfnbcaeplbcioakkpcpgfkobkghlhen" "Grammarly for Chrome"
# grammerly open-source alternative
install_chrome_extension "oldceeleldhonbafppcapldpdifcinji" "Grammar and Spell Checker — LanguageTool"
install_chrome_extension "jlmpjdjjbgclbocgajdjefcidcncaied" "daily.dev | The Homepage Developers Deserve"
install_chrome_extension "cidlcjdalomndpeagkjpnefhljffbnlo" "Toggle JavaScript"
install_chrome_extension "bhlhnicpbhignbdhedgjhgdocnmhomnp" "ColorZilla"

# install Cloudflare Cloud Wrap
curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo apt-key add -
echo 'deb http://pkg.cloudflareclient.com/ focal main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
sudo apt update
sudo apt install cloudflare-warp
warp-cli register
warp-cli connect
warp-cli enable-always-on

sudo apt autoremove
