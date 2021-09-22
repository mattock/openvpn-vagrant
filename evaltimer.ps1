# Reset eveluation timer if necessary. This can be repeated six times and each
# gives 180 extra days of evaluation use.
if ((Get-Ciminstance -Class SoftwareLicensingProduct).LicenseStatus -ne 1) {
    Write-Host "Resetting license evaluation timer"
    & slmgr.vbs //B -rearm
    $need_restart = $true
}

if ($need_restart) {
    Write-Host "Rebooting to finish the license evaluation timer reset"
    # We need to schedule the restart or Vagrant will loose the WinRM
    # connection and destroy the instance as a result.
    shutdown /r /t 10
}
