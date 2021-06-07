Write-Host "Setting up openvpn build dependencies with vcpkg"
$workdir = "C:\Users\vagrant\opt"

New-Item -Type directory $workdir

& git.exe clone -b dockertest https://github.com/mattock/openvpn.git "${workdir}\openvpn"
& git.exe clone https://github.com/microsoft/vcpkg.git "${workdir}\vcpkg"

& "${workdir}\vcpkg\bootstrap-vcpkg.bat"
& "${workdir}\vcpkg\vcpkg.exe" --overlay-ports="${workdir}\openvpn\contrib\vcpkg-ports" --overlay-triplets="${workdir}\openvpn\contrib\vcpkg-triplets" install lz4:x64-windows-ovpn lzo:x64-windows-ovpn openssl-windows:x64-windows-ovpn pkcs11-helper:x64-windows-ovpn tap-windows6:x64-windows-ovpn
& "${workdir}\vcpkg\vcpkg.exe" integrate install
