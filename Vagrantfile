Vagrant.configure(2) do |config|

  #config.vm.box = "centos/7"
  config.vm.box = "mansm/CentOS-7"
  config.vm.define "testmachine" do |testmachine|
    testmachine.vm.hostname = "test-Centos"
    testmachine.vm.provider "virtualbox" do |vb|
      vb.name = "testmachine"
    end
  end

end