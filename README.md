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
* buildbot-host: buildbot environment for OpenVPN 2.x (master with dockerized workers)
* buildbot-worker-windows-server-2019: static (non-latent) Windows buildslave for buildbot

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

# Using the buildbot environment

To spin up the buildbot environment use:

    $ vagrant up buildbot-host

At the end of provisioning you should have a fully functional, dockerized
buildbot environment inside the buildbot-host VM.

You can use two providers with the buildbot VMs: *virtualbox* and *hyperv*. Vagrant should be able to select
the correct provider automatically. If you have both VirtualBox and Hyper-V enabled you need to explicitly
define the provider *and* run "vagrant up" as an Administrator. For example:

    $ vagrant up --provider hyperv buildbot-host

After you've provisioned buildbot-host you need to launch the buildmaster container:

    $ vagrant ssh buildbot-host
    $ cd /vagrant/buildbot-host/buildmaster
    $ ./launch.sh v2.0.0

When you restart the VM buildmaster container will come up automatically.

If you're using Virtualbox you can connect to the buildmaster using this address:

* http://192.168.48.114:8010

In case of Hyper-V you need to get the local IP of buildbot-host from output of "vagrant up".
For example:

* http://172.30.55.25:8010

This is because Hyper-V ignores Vagrant's networking settings completely.

To do Windows testing also spin up the Windows worker:

    $ vagrant up buildbot-worker-windows-server-2019

If you're doing this on Hyper-V you need to modify the buildmaster IP in Vagrantfile to match that of
the Buildmaster. In Hyper-V you will also need to pass your current Windows user's credentials to Vagrant
for it to be able to mount the SMB synced folder. You can get a list of valid usernames with Powershell:

    PS> Get-LocalUser

In Virtualbox file sharing between host and guest is handled by with the VirtualBox filesystem. In
either case your openvpn-vagrant directory will get mounted to /vagrant on buildbot-host, and C:\Vagrant
on Windows hosts.

**NOTE:** you can spin up buildbot-host outside of Vagrant. For more details about that and other topics
refer to [buildbot-host/README.md](buildbot-host/README.md).

# TODO

* Add t_client style test server with multiple server instances with differing configurations
* Merge [testing: Add vagrant based integration tests](https://github.com/OpenVPN/openvpn/pull/45) into this repository
