rm(list=ls())
#path <- "Y://R//"
path <- "/Users/ethansun/R"
setwd(path)
getwd()



#sql
#install.packages("RMySQL")
library(RMySQL)

#connect to a network host and query
ucscDb <- dbConnect(MySQL(),
                    user="genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); 
result
dbDisconnect(ucscDb)


#connect to a database hg19
hg19 <- dbConnect(MySQL(),
                    user="genome",
                    db="hg19",
                    host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:10]

dbListFields(hg19, "affyU133Plus2") #get all fields in vector
dbGetQuery(hg19, "select count(*) from affyU133Plus2") #do query on database

affyData <- dbReadTable(hg19, "affyU133Plus2") #get table into dataframe
head(affyData)

#query records into dataframe
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affMis <- fetch(query)
hist(affMis$misMatches)
quantile(affMis$misMatches)

dbDisconnect(hg19)















#hdf5
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created <- h5createFile("./Data/example.h5"); created

#create groups
created <- h5createGroup("./Data/example.h5","foo"); created
created <- h5createGroup("./Data/example.h5", "baa"); created
created <- h5createGroup("./Data/example.h5", "foo/foobaa"); created
  
h5ls("./Data/example.h5")

#write to groups
A <- matrix(1:10, nrow = 5, ncol = 2); A
created <- h5write(A, "./Data/example.h5", "foo/A"); created

B <- array(seq(0.1, 2.0, by=0.1), dim=c(5,2,2)); B
attr(B, "scale") <- "liter"
created <- h5write(B, "./Data/example.h5", "foo/foobaa/B"); created


#write a dataset
df <- data.frame(1L:5L, seq(0,1, length.out = 5), c("ab","cde","fghi", "a", "s"),stringsAsFactors = FALSE)
h5write(df, "./Data/example.h5", "df")

h5ls("./Data/example.h5")


#reading data
readA <- h5read("./Data/example.h5", "foo/A"); readA
readB <- h5read("./Data/example.h5", "foo/foobaa/B"); readB
readdf <- h5read("./Data/example.h5", "df"); readdf

#writing and reading chunks
h5write(c(12,13,14), "./Data/example.h5", "foo/A", index=list(1:3,1))
h5read("./Data/example.h5", "foo/A")














#read from url
con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

library(XML)
con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
html = htmlTreeParse(htmlCode, useInternalNodes = TRUE)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)



#install.packages("httr")
library(httr)

#need userpass and password
url = "http://httpbin.org/basic-auth/user/passwd"
pg1 = GET(url)
pg1

pg2 = GET(url, authenticate("user", "password"))
pg2


