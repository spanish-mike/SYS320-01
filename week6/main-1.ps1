. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot String-Helper.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"



$operation = $true

while($operation){

    $isValidInput = $false # variable that keeps users in the isValidInput loop
    $choice = 0

    while(-Not $isValidInput) {
        Write-Host $Prompt | Out-String
        $choice = Read-Host 

        if ($choice -notmatch "^[\d\.]+$") {            # ensures value is numeric first, if not then re-enter loop
            Write-Host "non-numeric value entered, please try again"
        } elseif ($choice -gt 0 -and $choice -le 9) {   # if valid numeric value then loop ends
            $isValidInput = $true
        } else {                                        # if invalid number then re-enter loop
            Write-Host "invalid option, please try again"
        }
    }

    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $foundName = checkUser($name)
        if ($foundName) { # if checkUser function has returned false then stop trying to add new user
            Write-Host "username is taken"
            continue # this should stop the elseif section but not exit the overall menu loop
        }

        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
        $validPassword = checkPassword($password)
        if (-Not $validPassword) { # if checkPassword function has returned false then stop trying to add new user
            Write-Host "password is invalid"
            continue # this should stop the elseif section but not exit the overall menu loop
        }
        
        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        $userExists = checkUser($name)
        if (-Not ($userExists)) {
            Write-Host "user does not exist"
            continue
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        $userExists = checkUser($name)
        if (-Not ($userExists)) {
            Write-Host "user does not exist"
            continue
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.
        $userExists = checkUser($name)
        if (-Not ($userExists)) {
            Write-Host "user does not exist"
            continue
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        $userExists = checkUser($name) #checks if user exists, if they dont then exit elseif and re-enter loop
        if (-Not ($userExists)) {
            Write-Host "user does not exist"
            continue
        }

        $amountOfDays = Read-Host -Prompt "Enter how many days worth of user logs to find" #how many days worth of logs is determined by user
        $userLogins = getLogInAndOffs $amountOfDays
        
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        $userExists = checkUser($name) #checks if user exists, if they dont then exit elseif and re-enter loop
        if (-Not ($userExists)) {
            Write-Host "user does not exist"
            continue
        }
        

        $amountOfDays = Read-Host -Prompt "Enter how many days worth of user logs to find" #how many days worth of logs is determined by user
        $userLogins = getFailedLogins $amoundOfDays
        
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    

}




