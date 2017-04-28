rm(list=ls())
path <- "E://R//"
path <- "Y://R//"
path <- "/Users/ethansun/R"
setwd(path)
getwd()



#download data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = ".//Data//housing.csv")
dateDownLoaded <- date()

#read csv
housingData <- read.csv(".//Data//housing.csv", header = TRUE, stringsAsFactors = TRUE)
head(housingData)
str(housingData)

#How many properties are worth $1,000,000 or more?
hist(housingData$VAL)
housingData$VAL
sum(housingData$VAL >= 24,na.rm = T) #VAL above 1M

str(housingData$FES)
summary(housingData$FES)
hist(housingData$FES)






#read excel
install.packages("xlsx")
library(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx(".//Data//NGAP.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex);dat
sum(dat$Zip*dat$Ext,na.rm=T)







#read xml
install.packages("XML")
library(XML)

#fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#download.file(fileURL, destfile = ".//Data//restaurants.xml")

fileURL <- ".//Data//restaurants.xml"
doc <- xmlTreeParse(fileURL, useInternalNodes = TRUE) #parse xml
rootNode <- xmlRoot(doc) #get root
xmlName(rootNode) #get root name
xmlSApply(rootNode,xmlValue)
#How many restaurants have zipcode 21231?
zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
sum(zipcodes == "21231")








#using data table
library(data.table)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
#download.file(fileURL, destfile = ".//Data//housing1.csv")
DT <- fread(".//Data//housing1.csv");DT
hist(DT$pwgtp5)
#which way is most fastest
system.time(DT[,mean(pwgtp15),by=SEX])

