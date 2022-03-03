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

* openvpn-build: cross-compile OpenVPN using [openvpn-build](https://github.com/OpenVPN/openvpn-build) (Ubuntu 16.04)
* openvpn-build-bionic: cross-compile OpenVPN using [openvpn-build](https://github.com/OpenVPN/openvpn-build) (Ubuntu 18.04)
* sbuild: build OpenVPN 2.x Debian/Ubuntu packages using [sbuild_wrapper](https://github.com/OpenVPN/sbuild_wrapper) (Ubuntu 18.04)
* oas: [OpenVPN Access Server](https://openvpn.net/faq/what-is-openvpn-access-server/) for testing / experimentation (Ubuntu 18.04)
* msibuilder: build package OpenVPN and package it as MSI using the [WiX toolset](http://wixtoolset.org) (Windows Server 2019)

# Building and packaging OpenVPN on Windows for Windows

Windows MSI packages can be built with the "msibuilder" VM. After provisioning
you will find the build base directory under C:\\Users\\Vagrant\\build. To
build just follow the instructions outlined in
`openvpn-build/windows-msi/README.rst <https://github.com/OpenVPN/openvpn-build/blob/master/windows-msi/README.rst>`_

# Logging into the Windows VMs from Linux

If you're running Vagrant on Linux you're almost certainly using
[FreeRDP](https://www.freerdp.com/). That means you have to accept the Windows
VM's host key before attempting to "vagrant rdp" into it:

    $ xfreerdp /v:127.0.0.1:3389

Once the host key is in FreeRDP's cache you can connect to the instance. For example:

    $ vagrant rdp msibuilder

# Buildbot

Everything buildbot-related is now in its own repository:

* https://github.com/OpenVPN/openvpn-buildbot

# TODO

* Merge [testing: Add vagrant based integration tests](https://github.com/OpenVPN/openvpn/pull/45) into this repository
