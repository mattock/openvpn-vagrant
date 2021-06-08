Write-Host "Setting up openvpn build dependencies with vcpkg"
$workdir = "C:\Users\vagrant\opt"

if (-Not (Test-Path $workdir)) {
  New-Item -Type directory $workdir
}

if (-Not (Test-Path "${workdir}\openvpn")) {
  & git.exe clone -b dockertest https://github.com/mattock/openvpn.git "${workdir}\openvpn"
}

if (-Not (Test-Path "${workdir}\vcpkg")) {
  & git.exe clone https://github.com/microsoft/vcpkg.git "${workdir}\vcpkg"
}

# Bootstrap vcpkg
& "${workdir}\vcpkg\bootstrap-vcpkg.bat"

# Install OpenVPN build dependencies
$architectures = @('x64','x86','arm64')
foreach ($arch in $architectures) {
    & "${workdir}\vcpkg\vcpkg.exe" --overlay-ports="${workdir}\openvpn\contrib\vcpkg-ports" --overlay-triplets="${workdir}\openvpn\contrib\vcpkg-triplets" install "lz4:${arch}-windows-ovpn" "lzo:${arch}-windows-ovpn" "openssl-windows:${arch}-windows-ovpn" "pkcs11-helper:${arch}-windows-ovpn" "tap-windows6:${arch}-windows-ovpn"
}

# Ensure that OpenVPN build can find the dependencies
& "${workdir}\vcpkg\vcpkg.exe" integrate install
