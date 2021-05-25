# Differences between build cnfigurations

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

* OpenVPN 2.x
* OpenVPN 3.x
    * Basic CI is possible inside Docker, connectivity tests are not
* tap-windows6
* win-dco

# Setup

No setup should be necessary if you're running this in Vagrant. In other
environments you need to run provision.sh manually. There may be failures as
provision.sh has not yet been tested outside of Vagrant.

## Relevant files and directories:

This environment utilizes a number of scripts for settings things up easily:

* provision.sh: used (by Vagrant) to set up the Docker host
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

To rebuild all containers:

    ./rebuild-all.sh

Due to docker caching you can typically rebuild everything in a few seconds if
you're just changing config files.

## Changing buildmaster configuration

It is possible to do rapid iteration of buildmaster configuration:

    vi buildmaster/master.cfg
    docker container stop buildmaster
    ./rebuild.sh buildmaster

Then from the "buildmaster" subdirectory:

    ./launch.sh v2.0.0

# Debugging

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
