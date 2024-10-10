<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function checkPassword($inputPassword) {
    
    if ($inputPassword.Length -lt 6) { # if password is less than 6 length then return false
        Write-Host "less than 6"
        return $false
    }
    if ($inputPassword -notlike '*[a-zA-Z]*') { # if no letters found then return false
        Write-Host "no letters"
        return $false
    }
    if ($inputPassword -notlike "*[0-9]*") { # if no numbers found then return false
        Write-Host "no numbers"
        return $false
    }
    if ($inputPassword -notlike '*[^a-zA-Z0-9]*') { # is no special characters are found then return false
        Write-Host "no special characters"
        return $false
    }

    return $true # if none of the checks get flagged then password is valid and function returns true
}