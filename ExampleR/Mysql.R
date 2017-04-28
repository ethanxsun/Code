#My SQL code example

# install the package
install.packages("RMySQL") 


# load the package
library(RMySQL)


# create a MySQL connection object
con <- dbConnect(MySQL(),
                 user = 'root',
                 password = 'password',
                 host = 'localhost',
                 dbname = 'database_name')


# connection summary
summary(con) 


# database information
dbGetInfo(con)


# list of tables in the database
dbListTables(con)


# list of fields in table city
dbListFields(con, "city")


# MYSQL data type
dbDataType(RMySQL::MySQL(), "a")
dbDataType(RMySQL::MySQL(), 1:5)
dbDataType(RMySQL::MySQL(), 1.5)


# create table in the database     
x <- 1:10
y <- letters[1:10]
trial <- data.frame(x, y, stringsAsFactors = FALSE)
dbWriteTable(con, "trial", trial)


# read entire table from the database
dbReadTable(con, "trial")


# extract rows from a table
dbGetQuery(con, "SELECT * FROM trial LIMIT 5;")


# extract data in batches
query <- dbSendQuery(con, "SELECT * FROM trial;")
data <- dbFetch(query, n = 5)


# query information
res <- dbSendQuery(con, "SELECT * FROM trial;")
dbGetInfo(res)


# latest query executed
res <- dbSendQuery(con, "SELECT * FROM trial;")
dbGetStatement(res)


# number of rows fetched from the database
res <- dbSendQuery(con, "SELECT * FROM trial;")
data <- dbFetch(res, n = 5)
dbGetRowCount(res)


# number of rows affected by the query
dbGetRowsAffected(res)


# info about columns of the table on which query has been executed
res <- dbSendQuery(con, "SELECT * FROM trial;")
dbColumnInfo(res)


# free resources
res <- dbSendQuery(con, "SELECT * FROM trial;")
dbClearResult(res)


# overwrite table in the database
x <- sample(100, 10)
y <- letters[11:20]
trial2 <- data.frame(x, y, stringsAsFactors = FALSE)
dbWriteTable(con, "trial", trial2, overwrite = TRUE)


# append data to the table in the database
x <- sample(100, 10)
y <- letters[5:14]
trial3 <- data.frame(x, y, stringsAsFactors = FALSE)
dbWriteTable(con, "trial", trial3, append = TRUE)


# remove table trial 
dbRemoveTable(con, "trial")


# disconnect from the database
dbDisconnect(con)