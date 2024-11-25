. (Join-Path $PSScriptRoot Scraping-Classes-Function.ps1) # for The only function we need

$FullTable = gatherClasses

#List all the classes of Instructor Furkan Paligu
#$FullTable | Where-Object {$_.Instructor -ilike "Furkan Paligu"}


# list all the classes of JOYC 310 on Mondays, only display Class Code and Times
# sort by Start Time
#$FullTable | Where-Object {($_.Location -ilike "JOYC 310") -and ($_.Days -icontains "Monday")} | `
#            Sort-Object "Time Start" | `
#            Select "Time Start", "Time End", "Class Code"

#make a list of all the instructors that teach at least 1 course in
# SYS, SEC, NET, FOR, CSI, DAT
$ITSInstructors = $FullTable | Where-Object {($_."Class Code" -ilike "SYS*") -or `
                                             ($_."Class Code" -ilike "NET*") -or `
                                             ($_."Class Code" -ilike "SEC*") -or `
                                             ($_."Class Code" -ilike "FOR*") -or `
                                             ($_."Class Code" -ilike "CSI*") -or `
                                             ($_."Class Code" -ilike "DAT*")} `
                             | Sort-Object "Instructor" `
                             | Select "Instructor" -Unique

#$ITSInstructors

# Group all the instructors by the numer of classes they are teaching
$FullTable | where { $_.Instructor -in $ITSInstructors.Instructor } `
           | Group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending