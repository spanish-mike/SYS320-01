. (Join-Path $PSScriptRoot Apache-Logs.ps1)

#$outputVariable = Find-All-Visitors "index.html" "200" "Chrome"

#$outputVariable | Select-Object Count, IP, Name

ApacheLogs1 | Format-Table -AutoSize -Wrap