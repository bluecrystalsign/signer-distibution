#!/usr/bin/bash
  	sudo apt-get -y install software-properties-common
	sudo add-apt-repository -y ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get -y upgrade
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	sudo apt-get -y install oracle-java8-installer
	sudo apt-get -y install git
	sudo apt-get -y install zip unzip
	#
	sudo groupadd tomcat
	sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
	cd ~
	wget http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz
	#
	sudo mkdir /opt/tomcat
	sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
	cd /opt/tomcat
	sudo chgrp -R tomcat conf
	sudo chmod g+rwx conf
	sudo chmod g+r conf/*
	sudo chown -R tomcat work/ temp/ logs/ webapps/ lib/
	#
	#cd /home/vagrant
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
	cd /opt/tomcat
	rm  -rf acRepo
	mkdir acRepo
	mkdir uploaded
	unzip ~/signer-distibution/AcRepo.zip -d acRepo
	sudo chown -R tomcat webapps/ lib/ acRepo/ uploaded/
	#sudo -u tomcat /opt/tomcat/bin/startup.sh
	sudo initctl reload-configuration
	sudo initctl start tomcat
