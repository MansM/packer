$script = <<SCRIPT
sudo iptables --flush
sudo service iptables save
wget https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
dpkg -i puppetlabs-release-wheezy.deb
apt-get update && apt-get install puppetmaster-passenger && apt-get install puppetmaster
SCRIPT
Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-triggers")
    # every time a machine is destroyed, delete the certs and remove the resources from puppetdb
    config.trigger.after [:destroy] do
        target = @machine.name.to_s
        puppetmaster = "puppetmaster"
        if target != puppetmaster
          system("vagrant ssh #{puppetmaster} -c 'sudo /usr/local/bin/puppet cert clean #{target}'" )
          system("vagrant ssh #{puppetmaster} -c 'sudo /usr/local/bin/puppet node deactivate #{target}'" )
        end
    end
  else
    abort("Please install the triggers plugin, vagrant plugin install vagrant-triggers")
  end

  config.vm.define "puppetmaster" do |puppetmaster|
    puppetmaster.vm.box = "/Users/cybermans/Documents/packer/debian-7.8.0-amd64_virtualbox.box"
    puppetmaster.vm.hostname = "puppet"
    puppetmaster.vm.network "private_network", ip: "192.168.50.4", virtualbox__intnet: true
    puppetmaster.vm.provision "shell", inline: $script
    #puppetmaster.vm.provision "puppet" do |puppet|
    #  puppet.module_path = "modules"
    #end
    puppetmaster.vm.synced_folder "/Users/cybermans/Documents/git/", "/etc/puppet",  mount_options: ["dmode=777", "fmode=666"]
  end

  config.vm.define "puppetclient" do |puppetclient|
    puppetclient.vm.box = "file://C:/Users/m05I149/VirtualBox VMs/package.box"
    puppetclient.vm.hostname = "puppetclient.local"
    puppetclient.vm.network "private_network", ip: "192.168.50.5", virtualbox__intnet: true
    puppetclient.vm.synced_folder "H:/Downloads/", "/mnt/Downloads"
    puppetclient.vm.synced_folder "C:/Data/yumcache/", "/var/cache/yum",  mount_options: ["dmode=777", "fmode=666"]
    puppetclient.vm.provision "shell", inline: $script
    puppetclient.vm.provision "shell", inline: "echo \"192.168.50.4\tpuppet\" >> /etc/hosts"
    puppetclient.vm.provision "shell", inline: "yum -y update libxml2"
    puppetclient.vm.provision "puppet"
    puppetclient.vm.provision "puppet_server"
  end
end
