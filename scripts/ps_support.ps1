Set-StrictMode -Version Latest
Set-PSDebug -Trace 2
function CheckLastExitCode {
    param ([int[]]$SuccessCodes = @(0))

    if (!$?) {
        Write-Host "Last CMD failed" -ForegroundColor Red
        exit 1
    }

    if ((Test-Path variable:\lastExitCode) `
      -and ($SuccessCodes -notcontains $lastExitCode)) {
        Write-Host "EXE RETURNED EXIT CODE $lastExitCode" -ForegroundColor Red
        exit $lastExitCode
    }
}
