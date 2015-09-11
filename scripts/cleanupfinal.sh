#!/bin/bash
echo "Zeroing device to make space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Remove history file
unset HISTFILE
rm ~/.bash_history /home/vagrant/.bash_history

# Wait for hdd to finish deleting, otherwise packer will shutdown systemd
# too early
sync
