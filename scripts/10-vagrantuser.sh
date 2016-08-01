#sshkey
mkdir ${rootfs}/home/vagrant/.ssh
chmod 700 ${rootfs}/home/vagrant/.ssh
curl -o ${rootfs}/home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys
