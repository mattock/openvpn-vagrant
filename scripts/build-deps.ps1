param ([string] $workdir,
       [switch] $debug)

if ($debug -eq $true) {
  . $PSScriptRoot\ps_support.ps1
}

Write-Host "Setting up openvpn build dependencies with vcpkg"

if (-Not (Test-Path $workdir)) {
  New-Item -Type directory $workdir
  if ($debug -eq $true) { CheckLastExitCode }
}

Add-MpPreference -ExclusionPath $workdir
if ($debug -eq $true) { CheckLastExitCode }

if (-Not (Test-Path "${workdir}\openvpn")) {
  & git.exe clone -b master https://github.com/OpenVPN/openvpn.git "${workdir}\openvpn"
  if ($debug -eq $true) { CheckLastExitCode }
}

if (-Not (Test-Path "${workdir}\openvpn-build")) {
  & git.exe clone https://github.com/OpenVPN/openvpn-build.git "${workdir}\openvpn-build"
  if ($debug -eq $true) { CheckLastExitCode }
}

if (-Not (Test-Path "${workdir}\openvpn-gui")) {
  & git.exe clone https://github.com/OpenVPN/openvpn-gui.git "${workdir}\openvpn-gui"
  if ($debug -eq $true) { CheckLastExitCode }
}

cd "${workdir}\vcpkg"

# Install OpenVPN build dependencies
$architectures = @('x64','x86','arm64')
ForEach ($arch in $architectures) {
    # openssl3:${arch}-windows is required for openvpn-gui builds
    & .\vcpkg.exe --overlay-ports "${workdir}\openvpn\contrib\vcpkg-ports" --overlay-triplets "${workdir}\openvpn\contrib\vcpkg-triplets" install --triplet "${arch}-windows-ovpn" lz4 lzo openssl3 pkcs11-helper tap-windows6 "openssl3:${arch}-windows"
    & .\vcpkg.exe --overlay-ports "${workdir}\openvpn\contrib\vcpkg-ports" --overlay-triplets  "${workdir}\openvpn\contrib\vcpkg-triplets" upgrade --no-dry-run
    & .\vcpkg.exe integrate install
}

# Ensure that we can convert the man page from rst to html
& pip.exe --no-cache-dir install docutils
