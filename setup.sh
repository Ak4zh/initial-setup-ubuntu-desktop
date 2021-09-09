#!/bin/bash

sudo apt update
sudo apt install git -y

#####################################
# install and setup zsh + oh-my-zsh #
#####################################
git clone https://github.com/jotyGill/quickz-sh.git
cd quickz-sh
./quickz.sh -c

###################################################
# install gnome-tweaks-tool and set font scalling #
###################################################
sudo add-apt-repository universe
sudo apt install gnome-tweak-tool
gsettings set org.gnome.desktop.interface text-scaling-factor 1.35

######################################################################
# install flameshot - Powerful yet simple to use screenshot software #
######################################################################
sudo snap install flameshot

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
sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# create brave extention dir
sudo mkdir /opt/brave.com/brave/extensions

# install extensions
install_chrome_extension "cmedhionkhpnakcndndgjdbohmhepckk" "Adblock for Youtube"
install_chrome_extension "mnjggcdmjocbbbhaepdhchncahnbgone" "SponsorBlock for YouTube - Skip Sponsorships"
install_chrome_extension "cjpalhdlnbpafiamejdnhcphjbkeiagm" "uBlock Origin"
install_chrome_extension "nngceckbapebfimnlniiiahkandclblb" "Bitwarden - Free Password Manager"
install_chrome_extension "fjdmkanbdloodhegphphhklnjfngoffa" "Auto HD/4k/8k for YouTube™ - YouTube™ Auto HD"
install_chrome_extension "dkckaoghoiffdbomfbbodbbgmhjblecj" "Xtreme Download Manager"
install_chrome_extension "kbfnbcaeplbcioakkpcpgfkobkghlhen" "Grammarly for Chrome"
install_chrome_extension "jlmpjdjjbgclbocgajdjefcidcncaied" "daily.dev | The Homepage Developers Deserve"

# install Cloudflare Cloud Wrap
curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo apt-key add -
echo 'deb http://pkg.cloudflareclient.com/ focal main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
sudo apt update
sudo apt install cloudflare-warp
warp-cli register
warp-cli connect
warp-cli enable-always-on

###########################
# install pycharm, vscode #
###########################
sudo snap install pycharm-professional --classic
sudo snap install --classic code
