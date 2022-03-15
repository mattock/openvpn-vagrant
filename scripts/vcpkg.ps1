param ([string] $workdir,
       [switch] $debug)

if ($debug -eq $true) {
  . $PSScriptRoot\ps_support.ps1
}

if (-Not (Test-Path $workdir)) {
  New-Item -Type directory $workdir
  if ($debug -eq $true) { CheckLastExitCode }
}

Write-Host "Installing and setting up vcpkg"

if (-Not (Test-Path "${workdir}\vcpkg")) {
  & git.exe clone https://github.com/microsoft/vcpkg.git "${workdir}\vcpkg"
  if ($debug -eq $true) { CheckLastExitCode }
}

# Bootstrap vcpkg
& "${workdir}\vcpkg\bootstrap-vcpkg.bat"

# Update ports
cd "${workdir}\vcpkg"
& git.exe pull
if ($debug -eq $true) { CheckLastExitCode }

# Ensure that OpenVPN build can find the dependencies
& "${workdir}\vcpkg\vcpkg.exe" integrate install
