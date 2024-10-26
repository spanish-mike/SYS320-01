
function ApacheLogs1 () {

    $logsNotFormatted = (Get-Content "C:\xampp\apache\logs\access.log")
    
    $logsFormatted = @() # to store formatted list

    foreach ($line in $logsNotFormatted) { # each line is dealt with one at a time in a foreach loop
    
        $splitLineList = $line.split(" ") # the current line is split up into a list, each split happening at a space

        $logsFormatted += [PSCustomObject]@{
            "IP" = $splitLineList[0]; `                      # IP is first item it grabs
            "Time" = $splitLineList[3].Replace('[', ""); `   # Time is the 4th item in list, removes excess bracket ([) at beginning
            "Method" = $splitLineList[5].Replace('"', ""); ` # Method is the 6th item, removes excess quotation mark (")
            "Page" = $splitLineList[6]; `                    # Page is 7th item
            "Protocol" = $splitLineList[7]; `                # Protocol is 8th item
            "Response" = $splitLineList[8]; `                # Response Code is 9th item
            "Referrer" = $splitLineList[10]; `               # Referer is the 11th item
            "Client" = "client name"; `
        }
    }
    return $logsFormatted | Where-Object {$_.IP -like "10.*"}
}
