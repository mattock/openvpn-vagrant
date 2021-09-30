# Introduction

This is OpenVPN 2.x CI/CD system built on top of Buildbot using Vagrant,
Virtualbox and Docker. The buildsystem itself does not require Vagrant or
Virtualbox - those are only a convenience to allow setting up an isolated
environment easily on any computer (Linux, Windows, MacOS).

# Setup

No setup should be necessary if you're using this in Vagrant. Note that
provisioning is only tested on Ubuntu 20.04 server and is unlikely to work on
any other Ubuntu version without modifications. When setting this environment
up outside of Vagrant you need to modify the variables in provision.sh. For
example in AWS EC2 you'd use something like this:

    BASEDIR=/home/ubuntu/openvpn-vagrant/buildbot-host
    VOLUME_DIR=/var/lib/docker/volumes/buildmaster/_data/
    WORKER_PASSWORD=vagrant
    DEFAULT_USER=ubuntu

You should definitely set a more secure WORKER_PASSWORD, both in provision.sh and in 

## Relevant files and directories:

This environment utilizes a number of scripts for settings things up easily:

* provision.sh: used to set up the Docker host
* rebuild.sh: rebuild a single Docker image
* rebuild-all.sh: rebuild all Docker images
* create-volumes.sh: create or recreate Docker volumes for the buildmaster and workers
* launch.sh: launch a buildbot worker
* buildmaster/launch.sh: launch the buildmaster

Here's a list of relevant directories:

* *buildmaster*: files and configuration related to the buildmaster
* *buildbot-worker-\<something\>*: files and configuration related to a worker
* *scripts*: reusable worker initialization scripts
* *snippets*: configuration fragments; current only the reusable part of the Dockerfile

# Development

## Defining image version and name

The Dockerfile or Dockerfile.base used to build the images contains some
metadata based on (mis)use of Docker's ARG parameter. This allows parameterless
image rebuild and container launch scripts. You should not change the image
metadata unless you have a specific reason for it: reusing the same tag will
simplify things especially in Vagrant.

## Building the docker images

Buildbot depends on pre-built images. To (re)build a worker:

    cd buildbot-host
    ./rebuild.sh <worker-dir>

For example

    ./rebuild.sh buildbot-worker-ubuntu-2004

To build the master:

    ./rebuild.sh buildmaster

To rebuild all containers (master and workers):

    ./rebuild-all.sh

Due to docker caching you can typically rebuild everything in a few seconds if
you're just changing config files.

## Changing buildmaster configuration

Buildmaster has several configuration files:

    * **master.cfg**: this is the Python code that drives logic in Buildbot; it should have as little configuration it is as possible
    * **master-default.ini**: the default master configuration, contains Docker and Git settings
    * **master.ini**: overrides settings in master-default.ini completely, if present
    * **worker-default.ini**: the default worker configuration, contains a list of workers and their settings
    * **worker.ini**: overrides settings in worker-default.ini completely, if present

While you can launch a buildmaster with default settings just fine, you
probably want to copy *master-default.ini* and *worker-default.ini* as *master.ini*
and *worker.ini*, respectively, and adapt them to your needs.

It is possible to do rapid iteration of buildmaster configuration. For example:

    vi buildmaster/master.cfg
    docker container stop buildmaster
    ./rebuild.sh buildmaster

Then from the "buildmaster" subdirectory:

    ./launch.sh v2.0.0

# Debugging

## Worker stalling in "Preparing worker" stage

If your workers hang indefinitely at "Preparing worker" stage then the problem
is almost certainly a broken container image. Usually building the Docker image
failed in a way that buildbot did not install properly, which caused the "CMD"
at the end of the Dockerfile to fail. The fix is to nuke the image, fix the problem and
rebuild the image. Get the ID of the image that does not work:

    docker container ls

Remove it:

    docker container rm -f <id>

(Attempt to) Fix the problem. Then rebuild the image and ensure that the process works:

    cd buildbot-host
    ./rebuild.sh buildbot-worker-<something>

The rebuild.sh expect a worker directory as its one and only parameter.

## Debugging build or connectivity test issues

Probably the easiest way debug issues on workers (e.g. missing build
dependencies, failing t_client tests) is to just add a "sleep" build step to
master.cfg right after the failing step. For example:

    factory.addStep(steps.ShellCommand(command=["sleep", "36000"]))

This prevents buildmaster from destroying the latent docker buildslave before
you have had time to investigate. To log in to the container use a command like
this:

    docker container exec -it buildbot-ubuntu-1804-e8a345 /bin/sh

Check "docker container ls" to get the name of the container.

## Simulating always-on buildbot workers

Buildbot launches the docker workers on-demand, so there are only two use-cases for non-latent always-on docker workers:

* Initial image setup: figuring out what needs to be installed etc.
* Simulating always-on workers: this can be useful when developing master.cfg

The always-on dockerized workers get their buildbot settings from \<worker-dir\>/env that
you should modify to look something like this:

    BUILDMASTER=buildmaster
    WORKERNAME=ubuntu-2004-alwayson
    WORKERPASS=vagrant

You also need to modify buildmaster/worker.ini to include a section for your
new always-on worker:

    [ubuntu-2004-static]
    type=normal

Then rebuild and relaunch buildmaster as shown above. Now you're ready to launch your new worker manually:

    cd buildbot-host
    ./launch.sh <worker-dir>

For example:

    ./launch.sh buildbot-worker-ubuntu-2004

## Wiping buildmaster's database

This may be necessary if buildmaster gets stuck with failing latent docker workers

    sudo rm /var/lib/docker/volumes/buildmaster/_data/libstate.sqlite

This way buildmaster stops trying to use the old, broken worker config over and
over again and stalling while doing so. There may be a way to cancel the
failing build requests, but this is good enough in a Vagrant environment where
OpenVPN buildbot development happens.

# Usage

## Launching the buildmaster

Buildmaster uses a separate launch script:

    cd buildbot-host/buildmaster
    ./launch.sh v2.0.0

Note that you need to rebuild the buildmaster image on every configuration
change, but the process is really fast.

## Launching non-latent workers

Right now there is only one and you can launch with Vagrant:

    vagrant up buildbot-worker-windows-server-2019

It will automatically connect to the buildmaster if provisioning went well.
That said, provisioning Windows tends to be way more unreliable than
provisioning Linux, so you may have to destroy and rebuild it a few times. The
main reason for provisioning failures are the reboots that are required:
Vagrant is sometimes unable to re-establish WinRM connectivity when the VM
comes back up.

# Appendix 1: differences between build configurations

These are some of the current and past differences between the buildbot
workers, builders and projects being built.

## Worker / operating system level

* openbsd-49-i386: needs --disable-plugin-auth-pam
* macosx-amd64: different home directory: /Users/buildbot
* t_client tests that are enabled vary between workers

## Builder level

* OpenSSL and mbedTLS builders without any other configure flags must run unit tests
* Some builders (e.g. openvpn-build, MSVC Windows builds) are very special

## Project level

Right now this environment only supports OpenVPN 2.x. But there's nothing
preventing from doing CI/CD for other projects using the same framework:

* OpenVPN 2.x
* OpenVPN 3.x
* tap-windows6
* win-dco
