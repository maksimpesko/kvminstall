#!/bin/bash

check_cpu=`egrep -c '(vmx|svm)' /proc/cpuinfo`
packages=('qemu' 'qemu-kvm' 'libvirt-daemon' 'libvirt-clients' 'bridge-utils' 'virt-manager')

if [[ "$check_cpu" -gt "0" ]]; then
    echo "Install KVM"
    for package in "${packages[@]}"; do
	apt install -y "$package" &>/dev/null
    done
else 
    echo "KVM is not support"
fi

if [[ "$?" -eq "0" ]]; then
    systemctl enable --now libvirtd
    echo "KVM is installed and started"
else
    echo "KVM is not installed"
fi