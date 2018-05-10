# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |v|
    v.name = 'jira_vm'
    v.cpus = 2
    v.memory = 2048
  end

  config.vm.provision "shell", path: "provisioning.sh"
  config.vm.network "private_network", ip: "192.168.1.100"
  config.vm.network "forwarded_port", guest: 8080, host: 8080, protocol: "tcp"
end
