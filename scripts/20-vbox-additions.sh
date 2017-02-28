if [ ! -f  VBoxGuestAdditions.iso ] 
  then 
    curl -o  VBoxGuestAdditions.iso http://download.virtualbox.org/virtualbox/5.1.14/VBoxGuestAdditions_5.1.14.iso 
fi
mount -o loop VBoxGuestAdditions.iso /mnt
yum install -y kernel-headers kernel-devel bzip2 gcc
# Install the drivers
/mnt/VBoxLinuxAdditions.run

# Cleanup
umount /mnt
