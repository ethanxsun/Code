rm(list=ls())
setwd("/Users/ethansun/R")

set.seed(12345)
x <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15)); x
x$var2[c(1,3)] <- NA ; x

x[, 1]
x[, "var1"]
x[1:2 , "var2"]

x[x$var1 <= 3 & x$var3 >1, ] #subset rows with condition

x[x$var2 > 8, ] # na is showing
which(x$var2 > 8)
x[which(x$var2 > 8), ] # remove na



# sort and order
sort(x$var1)
sort(x$var1, decreasing = T)
sort(x$var2, na.last = T) # put na at last

order(x$var1) # get order id first
x[order(x$var1), ]
x[order(x$var1, x$var2) , ] #order by multiple var


# using plyr to sort
install.packages("plyr")
library(plyr)
arrange(x, var1) #sort by var1
arrange(x, desc(var1))



# add row/col
x$var4 <- rnorm(5) ; x
y <- cbind(x, rnorm(5)); y



# calculate quantile
restData <- read.csv("./Data/Restaurants.csv")
summary(restData)
str(restData)

hist(restData$councilDistrict)
quantile(restData$councilDistrict, na.rm = T)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))


# table/cross-table
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict, restData$zipCode)



# check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

colSums(is.na(restData))
all(colSums(is.na(restData))==0)



# add some line
