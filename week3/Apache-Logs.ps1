function Find-All-Visitors($targetPage, $httpCodeReturned, $nameOfWebBrowser) {
    
    Write-Host "function started"

    $realCode = " " + $httpCodeReturned + " "

    $targetLogs = Get-Content C:\xampp\apache\logs\access.log | Select-String $targetPage | Select-String $realCode | Select-String $nameOfWebBrowser

    $regex = [regex] "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}" #courtosy of ihateregex.io

    $ipList = $ipUnorganized = $regex.Match($targetLogs)

    # Get ips as pscustomobject
    $ips = @()
    for($i=0; $i -lt $ipUnorganized.Count; $i++){
     $ips += [PSCustomObject]@{ "IP" = $ipUnorganized[$i].Value; }
    }
    $ips | Where-Object { $_.IP -ilike "10.*" }

    # Count ips from number 8
    $ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
    $counts = $ipsoftens | Measure-Object
    
    Write-Host "function end"
    return $counts
}