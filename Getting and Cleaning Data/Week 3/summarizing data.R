fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "restaurants.csv", method = "curl")
restData <- read.csv("restaurants.csv")

head(restData, n = 3)
tail(restData, n = 3)

summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))
# create tables
# useNA: if there are any missing values there will be another column
# specifying the number of missing values.
table(restData$zipCode, useNA = "ifany")

# Creates a 2 dimensional table 
table(restData$councilDistrict, restData$zipCode)

# is.na returns 1 when there is a NA value and 0 otherwise
# sum sums all the values of the set of values
sum(is.na(restData$councilDistrict))

# any function check if any of the values on the set
# is true
any(is.na(restData$councilDistrict))

# Check if all the values of the set satisfy the condition
all(restData$zipCode > 0)

# Sum accross columns or accross rows
colSums(is.na(restData))

all(colSums(is.na(restData)) == 0)

# VALUES WITH SPECIFIC CHARACTERISTICS

# are there any values of the set that falls into the array?
table(restData$zipCode %in% c("21212"))

table(restData$zipCode %in% c("21212", "21213"))

# Get the rows that satisfy the condition: zipcode 21212 or 21213
restData[restData$zipCode %in% c("21212", "21213"), ]


# CROSS TABS

DF = as.data.frame(UCBAdmissions)
summary(DF)
# Admit       Gender   Dept       Freq      
# Admitted:12   Male  :12   A:4   Min.   :  8.0  
# Rejected:12   Female:12   B:4   1st Qu.: 80.0  
#                           C:4   Median :170.0
#                           D:4   Mean   :188.6
#                           E:4   3rd Qu.:302.5
#                           F:4   Max.   :512.0


xt <- xtabs(Freq ~ Gender + Admit, data = DF)
#         Admit
# Gender   Admitted Rejected
# Male       1198     1493
# Female      557     1278

warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data = warpbreaks)

# Flat tables
ftable(xt)

# Size of the data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = "Mb")
