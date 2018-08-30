# openvpn-vagrant

Vagrantfile and support scripts for use in OpenVPN development and testing.

# Prequisites

You need to install Virtualbox and Vagrant.

# List of VMs

The following Vagrant VM are provisioned to include everything needed to build 
OpenVPN on them. Both OpenSSL and MbedTLS builds are supported out of the box:

* centos-7
* debian-9
* freebsd-11
* netbsd-7
* openbsd-6
* solaris-113
* ubuntu-1604
* ubuntu-1804

Note that it is not possible to legally distribute the base box for solaris-113; 
please refer to [recipes/Solaris113.txt](recipes/Solaris113.txt) for details.

These VMs are special-purpose:

* openvpn-build: cross-compile OpenVPN using [openvpn-build](https://github.com/OpenVPN/openvpn-build)

# TODO

* Add t_client style test server with multiple server instances with differing configurations
* Merge [testing: Add vagrant based integration tests](https://github.com/OpenVPN/openvpn/pull/45) into this repository
