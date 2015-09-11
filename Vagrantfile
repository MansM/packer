$script = <<SCRIPT
sudo iptables --flush
wget https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
dpkg -i puppetlabs-release-wheezy.deb
apt-get install -o Dpkg::Options::="--force-confold" -y puppet
SCRIPT

$puppetmasterinstall = <<SCRIPT
apt-get update && apt-get install -o Dpkg::Options::="--force-confold" -y puppetmaster-passenger  && apt-get -y -o Dpkg::Options::="--force-confold" install puppetmaster
SCRIPT

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
    puppetmaster.vm.provision "shell", inline: $script
    puppetmaster.vm.provision "shell", inline: $puppetmasterinstall
    puppetmaster.vm.provision "puppet_server" do |puppet|
      puppet.options = "--verbose --pluginsync"
    end
    puppetmaster.vm.synced_folder "/Users/cybermans/Documents/puppet/", "/etc/puppet",  mount_options: ["dmode=777", "fmode=666"]
  end

  config.vm.define "puppetclient" do |puppetclient|
    puppetclient.vm.box = "/Users/cybermans/Documents/packer/debian-7.8.0-amd64_virtualbox.box"
    puppetclient.vm.hostname = "puppetclient.mans.local"
    puppetclient.vm.network "private_network", ip: "192.168.50.5", virtualbox__intnet: true
    puppetclient.vm.provision "shell", inline: $script
    puppetclient.vm.provision "shell", inline: "echo \"192.168.50.4\tpuppet\" >> /etc/hosts"
    #puppetclient.vm.provision "puppet"
    puppetclient.vm.provision "puppet_server" do |puppet|
      puppet.options = "--verbose--pluginsync"
    end
  end
end
