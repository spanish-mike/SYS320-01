#$logArray = @()
$loginouts = Get-EventLog -Logname System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @() #empty array to fill with logs

for($i=0; $i -lt  $loginouts.Count; $i++){

# Creating event property value
$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

# Creating user property value
$userSID = $loginouts[$i].ReplacementStrings[1]

$user = (New-Object System.Security.Principal.SecurityIdentifier($userSID)).Translate([System.Security.Principal.NTAccount])

#adding each new line (in the form of custom object)
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeWritten; `
                                       "Id" = $loginouts[$i].EventID; `
                                    "Event" = $event; `
                                     "User" = $user;
                                    }
# end of for loop :)
}
$loginoutsTable