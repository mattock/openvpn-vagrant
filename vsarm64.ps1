Write-Host "Setting up ARM64 support for Visual Studio"
& "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe" modify --installPath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Buildtools" --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --quiet
