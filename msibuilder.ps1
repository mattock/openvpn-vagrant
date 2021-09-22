param ([string] $workdir)

Write-Host "Installing dependencies for building MSI packages"

& choco.exe install -y git --params "/GitAndUnixToolsOnPath"

# Chocolatey package bundles WiX version too old for building ARM64 MSIs.
#& choco.exe install -y wixtoolset

Invoke-WebRequest -Uri https://wixtoolset.org/downloads/v3.14.0.4118/wix314.exe -Outfile "${workdir}/wix314.exe"
& "${workdir}/wix314.exe" /q

# Install cmake: used to build openvpn-gui
& choco.exe install -y cmake
