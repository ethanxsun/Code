rm(list = ls())

## lattice

library(lattice)
library(datasets)

xyplot(Ozone ~ Wind, data = airquality)

# show multiple panels by |
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

# trellis obj to print plot
p <- xyplot(Ozone ~ Wind, data = airquality) # generate trellis obj
print(p)

# show 2 panels
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50); f
y <- x + f - f*x + rnorm(100, sd = 0.5); plot(x, y)
f = factor(f, labels = c("Group 1", "Group 2")); f
xyplot(y ~ x |f, layout = c(2,1))


xyplot(y ~ x | f, panel = function(x, y, ...){
        panel.xyplot(x, y, ...)
        panel.lmline(x, y, col = 2)
})


## ggplot2

library(ggplot2)
#library(help="datasets")

str(mpg)

qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)

# geom
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

# fill
qplot(hwy, data = mpg, fill = drv)

# density
qplot(displ, data = mpg, geom = "density")
qplot(displ, data = mpg, geom = "density", color = drv)

# panel and facets
qplot(displ, hwy, data = mpg, facets = .~ drv)

# scatterplot and multiple regression line
qplot(displ, hwy, data = mpg, color = drv)
qplot(displ, hwy, data = mpg, color = drv, geom = c("point", "smooth"), method = "lm")

# scatterplot and panels
qplot(displ, hwy, data = mpg, facets = .~drv, geom = c("point", "smooth"), method = "lm")

qplot(hwy, data = mpg, facets = drv ~., binwidth = 2)
