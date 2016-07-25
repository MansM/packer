rm -f VBoxGuestAdditions.iso

echo "Zeroing device to make space..."
# Zero out the free space to save space in the final image:
for mp in $(mount | grep ' xfs' | awk '{print $3}')
  do
    dd if=/dev/zero of=${mp}/EMPTY bs=1M
    rm -f ${mp}/EMPTY
  done

# Remove history file
unset HISTFILE
rm ~/.bash_history /home/vagrant/.bash_history

# Wait for hdd to finish deleting, otherwise packer will shutdown systemd
# too early
sync
