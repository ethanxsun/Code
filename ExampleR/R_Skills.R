# build-in dataset
data()

data(Cars93, package="MASS")
head(Cars93)
summary(Cars93)


# read table from html
library(XML)
url = "https://en.wikipedia.org/wiki/World_population"
tbls = readHTMLTable(url)


# read fix width table
data <- read.fwf("./Data/week.from", widths = c(9,-5,4,-1,3,-5,4,-1,3,-5,4,-1,3,-5,4,-1,3), skip = 5, stringsAsFactors = F)

# read complex table
worldseries <- scan("./Data/WorldSeries.txt",
             skip=35,
             nlines=23,
             what = list(year = integer(0),
                         pattern = character(0)))
worldseries

order <- order(worldseries$year); order
worldseries <- list(year = worldseries$year[order],
                    pattern = worldseries$pattern[order])
worldseries$year

# use which()
set.seed(12345)
x <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15)); x
x$var2[c(1,3)] <- NA ; x

x[x$var2 > 8, ] # na is showing
which(x$var2 > 8)
x[which(x$var2 > 8), ] # remove na

#hello


