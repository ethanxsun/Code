# function 1: calculate mean value of sulfate or nitrate
pollutantmean <- function (directory, pollutant, id = 1:322){
  #directory <- c("specdata")
  #id <-1:20
  target.dir <- c("C:/Work/DataAnalytics/HopkinsDataScience/Course2_Wk2_ProgrammingWithR")
  location <- paste(target_dir,"/",directory,sep="")
  setwd(location)
  #character vector
  files <- list.files(location)
  str(files)
  print(n<-length(files))
  
  #input vector length is 1
  if(length(id)==1){
    weather <- read.table(files[id], header=TRUE, stringsAsFactors = FALSE, sep=",")
  } else {
    print("here")
    #input vector length is more than 1
    print(n<-length(id))
    print(id)
    #read first file data
    weather <- read.table(files[id[1]], header=TRUE, stringsAsFactors = FALSE, sep=",")
    #append next file data
    for(i in id[2:n]){
      #print(paste("sequence is",i))
      #print(paste("filename is:", files[i]))
      next.line <-read.table(files[i], header=TRUE,stringsAsFactors = FALSE, sep = ",")
      #print("successful")
      weather <- rbind(weather,next.line)
    }
  }
  
  if(pollutant == "sulfate"){
    return(mean(weather$sulfate, na.rm = TRUE))
  }
  
  if(pollutant == "nitrate"){
    return(mean(weather$nitrate, na.rm = TRUE))
  }
}

print("result1******************************************************")
#pollutantmean(directory="specdata",pollutant="sulfate",id=1:10)
#pollutantmean(directory="specdata",pollutant="nitrate", id=70:72)
#pollutantmean(directory="specdata",pollutant="sulfate", id=34)
pollutantmean(directory="specdata",pollutant="nitrate", id=1:323)

#function 2: check completeness of the data read
complete <- function (directory , id = 1:323){
  
  target.dir <- c("C:/Work/DataAnalytics/HopkinsDataScience/Course2_Wk2_ProgrammingWithR")
  location <- paste(target_dir,"/",directory,sep="")
  setwd(location)
  
  #文件名列表
  files <- list.files(location)
  
  if(length(id) == 1){
    table1 <- read.table(files[id], header=TRUE, stringsAsFactors = FALSE, sep=",")
    complete.table <- table1[complete.cases(table1),]
    nobs <- nrow(complete.table)
    return(data.frame(id , nobs))
  } else {
    n <- length(id)
    print(paste("vector length =",n))
    
    first <- read.table(files[id[1]], header=TRUE, stringsAsFactors = FALSE, sep=",")
    complete <- first[complete.cases(first) , ]
    frame2 <- data.frame(id[1], nrow(complete))
    names(frame2) <- c("id","nobs")
    print(frame2)
    
    print("append the rest")    # 循环读取余下的文件
    for (i in id[2:n]){
      #print(paste("i is",i))
      ithfile <- read.table(files[i], header=TRUE, stringsAsFactors = FALSE, sep=",")
      ithfile.complete <- ithfile[complete.cases(ithfile) , ]
      frame2 <- rbind(frame2, c(i,nrow(ithfile.complete)))
    }
    return(frame2)
  }
}

print("function 2 result****************************************")
#print(complete (directory = "specdata", id = 30:25))
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 300))
print(cc$nobs)

cc <- complete("specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

#function 3: 
corr <- function (threshold = 0){
  #输入：文件夹名，threshold
  #读取所有文件，并获得查询表
  lookup <- complete(directory = "specdata", id = 1:323)
  #print(lookup)
  #读取所有大于threshold的id
  ids <- lookup[lookup$nobs >= threshold,1]
  #print(ids)
  
  #创建存储相关性结果的空vector
  result <- NULL
  
  #依次读取这些文件，并计算相关系数
  for (index in ids){
    #print(index)
    #print(paste("here",files[index]))
    eachfile <- read.table(files[index], header=TRUE, stringsAsFactors = FALSE, sep=",")
    completefile <- eachfile[complete.cases(eachfile),]
    coreach <- cor(completefile$sulfate, completefile$nitrate)
    result <- append(result, coreach)
  }
  #获得结果集
  print(result)
  return(result)
}

print("function 3 result*********************************************")
cr <- corr()                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)


cr <- corr(129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)


cr <- corr(2000)                
n <- length(cr)                
cr <- corr(1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))
