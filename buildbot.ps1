Write-Host "Setting up buildbot"
$vboxfs = "C:\vagrant"
$workdir = "C:\Users\vagrant\buildbot"

& pip.exe --no-cache-dir install twisted[tls]
& pip.exe --no-cache-dir install buildbot_worker==3.1.0
New-item -Type directory $workdir
Copy-Item "${vboxfs}\buildbot-host\buildbot-worker-windows-server-2019\buildbot.tac" $workdir
#& twistd.exe --nodaemon --python=buildbot.tac 
