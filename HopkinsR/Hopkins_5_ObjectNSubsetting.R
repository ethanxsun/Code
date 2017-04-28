getwd()
setwd("./R")
rm(list=ls())

# basic type
######################################################################
x <- c(0.5, 0.6) ## numeric
x <- c(TRUE, FALSE) ## logical
x <- c(T, F) ## logical
x <- c("a", "b", "c") ## character
x <- 9:29 ## integer
x <- c(1+0i, 2+4i) ## complex

x <- vector(mode = "numeric", length = 10)

#mixing objects
y <- c(1.7, "a") ## character
y <- c(TRUE, 2) ## numeric
y <- c("a", TRUE) ## character

#explicit coercion
x <- 0:6
class(x)
x1 <- as.numeric(x)
class(x1)  #??ֵ??????numeric
as.logical(x)
as.character(x)

x <- c("a","b","c")
as.numeric(x)
as.logical(x)
as.complex(x)

#matrices
m <- matrix(nrow = 2,ncol = 3)
m
dim(m)
attributes(m)

m <- matrix(1:6, nrow = 2, ncol=3)
m

m <- 1:10
m
dim(m) <- c(2,5) #add dim attribute/transform a vector
m

#cbind and rbind
x <- 1:3
y <- 10:12
cbind(x,y)
rbind(x,y)

#lists
m1 <- matrix(1:4, nrow = 2, ncol = 2)
x <- list(1, "a", TRUE, m1)
x

#factor
x <- factor(c("yes", "yes", "no", "yes", "no"))
x
class(x)
t1 <- unclass(x)
t1
class(t1)

x <- factor(c("yes","yes","no","yes","no"),levels = c("yes", "no"))
x
attributes(x)

#NA covers NAN
x <- c(1, 2, NA, 10, 3)
is.na(x)
is.nan(x) # all FALSE

x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

#tabular/dataframe/speical type of list
x <- data.frame(foo = 1:4, bar=c(T,T,F,F))
x
nrow(x)
ncol(x)
names(x)
attributes(x)
row.names(x) #  "1" "2" "3" "4"
x$foo
x$bar
x[1] #!!! data frame
typeof(x[1])
x[[1]] # !!! content of the data frame which is integer
typeof(x[[1]])
class(x[[1]]) # !!! integer

#name a vector
x <- 1:3
names(x)
names(x) <- c("foo","bar","norf")
names(x)
x

#name a list
x <- list(a=1, b=2, c=3)
x
names(x)
names(x) <- c("a1")
names(x) # !!! "a1" NA   NA

#name a matrix
m <- matrix(1:4, nrow = 2, ncol  = 2)
dimnames(m) <- list(c("a","b"),c("c","d"))
m 
attributes(m)
# !!????matrix??names()

# reading and write data
######################################################################
data <- read.table("foo.txt") # retrun a data frame obj

# !!! read large table
path ="./Weather_Dataset/"
initial <- read.table(paste(path,"001.csv", sep=""),nrow=100,stringsAsFactors = FALSE,header = TRUE, sep = ",")
classes <- sapply(initial, class)
print(classes)
tabAll <- read.table(paste(path,"001.csv", sep=""), sep = ",", header = TRUE, stringsAsFactors = FALSE)
tabAll

#dput and dget object with meta-data
y <- data.frame(a = 1, b = "a")
dput(y)
dput(y, file = "y.R")
new.y <- dget("y.R")
new.y

#dump multiple objects and source them
x <- "foo"
y <- data.frame(a=1,b="a")
dump(c("x","y"), file = "data.R")
rm(x,y)
source("data.R")

#read data from a connection object
con <- file(paste(path,"001.csv", sep=""),"r")
str(con)
table1 <- read.table(con,sep=",", header=TRUE,stringsAsFactors = FALSE)
table1

#read zip file
con <- gzfile("words.gz")
x <- readLines(con, 10)
x

#read URL
con <- url("http://www.coursera.org", "r")
x <- readLines(con)
head(x)
close.connection(con)

# subsetting
######################################################################
# []????ͬ???????͵Ķ?????[[]]??��subsetting list/data frame?е?Ԫ?ص????ݣ?$ is to subsetting by names
x <- c("a","b","c","c","d","a")
x[1]
x[2]
x[1:4]
x[x > "a"]  #lexical calcualtion
u <- x > "a"
u
x[u]

x <- list(foo = 1:4, bar = 0.6)
x[1]
class(x[1]) # return a list

x[[1]]
class(x[[1]]) # return a sequence of integer

x$bar
class(x$bar) #! return a numeric

x[["bar"]]
class(x[["bar"]]) #return a nemeric

x["bar"]
class(x["bar"]) #! return a list

x <- list(foo=1:4, bar=0.6, baz="hello")
x[c(1,3)] #????Ҫ??ȡ??Ԫ???б??Ӽ???ֻ????[]

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
name <- "foo"
x[[name]]
x$name #! $??ֻ?ܸ???????
x$foo

#!!! subsect list's element within a list
x <- list(a = list(10,12,14), b=c(3.14,2.81))
x
x[[c(1,3)]]
x[[1]][[3]]
x[[c(2,1)]]


# drop option for subsetting matrices
x <- matrix(1:6, 2, 3)
x
x[1,2]

x[1,]
x[, 2]

x[1,]
x[1, , drop = FALSE] #????????ά??

# partial matching
x <- list(aardvark = 1:5)
x$a  #!! partial matching happens
x[["a"]]  #!! [[]] does not support partial matching unless...
x[["a", exact = FALSE]]

# !! subsetting missing values
x <- c(1, 2, NA, 4, NA, 5)
missing <- is.na(x)
x[!missing]

x <- c(1, 2, NA, 4, NA, 5)
y <- c("a", "b", NA, "d", NA, NA)
good <- complete.cases(x, y)  #!! complete.case?Ƚ϶???vector
print(good)
x[good]
y[good]

path ="./Weather_Dataset/"
airquality <- read.table(paste(path,"001.csv", sep=""), sep = ",", header = TRUE, stringsAsFactors = FALSE)
good <- complete.cases(airquality)
good
airquality[good,]  #all good record
airquality[good,][1:6,] #!!! first 1:6 rows of all good records

#vectorized computation
x <- matrix(1:4, 2,2)
y <- matrix(rep(10,4),2,2)
x * y
x %*% y

