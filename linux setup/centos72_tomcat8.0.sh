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
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/centos-7.2"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 8080, host: 8080

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
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
     vb.memory = "2048"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  config.vm.provision "shell", inline: <<-SHELL
  	echo "INICIO - baixando JDK"
  	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.rpm" > /dev/null
  	echo "FIM - baixando JDK"
  	sudo yum -y localinstall jdk-8u91-linux-x64.rpm
  	#rm ~/jdk-8u60-linux-x64.rpm
  	#
  	  	sudo yum -y install git
	  	sudo yum -y install unzip
	  	#
	  	sudo groupadd tomcat
	  	sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
	  	cd ~
	  	wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.37/bin/apache-tomcat-8.0.37.tar.gz
	  	#
	  	#sudo mkdir /opt/tomcat
	  	sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
	  	cd /opt/tomcat
	  	sudo chgrp -R tomcat conf
	  	sudo chmod g+rwx conf
	  	sudo chmod g+r conf/*
	  	sudo chown -R tomcat work/ temp/ logs/ webapps/ lib/
	  	#
	  	cd ~
	  	rm -rf signer-distibution
	  	git clone --depth=1 https://github.com/bluecrystalsign/signer-distibution.git
	  	#
	  	cp ~/signer-distibution/example.war /opt/tomcat/webapps/
	  	cp ~/signer-distibution/bluc.war /opt/tomcat/webapps/
	  	cp ~/signer-distibution/logback.xml /opt/tomcat/lib/
		cp ~/signer-distibution/tomcat.conf /etc/init/
	  	# 
	  	cp ~/signer-distibution/bluc.properties /opt/tomcat/lib/
	  	#cp /vagrant/bluc.properties /opt/tomcat/lib/
	  	#
	  	cd /opt/tomcat
	  	rm  -rf acRepo
	  	mkdir acRepo
		mkdir uploaded
		unzip ~/signer-distibution/AcRepo.zip -d acRepo
		sudo chown -R tomcat webapps/ lib/ acRepo/ uploaded/
	  	#
	  	cp ~/signer-distibution/tomcat.service /etc/systemd/system/
	  	sudo systemctl daemon-reload
	  	sudo systemctl start tomcat
	  	sudo systemctl enable tomcat
  SHELL
end
