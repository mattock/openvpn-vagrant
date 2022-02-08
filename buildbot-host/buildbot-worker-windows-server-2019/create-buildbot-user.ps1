param ([string] $password)

$buildbot_user_password = ConvertTo-SecureString $password -AsPlainText -Force
New-LocalUser -AccountNeverExpires -Description "buildbot" -FullName "buildbot" -Name "buildbot" -Password $buildbot_user_password
& net localgroup administrators buildbot /add
