rm(list=ls())
path <- "Y://R//"
path <- "/Users/ethansun/R"
setwd(path)
getwd()





#read flat file
if(!file.exists("Data")){
        dir.create("Data")
}

#download file from the web
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
#download.file(fileURL, destfile = ".//Data//cameras.csv")
dateDownLoaded <- date()

#read flat files
cameraData <- read.table(".//Data//cameras.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
head(cameraData)
str(cameraData)

cameraData <- read.csv(".//Data//cameras.csv", header = TRUE, stringsAsFactors = T)
head(cameraData)
str(cameraData)

#read excel files
install.packages("xlsx")
install.packages("rJava")
#change rstuido to 32-bit operations
library(xlsx)
cameraData <- read.xlsx(".//Data//cameras.xlsx", sheetIndex = 1, header=T)
head(cameraData)

#read xlsx by col and row index
colIndex <- 2:3
rowIndex <- 1:10
cameraData <- read.xlsx(".//Data//cameras.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
cameraData

install.packages("XLConnect")






#read xml file
install.packages("XML")
library(XML)
#fileURL <- ".//Data//food.xml"
fileURL <- "./Data/food.xml"
doc <- xmlTreeParse(fileURL, useInternalNodes = T) #parse whole doc
rootNode <- xmlRoot(doc) #get root
xmlName(rootNode) #get root name

#return element of the node
rootNode[[1]] #food element
rootNode[[1]][[1]] #first value in 1st food element

#get value within xml tree
xmlSApply(rootNode,xmlValue)
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)
xpathSApply(rootNode, "//description", xmlValue)

#get value in html tree
fileURL <- "http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileURL, useInternalNodes = TRUE); doc
scores <- xpathSApply(doc, "//li[@class='score']",xmlValue); scores #parse perticular tag value
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue); teams
scores





#read json file
install.packages("jsonlite")
install.packages("curl")
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

#read nested objects in json
names(jsonData$owner)
jsonData$owner$login

#writing data frames to json
myjson <- toJSON(iris, pretty = T)
cat(myjson)

#convert back to json
iris2 <- fromJSON(myjson)
head(iris2)






install.packages("data.table")
library(data.table)

#creating data tables just like data frames
DF <- data.frame(x=rnorm(9), y=rep(c("a","b","c"), each=3), z=rnorm(9))
DT <- data.table(x=rnorm(9), y=rep(c("a","b","c"), each=3), z=rnorm(9))
head(DT,3)

#show all data tables in memory
tables()

#subsetting rows
DT[2,]
DT[DT$y=="a",]
DT[c(2,3),]

#subsetting columns
DT[, c(2,3)]

DT[ , list(mean(x),sum(z))] #pass list of function
DT[ , table(y)]
DT[ , w:=z^2] #add new column :=
DT2 <- DT
DT[ , y:=2]
DT
DT2 #change in DT also changes DT2(the copy)

DT[ , m:={tmp <- (x+z); log2(tmp+5)}] #add new column data using expression
head(DT, 3)

DT[, a:=x>0]
DT

DT[, b:=mean(x+w),by=a] #calculate mean if true(by column a)
DT

set.seed(123)
DT <- data.table(x=sample(letters[1:3],1E5,T))
DT[, .N,by=x] #count N by category

#keys
DT <- data.table(x=rep(c("a","b","c"), each=100),y=rnorm(300))
setkey(DT, x)
DT['a']

#joins/merge
DT1 <- data.table(x=c("a","a","b","dt1"),y=1:4);DT1
DT2 <- data.table(x=c("a","b","dt2"),z=5:7);DT2
setkey(DT1,x)
setkey(DT2,x)
merge(DT1, DT2)

#fast reading
big_df <- data.frame(x=rnorm(1E6),y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names = F, col.names = T, sep="\t", quote = F) #write dataframe into file
system.time(fread(file))
system.time(read.table(file,header=TRUE,sep="\t")) #fread (data.tabe package)







