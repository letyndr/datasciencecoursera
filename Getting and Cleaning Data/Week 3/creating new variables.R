# **********    CREATING NEW VARIABLES    **********

# CREATING SEQUENCES
s1 <- seq(1, 10, by = 2) ; s1
# [1] 1 3 5 7 9

s2 <- seq(1, 10, length = 3) ; s2
# [1]  1.0  5.5 10.0

# Create an index over the vector
x <- c(1, 3, 8, 25, 100) ; seq(along = x)
# [1] 1 2 3 4 5

# =============================================
# SUBSETTING VARIABLES
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearme)


# Creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

# ==============================================
# Creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)
# (-2.123e+04,2.12e+04]  (2.12e+04,2.122e+04] (2.122e+04,2.123e+04] (2.123e+04,2.129e+04] 
#                   337                   375                   282                   332

table(restData$zipGroups, restData$zipCode)


library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)


# Factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

# Levels of factor variables
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesnofac <- factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes")
as.numeric(yesnofac)

# Cutting produces factor variables
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

# Using the mutate function
library(Hmisc) ; library(plyr)
restData2 = mutate(restData, zipGroups = cut2(zipCode, g = 4))
table(restData2$zipGroups)


