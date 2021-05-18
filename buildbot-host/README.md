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

# Usage

## Building the docker images

Buildbot depends on pre-built images. To (re)build a worker:

    cd buildbot-host
    ./rebuild.sh <name-of-worker> <version-tag>

For example

    ./rebuild.sh buildbot-worker-ubuntu-2004 v1.0.0

To build the master:

    ./rebuild.sh buildmaster v2.0.0

## Launching the buildmaster

Buildmaster uses a separate launch script:

    cd buildbot-host/buildmaster
    ./launch.sh v2.0.0

where "v2.0.0" is the tag you gave when you built the image.

## Launching buildbot workers

Buildbot launches the docker workers on-demand, so you should only launch
workers for debugging purposes:

    cd buildbot-host
    ./launch.sh <name-of-worker> <version-tag>

For example:

    ./launch.sh buildbot-worker-ubuntu-2004 v1.0.0
