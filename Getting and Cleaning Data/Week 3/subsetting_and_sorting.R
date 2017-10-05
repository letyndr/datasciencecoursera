# Subsetting and Sorting

set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1, 3)] = NA
print("X")
print(X)


print("\n")
print(X[, 1])


print("\n")
print(X[, "var1"])


print("\n")
print(X[1:2, "var2"])

# Filter all the rows with the following condition
X[(X$var1 <= 3 & X$var3 > 11), ]

X[(X$var1 <= 3 | X$var3 > 11), ]

# Dealing with missing values
X[which(X$var2 > 8), ]

# Sort
sort(X$var1)

sort(X$var1, decreasing = TRUE)

# Puts the NA values at the end of the sort
sort(X$var2, na.last = TRUE)

# Ordering the data frame by a variable
X[order(X$var1), ]

# Order by different variables
X[order(X$var1, X$var3), ]

# plyr package
library(plyr)
arrange(X, var1)

# Descending order
arrange(X, desc(var1))

# ---------------------------------------------------
# Adding a column at the end of the DF
X$var4 <- rnorm(5)

# Add the new column to the right side of DF
Y <- cbind(X, rnorm(5))

# Add the new column to the left side of DF
Y <- cbind(rnorm(5), X)

# Add rows to a DF
Y <- rbind(X, rnorm(5))