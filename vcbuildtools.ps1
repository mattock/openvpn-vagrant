Write-Host "Installing Visual Studio build tools"
& choco.exe install -y git --params "/GitAndUnixToolsOnPath"
& choco.exe install -y visualstudio2019buildtools
& choco.exe install -y visualstudio2019-workload-vctools
