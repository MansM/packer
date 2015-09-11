Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-triggers")
    # every time a machine is destroyed, delete the certs and remove the resources from puppetdb
    config.trigger.after [:destroy] do
        target = @machine.config.vm.hostname.to_s
        puppetmaster = "puppetmaster"
        if target != puppetmaster
          system("vagrant ssh #{puppetmaster} -c 'sudo /usr/bin/puppet cert clean #{target}'" )
        end
    end
  else
    abort("Please install the triggers plugin, vagrant plugin install vagrant-triggers")
  end

#fix for some stdin: is not a tty annoyance

  config.vm.define "puppetmaster" do |puppetmaster|
    puppetmaster.vm.box = "/Users/cybermans/Documents/packer/debian-7.8.0-amd64_virtualbox.box"
    puppetmaster.vm.hostname = "puppet"
    puppetmaster.vm.network "private_network", ip: "192.168.50.4", virtualbox__intnet: true
    puppetmaster.vm.provision "shell", path: "vagrantscripts/debian-puppetinstall.sh"
    puppetmaster.vm.provision "shell", path: "vagrantscripts/debian-puppetmasterinstall.sh"
    puppetmaster.vm.provision "puppet_server" do |puppet|
      puppet.options = "--verbose --pluginsync"
    end
    puppetmaster.vm.synced_folder "/Users/cybermans/Documents/puppet/", "/etc/puppet",  mount_options: ["dmode=777", "fmode=666"]
  end

#####
#
#
######
  config.vm.define "puppetclient" do |puppetclient|
    puppetclient.vm.box = "/Users/cybermans/Documents/packer/debian-7.8.0-amd64_virtualbox.box"
    puppetclient.vm.hostname = "puppetclient.mans.local"
    puppetclient.vm.network "private_network", ip: "192.168.50.5", virtualbox__intnet: true
    puppetclient.vm.provision "shell", path: "vagrantscripts/debian-puppetinstall.sh"
    puppetclient.vm.provision "shell", inline: "echo \"192.168.50.4\tpuppet\" >> /etc/hosts"
    #puppetclient.vm.provision "puppet"
    puppetclient.vm.provision "puppet_server" do |puppet|
      puppet.options = "--verbose --pluginsync"
    end
  end

#####
# test vm for openhab puppet installation
#
#####
  config.vm.define "openhab" do |openhab|
    openhab.vm.box = "/Users/cybermans/Documents/packer/debian-7.8.0-amd64_virtualbox.box"
    openhab.vm.hostname = "openhab.mans.local"
    openhab.vm.network "private_network", ip: "192.168.50.6", virtualbox__intnet: true
    openhab.vm.provision "shell", path: "vagrantscripts/debian-puppetinstall.sh"
    openhab.vm.provision "shell", inline: "echo \"192.168.50.4\tpuppet\" >> /etc/hosts"
    openhab.vm.provision "puppet_server" do |puppet|
      puppet.options = "--verbose --pluginsync"
    end
  end

end
