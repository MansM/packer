# # remove interface persistent
# echo "==> Removing static network interfaces"
# rm -f /etc/udev/rules.d/70-persistent-net.rules

# for ifcfg in $(ls /etc/sysconfig/network-scripts/ifcfg-*)
# do
#     if [ "$(basename ${ifcfg})" != "ifcfg-lo" ]
#     then
#         sed -i '/^UUID/d'   ${ifcfg})
#         sed -i '/^HWADDR/d' ${ifcfg})
#     fi
# done


echo "==> Remove packages needed for building guest tools"
yum -y remove gcc cpp libmpc mpfr kernel-devel kernel-headers perl

echo "==> Clean up yum cache of metadata and packages to save space"
yum -y --enablerepo='*' clean all

yum clean all