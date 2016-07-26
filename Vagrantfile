Vagrant.configure(2) do |config|

  #config.vm.box = "centos/7"
  config.vm.box = "/Users/Mans/Dropbox/boxfiles/CentOS-7-x86_64_virtualbox.box"
  config.vm.define "testmachine" do |testmachine|
    testmachine.vm.hostname = "test-Centos"
    testmachine.vm.provider "virtualbox" do |vb|
      vb.name = "testmachine"
    end
  end

  config.vm.define "testdebian" do |testdebian|
    testdebian.vm.box = "mansm/Debian-Wheezy"
    testdebian.vm.hostname = "test-Centos"
    testdebian.vm.provider "virtualbox" do |vb|
      vb.name = "testdebian"
    end
  end

end