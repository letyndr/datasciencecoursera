# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
# download.file(fileUrl, destfile = "AmericanCommunitySurvey.csv", method = "curl")
DT = fread("AmericanCommunitySurvey.csv")

print(system.time(for(i in 1:1000) { sapply(split(DT$pwgtp15,DT$SEX),mean) }))

print(system.time(for(i in 1:1000) { mean(DT$pwgtp15,by=DT$SEX) }))

print(system.time(for(i in 1:1000) { tapply(DT$pwgtp15,DT$SEX,mean) }))

print(system.time(for(i in 1:1000) { mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15) }))

print(system.time(for(i in 1:1000) { DT[,mean(pwgtp15),by=SEX] }))

# print(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])