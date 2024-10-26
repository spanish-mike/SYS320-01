. (Join-Path $PSScriptRoot FunctionsAndEventLogs.ps1)


$loginoutsTable = getEventLogs  15
$loginoutsTable

$loginoutsTable = getStartAndShutDownLogs 25
$loginoutsTable

