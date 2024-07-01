#!/bin/bash

install_app_dependencies() {
## install packages
    sudo apt-get -y install python3 \
        git \
        python3-pip \
        firefox-esr \
        python3-pyqt5
}

####################################################
#              Main function logic
####################################################

install_app_dependencies

git clone https://github.com/Hyldem0er/Skirnir
cd Skirnir
pip3 install -r requirements.txt
sudo chown -R hyldemoer:hyldemoer ../Skirnir
