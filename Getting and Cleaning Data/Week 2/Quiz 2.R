setwd('/home/letyndr/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week 2')
rm(list = ())

# QUESTION 1

# Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?

# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.


library(httr)
library(jsonlite)
library(sqldf)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")


# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
  key = "72f28ae90262ccace708",
  secret = "c27c1be0af96ac8f3a0642a63bfff82175b5a426")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)


# OR:
# req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
# stop_for_status(req)
# content(req)

# json1 is a list with the content of req
json1 <- content(req)

# Convert a JSON to a data frame
json2 <- fromJSON(toJSON(json1))
json2[json2$full_name == "jtleek/datasharing", "created_at"]




# QUESTION 2

# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.

# Download the American Community Survey data and load it into an R object called

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = 'American Community Survey.csv', method = "curl")
acs <- read.csv("American Community Survey.csv")

# Selects all the data from acs without any filter.
sqldf("select * from acs")

# Selects pwgtp1 column from acs without any filter.
sqldf("select pwgtp1 from acs")

# Selects pwgtp1 column from acs getting just the elements where AGEP is less than 50
# CORRECT ANSWER!!!
sqldf("select pwgtp1 from acs where AGEP < 50")

# Syntax Error
sqldf("select * from acs where AGEP < 50 and pwgtp1")




# QUESTION 3

# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

# Error in rsqlite_send_query(conn@ptr, statement) : 
#   near "unique": syntax error
sqldf("select unique * from acs")


# CORRECT ANSWER!!!
sqldf("select distinct AGEP from acs")


# Error in rsqlite_send_query(conn@ptr, statement) : 
#   near "unique": syntax error
sqldf("select AGEP where unique from acs")


# Selects the distinct values from pwgtp1 
sqldf("select distinct pwgtp1 from acs")


# QUESTION 4

# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

# http://biostat.jhsph.edu/~jleek/contact.html

# (Hint: the nchar() function in R may be helpful)

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[10])		# 45
nchar(htmlCode[20])		# 31
nchar(htmlCode[30])		# 7
nchar(htmlCode[100])	# 25


# QUESTION 5

# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.

# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

# (Hint this is a fixed width file format)


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile = "Question 5.csv", method = "curl")
q5_df <- read.fwf(file = "./data/q5_data.for", widths = c(15, 4, 1, 3, 5, 4), header = FALSE, sep = "\t", skip = 4)
head(q5_df)

sum(q5_df$V6)
