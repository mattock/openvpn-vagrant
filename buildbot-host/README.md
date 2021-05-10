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
