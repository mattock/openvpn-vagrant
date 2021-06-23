Write-Host "Setting up buildbot"
$vboxfs = "C:\vagrant"
$workdir = "C:\Users\vagrant\buildbot"

& pip.exe --no-cache-dir install twisted[tls]
& pip.exe --no-cache-dir install pywin32
& pip.exe --no-cache-dir install buildbot_worker==3.1.0
if (-Not (Test-Path $workdir)) {
  New-item -Type directory $workdir
}
Copy-Item "${vboxfs}\buildbot-host\buildbot.tac" $workdir

Write-Host "Installing vswhere.exe to used by build steps"
& choco.exe install -y vswhere

Write-Host "Configuring buildbot to launch at boot time"
& choco.exe install -y nssm
& nssm.exe install buildbot-worker C:\Python39\Scripts\twistd.exe
& nssm.exe set buildbot-worker AppParameters "--nodaemon --python=buildbot.tac"
& nssm.exe set buildbot-worker AppDirectory C:\Users\vagrant\buildbot
& nssm.exe set buildbot-worker AppExit Default Restart
& nssm.exe set buildbot-worker AppEnvironmentExtra :WORKERNAME=windows-server-2019-static
& nssm.exe set buildbot-worker AppEnvironmentExtra +WORKERPASS=vagrant
& nssm.exe set buildbot-worker AppEnvironmentExtra +BUILDMASTER=192.168.48.114
& nssm.exe set buildbot-worker AppStdout C:\Users\vagrant\buildbot\twistd.log
& nssm.exe set buildbot-worker AppStderr C:\Users\vagrant\buildbot\twistd.log
& nssm.exe set buildbot-worker AppRotateFiles 1
& nssm.exe set buildbot-worker AppRotateBytes 1073741824
& nssm.exe set buildbot-worker DisplayName buildbot-worker
& nssm.exe set buildbot-worker ObjectName .\vagrant "vagrant"
& nssm.exe set buildbot-worker Start SERVICE_AUTO_START
& nssm.exe set buildbot-worker Type SERVICE_WIN32_OWN_PROCESS
