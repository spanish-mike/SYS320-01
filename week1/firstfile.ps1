

# get Ipv4 address from ethernet0 interface
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like "Ethernet0"}).IPAddress

# Get IPv4 PrefixLength from Ethernet0 Interface
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like "Ethernet0"}).PrefixLength

# Show what classes there is of Win32 libaray that starts with Net, sort alphabetically
#Get-WmiObject -List | Where-Object {$_.Name -ilike "win32_Net*" } | Sort-Object

# Get dhcp server ip and hide the table headers
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | select IPAddress | Format-Table -HideTableHeaders

# Get dns server ips and display only the first one
#(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet0"}).ServerAddresses[0]

# Choose a directory whhere you have some .ps1 files
#cd $PSScriptRoot


# List files based on the file name
#$files=(Get-ChildItem)
#for ($j=0; $j -le $files.Length; $j++){
#    
#    if($files[$j].Name -ilike "*ps1") {
#        Write-Host $files[$j].Name
#    }
#}

# Create folder if it does not exist
#$folderpath="$PSScriptRoot\outfolder"
#if (Test-Path -Path $folderpath){
#    Write-Host "Folder already Exists"
#}
#else{
#    New-Item -ItemType "directory" -Path $folderpath
#}

#cd $PSScriptRoot
#$files=Get-ChildItem

#$folderpath = "$PSScriptRoot/outfolder/"
#$filePath = Join-Path -Path $folderpath "out.csv"

#$files | Where-Object {$_.Extension -eq ".ps1"} | `
#Export-Csv -Path $filePath

$files = Get-ChildItem -Recurse -File
$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log'}
Get-ChildItem -Recurse -File
