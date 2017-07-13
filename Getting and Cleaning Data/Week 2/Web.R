# con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
# htmlCode = readLines(con)
# close(con)
# htmlCode

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, '//title', xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

library(httr)
html2 = GET(url)
content2 = content(html2, as="text")
parseHtml = htmlParse(content2, asText = T)
xpathSApply(parseHtml, '//title', xmlValue)

pg1 = GET("http://httpid.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg1


# Handles
google = handle("http://google.com")
pg1 = GET(handle = google, path = "/")
pg1 = GET(handle = google, path = "search")


# http://wwww.r-bloggers.com/?s=Web+Scraping
# http://cran.r-project.org/web/packages/httr/httr.pdf