function gatherClasses(){

    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.34/Courses.html

    #get all the tr elements of the HTML document
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    #empty array to hold results
    $FullTable = @()

    for($i=1; $i -lt $trs.length; $i++) {
        
        #Get every td element by current tr element
        $tds = $trs[$i].getElementsByTagName("td")

        #want to separate start time and end time from one time field
        $Times = $tds[5].innerText.Split("-")

        $FullTable += [PSCustomObject]@{"Class Code" = $tds[0].innerText; `
                                        "Title"      = $tds[1].innerText; `
                                        "Days"       = $tds[4].innerText; `
                                        "Time Start" = $Times[0]; `
                                        "Time End"   = $Times[1]; `
                                        "Instructor" = $tds[6].innerText; `
                                        "Location"   = $tds[9].innerText; `
                                    }

    } #end of for loop
    $FullTable = dayTranslator($FullTable)

    return $FullTable
}

function dayTranslator($FullTable){
    
    for($i=0; $i -lt $FullTable.length; $i++) {
        #empty array to hold days for every record
        $Days = @()

        #if you see "M" -> Monday
        if($FullTable[$i].Days -ilike "*M*"){ $Days += "Monday"}

        #if you see "T" -> followed by T,W, or F -> Tuesday
        if($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday"}
        #if you only see "T" -> Tuesday
        ElseIf($FullTable[$i].Days -ilike "T"){ $Days += "Tuesday"}

        #if you see "W" -> Wednedsay
        if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday"}

        #if you see "TH" -> Thursday
        if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday"}

        #if you see "F" -> Friday
        if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday"}

        #make the switch
        $FullTable[$i].Days = $Days
    }
    return $FullTable
}