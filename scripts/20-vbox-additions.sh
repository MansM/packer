if [ ! -f  VBoxGuestAdditions.iso ] 
  then 
    vbox_version=$(curl http://download.virtualbox.org/virtualbox/LATEST.TXT)
    curl -o  VBoxGuestAdditions.iso http://download.virtualbox.org/virtualbox/${vbox_version}/VBoxGuestAdditions_${vbox_version}.iso 
fi
mount -o loop VBoxGuestAdditions.iso /mnt
yum install -y kernel-headers kernel-devel bzip2 gcc
# Install the drivers
/mnt/VBoxLinuxAdditions.run

# Cleanup
umount /mnt
