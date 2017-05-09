library(ggplot2)
library(help="datasets")

str(mpg)

qplot(displ, hwy, data = mpg)

qplot(displ, hwy, data = mpg, color = drv)

qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

qplot(hwy, data = mpg, fill = drv)

qplot(displ, hwy, data = mpg, facets = .~ drv)

qplot(hwy, data = mpg, facets = drv ~., binwidth = 2)


