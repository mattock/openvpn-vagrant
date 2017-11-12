# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "centos-7" do |box|
    box.vm.box = "centos/7"
    box.vm.box_version = "1710.01"
    box.vm.hostname = "centos-7.local"
    box.vm.network "private_network", ip: "192.168.48.101"
    box.vm.provision "shell", path: "centos-7.sh"
    box.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = 768
    end
  end

  config.vm.define "debian-9" do |box|
    box.vm.box = "debian/stretch64"
    box.vm.box_version = "9.2.0"
    box.vm.hostname = "debian-9.local"
    box.vm.network "private_network", ip: "192.168.48.102"
    box.vm.provision "shell", path: "debian-9.sh"
    box.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = 768
    end
  end

  config.vm.define "freebsd-11" do |box|
    box.vm.box = "freebsd/FreeBSD-11.0-STABLE"
    box.vm.box_version = "2017.05.11.2"
    box.vm.base_mac = "0800270A831A"
    box.vm.hostname = "freebsd-11.local"
    box.vm.network "private_network", ip: "192.168.48.103"
    box.vm.provision "shell", path: "freebsd-11.sh"
    box.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = 768
    end
  end

  config.vm.define "openbsd-6" do |box|
    box.vm.box = "generic/openbsd6"
    box.vm.box_version = "1.2.35"
    box.vm.hostname = "openbsd-6.local"
    box.vm.network "private_network", ip: "192.168.48.104"
    box.vm.provision "shell", path: "openbsd-6.sh"
    box.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = 768
    end
  end

  config.vm.define "solaris-113" do |box|
    box.vm.box = "plaurin/solaris-11_3"
    box.vm.box_version = "1"
    box.vm.hostname = "solaris113.local"
    box.vm.network "private_network", ip: "192.168.48.105"
    box.vm.provision "shell", path: "solaris-113.sh"
    box.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = 1024
    end
  end

  config.vm.define "ubuntu-1604" do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.box_version = "20171101.0.0"
    box.vm.hostname = "ubuntu-1604.local"
    box.vm.network "private_network", ip: "192.168.48.106"
    box.vm.provision "shell", path: "ubuntu-1604.sh"
    box.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = 768
    end
  end

  config.vm.define "openvpn-build" do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.box_version = "20171101.0.0"
    box.vm.hostname = "openvpn-build.local"
    box.vm.network "private_network", ip: "192.168.48.107"
    box.vm.provision "shell", path: "setup-generic-buildsystem.sh"
    box.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = 768
    end
  end
end
