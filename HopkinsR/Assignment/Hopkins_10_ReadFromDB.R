rm(list=ls())
path <- "/Users/ethansun/R"
setwd(path)
getwd()

install.packages("sqldf")
library(sqldf)
acs = read.csv("./Data/CommunitySurvey.csv", stringsAsFactors = FALSE)
head(acs)
#2
sqldf("select pwgtp1 from acs")
sqldf("select * from acs where AGEP < 50")
sqldf("select * from acs")
sqldf("select pwgtp1 from acs where AGEP < 50")

#3
unique(acs$AGEP)
hist(acs$AGEP)

#4
library(XML)
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

#5
data <- read.fwf("./Data/week.from", widths = c(9,-5,4,-1,3,-5,4,-1,3,-5,4,-1,3,-5,4,-1,3), skip = 5, stringsAsFactors = F)
class(data[,2])
data[,3]
sum(data[,4])
