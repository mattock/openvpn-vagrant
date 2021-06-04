Write-Host "Installing Visual Studio build tools"
& choco.exe install -y git --params "/GitAndUnixToolsOnPath"
& choco.exe install -y visualstudio2019buildtools
& choco.exe install -y visualstudio2019-workload-vctools

Write-Host "Rebooting to finish Visual Studio 2019 build tools installation"
shutdown /r /t 10
