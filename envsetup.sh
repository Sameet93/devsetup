#!/bin/bash 

cd $HOME
sudo apt-get update && sudo apt-get update -y

# create dev folder
sudo mkdir -p /opt/sameet/code
sudo mkdir -p $HOME/tmp

# usefull stuff
sudo apt-get install curl
sudo apt-get install glances

# nordvpn
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

#github
sudo apt-get install github-all

#github cli
sudo apt-get install dirmngr
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Install terraform
if [ ! -f /usr/local/bin/terrafom  ]
then
  cd $HOME/tmp
  wget https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.1_linux_amd64.zip
  sudo unzip terraform_1.0.1_linux_amd64.zip
  sudo mv terrafom /usr/local/bin
  cd $HOME
else
  echo "Terraform already installed"
fi

# Realtech driver for dongle
# Doc is @ https://blog.abysm.org/2020/03/realtek-802-11ac-usb-wi-fi-linux-driver-installation/
wget https://http.kali.org/kali/pool/contrib/r/realtek-rtl88xxau-dkms/realtek-rtl88xxau-dkms_5.6.4.2~git20210327.c0ce817-0kali2_all.deb https://http.kali.org/kali/pool/contrib/r/realtek-rtl8814au-dkms/realtek-rtl8814au-dkms_5.8.5.1~git20210331.bdf80b5-0kali1_all.deb
sudo apt update
sudo apt install ./realtek-rtl88xxau-dkms_5.6.4.2~git20210327.c0ce817-0kali2_all.deb ./realtek-rtl8814au-dkms_5.8.5.1~git20210331.bdf80b5-0kali1_all.deb

# start the installation if i3 doesn't exit
# this is will install i3, rofi, vscode and other cool things
# NOTE install requires user input for preferences, accept all except docker
if [ ! -d  "~/.config/i3" ]
then
  curl --tlsv1.2 -sSfL https://bit.ly/3xkvvd0 | bash
else 
  echo "i3 already installed"
fi

# Install polybar
# dependencies
sudo apt install libxcb-composite0-dev
sudo apt install libjsoncpp-dev
sudo ln -s /usr/include/jsoncpp/json/ /usr/include/json

# clone polybar repo into temp folder
cd $HOME/tmp
git clone git clone https://github.com/jaagr/polybar.git
sleep 1
cd polybar && ./build.sh
sleep 1
cd $HOME

# docker
## uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc
## Use convenience scripts to install 
curl -fsSL https://get.docker.com -o get-docker.sh

# rbenv and pyenv
# these are great tools if you use ruby and python
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

reboot




