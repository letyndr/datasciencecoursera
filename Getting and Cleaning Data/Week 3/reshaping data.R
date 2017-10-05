# ************    RESHAPING DATA    *************

library(reshape2)
head(mtcars)

# ========================================================
# Melting dataframes
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n = 3)