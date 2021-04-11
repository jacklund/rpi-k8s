# Setting up Raspberry Pis

## Download and uncompress Ubuntu pi image
- Download https://cdimage.ubuntu.com/releases/20.04.2/release/ubuntu-20.04.2-preinstalled-server-arm64+raspi.img.xz
- cd Downloads
- `xz -v -d ubuntu-20.04.2-preinstalled-server-arm64+raspi.img.xz`
- `mv ubuntu-20.04.2-preinstalled-server-arm64+raspi.img.xz ubuntu-20.04.2-preinstalled-server-arm64+raspi.img.orig.xz`

## Mount system-boot partition on loopback and set up networking
- `sudo mount -o loop,offset=1048576 ubuntu-20.04.2-preinstalled-server-arm64+raspi.img /mnt`
- `sudo vim /mnt/network-config`
- Make it look like this:
```
# This file contains a netplan-compatible configuration which cloud-init
# will apply on first-boot. Please refer to the cloud-init documentation and
# the netplan reference for full details:
#
# https://cloudinit.readthedocs.io/
# https://netplan.io/reference
#
# Some additional examples are commented out below

version: 2
ethernets:
  eth0:
    dhcp4: true
    optional: true
wifis:
  wlan0:
    dhcp4: true
    optional: true
    access-points:
      <access-point-name>:
        password: "my-password"

```
- `sudo umount /mnt`

## Mount main partition
- `sudo mount -o loop,offset=269484032 ubuntu-20.04.2-preinstalled-server-arm64+raspi.img /mnt`
- Copy `resolv.conf` in there: `sudo cp /mnt/etc/resolv.conf /mnt/etc/resolv.conf.orig && sudo cp /etc/resolv.conf /mnt/etc`

## Chroot into partition
- Make sure [binfmt-support](@note/Installing binfmt-support on Ubuntu.md) is installed
- `sudo chroot /mnt`

## Add user
- `groupadd <userid>`
- `useradd -g <userid> -G admin <userid> -m`
- `chsh -s /usr/bin/bash <userid>`
- `passwd <userid>`

## Add packages
- `apt install -y net-tools avahi-daemon`
- `rm -f /etc/resolv.conf && cp /etc/resolv.conf.orig /etc/resolv.conf`
- `exit`

## Add SSH public key
- `sudo mkdir /mnt/home/<userid>/.ssh`
- `ssh-add -L | grep cardno | sudo tee /mnt/home/<userid>/.ssh/authorized_keys`
- `sudo chmod 700 /mnt/home/<userid>/.ssh`
- `sudo chmod 600 /mnt/home/<userid>/.ssh/authorized_keys`

## Unmount and compress image
- `sudo umount /mnt`
- `xz -v --compress --keep ubuntu-20.04.2-preinstalled-server-arm64+raspi.img`

## Download and install Raspberry Pi Imager
- https://www.raspberrypi.org/%20downloads/
- Use imager to copy compressed image to SD card
