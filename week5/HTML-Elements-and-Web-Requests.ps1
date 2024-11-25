
$scraped_page = Invoke-WebRequest -TimeoutSec 10 localhost/ToBeScraped.html 

# Get a count of the links in the page
#$scraped_page.Count

# display links as html element
#$scraped_page.Links

# display only URL and its text
#$scraped_page.Links | Select href, outerText | Format-List

# get outer text of every element with tag h2
#$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select outerText

# print innerText of every div eleent that has the class as "div-1"
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { $_.getAttributeNode("class").nodeValue -ilike "div-1"} | select innerText | Format-List

$h2s