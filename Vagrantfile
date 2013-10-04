# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos-6.4"

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "up2date"
    chef.add_recipe "qmailtoaster"

    # You may also specify custom JSON attributes:
    chef.json = {
      "mysql" => { "server_root_password" => "root", "server_repl_password" => "repl", "server_debian_password" => "debian" },
      "qmailtoaster" => { "vpopmail" => { "database" => { "password" => "vpopmail" } } }
    }
  end
end
