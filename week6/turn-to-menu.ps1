

. (Join-Path $PSScriptRoot Apache-Logs.ps1) # for ApacheLogs1 function
. (Join-Path $PSScriptRoot Event-Logs.ps1) # for getFailedLogins function
. (Join-Path $PSScriptRoot String-Helper.ps1) # help 

. (Join-Path $PSScriptRoot ProcessManagement-1-clone.ps1) # for chromeWillBeOpen function

$menuOptionsText = "`n"
$menuOptionsText += "Please choose your operation:`n"
$menuOptionsText += "1. Display last 10 apache logs (Utilize function ApacheLogs1 from assignment Parsing Apache Logs)`n"
$menuOptionsText += "2. Display last 10 failed logins for all users (Utilize function getFailedLogins from lab Local User Management Menu)`n"
$menuOptionsText += "3. Display at risk users (Utilize your function from lab Local User Management Menu)`n"
$menuOptionsText += "4. Start Chrome web browser and navigate it to champlain.edu - if no instances of Chrome is running (from lab Process Management - 1)`n"
$menuOptionsText += "5. Exit`n"

$isRunning = $true

while($isRunning) {

    $isValidInput = $false # variable that keeps users in the isValidInput loop
    $choice = 0

    while(-Not $isValidInput) {
        Write-Host $menuOptionsText | Out-String
        $choice = Read-Host 

        if ($choice -notmatch "^[\d\.]+$") {            # ensures value is numeric first, if not then re-enter loop
            Write-Host "non-numeric value entered, please try again"
        } elseif ($choice -gt 0 -and $choice -le 9) {   # if valid numeric value then loop ends
            $isValidInput = $true
        } else {                                        # if invalid number then re-enter loop
            Write-Host "invalid option, please try again"
        }
    }

    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        $operation = $false 
        exit
    }

    elseif($choice -eq 1){
        ApacheLogs1 | Select -Last 10 | Format-Table | Out-String
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getFailedLogins 365
        Write-Host ($notEnabledUsers | Select -Last 10 | Format-Table | Out-String)
    }

    elseif($choice -eq 3){
        #$totalFailedLogins = getFailedLogins 10 | Select User
        $enabledUsers = getEnabledUsers | Select Name | Foreach {$_.Name}
        $atRiskUsers = @()

        foreach($name in $enabledUsers) {
            $specifiedUserLogs = $totalFailedLogins | Where-Object($_.Name -match $name)
            if ($specifiedUserLogs.Count -ge 10) { $atRiskUsers += $name}
        }
        Write-Host $atRiskUsers
    }
    elseif($choice -eq 4){
        chromeWillBeOpen
        #Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }
}