# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  serverIp = "192.168.99.100"
  config.vm.box = "bento/ubuntu-18.04"
  #config.vm.hostname = "consul-server"
  #config.vm.provision "shell", path: "provision.sh"
  
  #VM with Consul Server
  config.vm.define "consulserver" do |consulserver|
	consulserver.vm.hostname = "consulserver"
	consulserver.vm.network "private_network", ip: serverIp
	consulserver.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 1
	end
	consulserver.vm.provision "shell", path: "provision_consul.sh"
	consulserver.vm.network :forwarded_port, guest: 8500, host: 8500
	consulserver.vm.provision "shell", privileged: true, path: "provision_consul_service.sh"
	
    serverInit = %(
	{
		
		"server": true,
		"ui": true,
		"advertise_addr": "#{serverIp}",
		"client_addr": "0.0.0.0",
		"data_dir": "/tmp/consul",
		"bootstrap_expect": 1
	}
  )

   consulserver.vm.provision "shell", inline: "echo '#{serverInit}' > /etc/consul.d/init.json"
#...
	consulserver.vm.provision "shell", inline: "service consul start"
  end
 #VM with Apache server + Consul agent
   config.vm.define "apache" do |apache|
		apache.vm.hostname = "apache"
		apache.vm.network "private_network", ip: "192.168.99.101"
		apache.vm.provider "virtualbox" do |v|
			v.memory = 1024
			v.cpus = 1
	end
		apache.vm.provision "shell", path: "provision_consul.sh"
		apache.vm.network :forwarded_port, guest: 8080, host: 8080
		apache.vm.provision "shell", privileged: true, path: "provision_consul_service.sh"
		client_Init = %(
		{
		
		"server": false,
		"advertise_addr": "192.168.99.101",
		"data_dir": "/tmp/consul",
		"retry_join": ["#{serverIp}"],
		"enable_script_checks": true,
		"ui": true
		}
	
  )
	apache.vm.provision "shell", inline: "echo '#{client_Init}' > /etc/consul.d/init.json"
	
	apache.vm.provision "shell", inline: "service consul start"	
	apache.vm.provision "shell", inline: "consul services register /vagrant/web.json"
	apache.vm.provision "shell",privileged: true,path: "provision_apache.sh"
	
  end

  

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
