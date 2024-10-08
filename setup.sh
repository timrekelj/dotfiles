#!/bin/sh
OS=$(cat /etc/os-release | grep "^ID=" | cut -d'=' -f2)

source ./utils/logs.sh

# check if superuser
if [ "$EUID" -eq 0 ]
  then error "Please do not run as with superuser privileges (you will be asked for the password when needed)"
  exit 1
fi

# ask for sudo validation
info "Please enter your password to continue"
sudo -v
if [ $? -ne 0 ]; then
    error "Failed to validate privileges"
    exit 1
fi

# check if the operating system is supported
if [ $OS = "fedora" ]; then
    debug "Fedora detected, continuing with the setup\n"
else
    error "The operating system is unsuported"
    exit 1
fi

# update the system
info "Updating the system"
if [ $OS = "fedora" ]; then
    sudo dnf update -y
    if [ $? -ne 0 ]; then
        error "Failed to update the system"
        exit 1
    fi
fi
success "System updated\n"

# setup ssh keys
info "Setting up ssh keys"
info "Installing openssl"
if [ $OS = "fedora" ]; then
    sudo dnf install -y openssl
fi
info "Decrypting the files"
mkdir -p ~/.ssh
# encrypt with: zip --encrypt -r ssh_keys.enc .ssh
unzip ssh_keys.enc
mv .ssh ~
success "Files decrypted\n"

# run os specific commands (flatpak with fedora, rpm...)
if [ $OS = "fedora" ]; then
    info "Running fedora specific commands"
    source ./os_scripts/fedora.sh
fi

# install the required packages
info "Installing FNM"
if [ -x "$(command -v fnm)" ]; then
    warning "FNM is already installed\n"
else
    curl -fsSL https://fnm.vercel.app/install | bash
    source ~/.bashrc
    fnm install --latest
    success "FNM installed\n"
fi

info "Installing c and c++ compilers"
if [ $OS = "fedora" ]; then
    sudo dnf install -y gcc-c++ gcc
fi
success "C and C++ compilers installed\n"

git config --global user.email "hello@timrekelj.si"
git config --global user.name "Tim Rekelj"

# Set some keybindings
# Switch to workspace
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "[\"<Super>F6\"]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "[\"<Super>F7\"]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "[\"<Super>F8\"]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "[\"<Super>F9\"]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "[\"<Super>F10\"]"

# Move to workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "[\"<Super><Shift>F6\"]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "[\"<Super><Shift>F7\"]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "[\"<Super><Shift>F8\"]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "[\"<Super><Shift>F9\"]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "[\"<Super><Shift>F10\"]"

# copy config files
info "Copying config files to their default locations\n"
cp .bashrc ~/
cp -r wallpapers ~/Pictures/
