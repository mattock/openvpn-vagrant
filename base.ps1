# Preferred language and keyboard layout
$lang = "fi-FI"

Write-Host "Setting keyboard layouts"
$languages = New-WinUserLanguageList -Language $lang
$languages.Add($lang)
Set-WinUserLanguageList $languages -Force

if (-Not (Test-Path C:\ProgramData\chocolatey\bin\choco.exe)) {
    Write-Host "Installing Chocolatey"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
