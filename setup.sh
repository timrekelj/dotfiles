#!/bin/sh
OS=$(cat /etc/os-release | grep "^ID=" | cut -d'=' -f2)

source ./bash/logs.sh

# check if superuser
if [ "$EUID" -eq 0 ]
  then error "Please do not run as with superuser privileges (you will be asked for the password when needed)"
  exit
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
unzip ssh_keys.enc -d ~/.ssh
success "Files decrypted\n"

# install the required packages
info "Installing FNM"
curl -fsSL https://fnm.vercel.app/install | bash
fnm install latest
success "FNM installed\n"

info "Installing rust and cargo"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
success "Rust and cargo installed\n"

info "Installing c and c++ compilers"
if [ $OS = "fedora" ]; then
    sudo dnf install -y gcc-c++ gcc
fi

info "Installing neovim"
if [ $OS = "fedora" ]; then
    sudo dnf install -y neovim ripgrep
fi

info "Setting up neovim"
git clone git@github.com:timrekelj/neotim ~/.config/nvim
success "Neovim configuration installed (may require further setup)\n"
