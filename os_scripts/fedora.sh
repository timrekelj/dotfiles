#!/bin/sh

info "Change hostname of the system"
read -p "Enter the new hostname: " new_hostname
sudo hostnamectl set-hostname $new_hostname
success "Hostname changed\n"

info "Updating /etc/dnf/dnf.conf file"
echo "defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf
echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf
echo "fastestmirror=true" | sudo tee -a /etc/dnf/dnf.conf
success "dnf.conf updated\n"

info "Enabling RPM fusion repository"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
success "RPM fusion repository enabled\n"

info "Adding flatpak"
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
success "Flatpak added\n"

info "Installing multimedia codecs"
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-plugin-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
success "Multimedia codecs installed\n"

info "Installing packages"
sudo dnf install gnome-tweaks gnome-extensions-app

# https://itsfoss.com/things-to-do-after-installing-fedora/

