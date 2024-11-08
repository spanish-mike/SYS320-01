function chromeWillBeOpen() {
    $array = Get-Process | SELECT ProcessName
    if ($array -Contains "*chrome*")
    {Stop-Process -Name chrome}
    else {Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "Champlain.edu"}
}