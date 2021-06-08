Write-Host "Installing Visual Studio build tools"
& choco.exe install -y git --params "/GitAndUnixToolsOnPath"
& choco.exe install -y visualstudio2019buildtools --params "--installPath C:\Program Files (x86)\Microsoft Visual Studio\2019\Buildtools --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --quiet"
#& choco.exe install -y visualstudio2019-workload-vctools

Write-Host "Rebooting to finish Visual Studio 2019 build tools installation"
shutdown /r /t 30
