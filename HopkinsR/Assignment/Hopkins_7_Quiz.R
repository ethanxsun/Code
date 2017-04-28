library(datasets)
data(iris)
head(iris)
?iris  #find document

#test

s <- split(iris, iris$Species) #split a data frame
s
class(s) # list

#try with colMean function
r1 <- lapply(s, function(x) colMeans(x[, c("Sepal.Length","Sepal.Width")]))
r1 <- sapply(s, function(x) colMeans(x[, c("Sepal.Length","Sepal.Width")]))
r1
class(r1)
round(r1["Sepal.Length","virginica"],0)

#try use apply
iris[ , 1:4]
r2 <- apply(iris[ , 1:4], 2, mean) #°´ÁĞ¼ÆËãfun
r2

library(datasets)
data(mtcars)
head(mtcars)

plot(mtcars$cyl)
hist(mtcars$cyl)
hist(mtcars$mpg)

tapply(mtcars$mpg, mtcars$cyl, mean)
lapply(split(mtcars$mpg, mtcars$cyl), mean)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
with(mtcars, tapply(mpg, cyl, mean))

r3 <- lapply(split(mtcars$mpg, mtcars$cyl), mean)
r3
round(r3$`4`[1] - r3$`8`[1], 0)

debug(ls)

