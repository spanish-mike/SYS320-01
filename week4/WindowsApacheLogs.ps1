#code by Miguel Kirsch

#list all apache logs of xampp
Get-Content C:\xampp\apache\logs\access.log 

#list only last 5 apache logs
#Get-Content C:\xampp\apache\logs\access.log -Tail 5

#listing all apache logs of xampp
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

# Display only logs that does not contain 200
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

# From every .log file in the directory only get the logs thhat conatins the word 'error'
#$A = Get-Content C:\xampp\apache\logs\*.log | Select-String 'error'
# Display last 5 elements of the result array
#$A[-1..-5]

# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

# Define a regex for IP addresses
$regex = [regex] "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}" #courtosy of ihateregex.io

# Get $notfounds records that match to the regex
$ipUnorganized = $regex.Match($notfounds)

# Get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipUnorganized.Count; $i++){
 $ips += [PSCustomObject]@{ "IP" = $ipUnorganized[$i].Value; }
}
$ips | Where-Object { $_.IP -ilike "10.*" }

# Count ips from number 8
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Measure-Object
$counts | Select-Object Count, Name