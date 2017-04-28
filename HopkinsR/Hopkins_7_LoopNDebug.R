rm(list=ls())

#loop function
###############################################################

#lapply and sapply
#########################
x <- list(a = 1:4, b=rnorm(10), c=rnorm(20, mean=1), d=rnorm(100, mean=5))
result1 <- lapply(x, mean)
result1
class(result1)


x <- 1:4
result2 <- lapply(x, runif)  #apply runif() with 1, 2, 3, and 4
result2
class(result2)


x <- 1:4
result3 <- lapply(x, runif, min=0, max=1) #pass ... parameters
result3

x <- list(
        a=matrix(1:4, 2, 2),
        b=matrix(1:6, 3, 2)
)
lapply(x, function(elt) elt[ , 1])   #anoymous function used heavily in apply functions


x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)
#sapply will try to simplify the result of lapply if possible.
#If the result is a list where every element is length 1, then a vector is returned
#If the result is a list where every element is a vector of the same length (> 1), a matrix is returned.
#If it can¡¯t figure things out, a list is returned
sapply(x, mean)  
mean(x)


##########################
# apply on a matirx

x <- matrix(rnorm(10), 2, 5)
x
apply(x, 1, sum)  #preserve row
apply(x, 2, mean) #preserve column

rowMeans(x)  #shortcut
colMeans(x)

apply(x, 1, quantile, probs=c(0.25,0.75))   #apply a function return multiple results

##########################
# mapply is a multivariate apply of sorts which applies a function in parallel over a set of arguments

list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
mapply(rep, 1:4, 4:1)  #same

noise <- function(n, mean, sd){
        return(rnorm(n, mean, sd))
}
noise(5,2,1)
x <- list(noise(1, 1, 2), noise(2, 2, 2),
     noise(3, 3, 2), noise(4, 4, 2),
     noise(5, 5, 2))
mapply(noise, 1:5, 1:5, 2)   #same


############################
# tapply is used to apply a function over subsets of a vector. 
# I don¡¯t know why it¡¯s called tapply.

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3,10) #create factor
tapply(x, f, mean) #take group means
tapply(x, f, mean, simplify = FALSE) #Take group means without simplification

#!!! split
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3,10)
split(x,f)  #return a list after split

lapply(split(x, f), mean) # equivelant to tapply

#!!! split a data frame
library(datasets)
head(airquality)
plot(airquality$Ozone)

s <- split(airquality, airquality$Month) #split into list by month
s
class(s)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) #collapse all rows
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) #combine result nicely
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE)) #remove NA

#!!! splitting on more than one level
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
f1
f2
interaction(f1, f2) #Compute Factor Interactions
str(split(x, list(f1, f2))) #Interactions can create empty levels.
str(split(x, list(f1, f2), drop = TRUE)) #Empty levels can be dropped.


#################################################################3
## debugging

mean(z)
traceback()

lm(z ~ t)
traceback()

debug(lm)
lm(z~t)

options(error = recover)
read.csv("nosuchfile")