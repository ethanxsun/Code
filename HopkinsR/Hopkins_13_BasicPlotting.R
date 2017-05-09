# week 13 basic plotting

library(datasets)
hist(airquality$Ozone)

library(datasets)
with(airquality, plot(Wind, Ozone))

library(datasets)
airquality = transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone")




# global basic plotting parametersß
par("lty")
par("col")
par("pch")
par("bg")
par("mar")
par("mfrow")


# plot with annotation
library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in new york city")

library(datasets)
with(airquality, plot(Wind,Ozone, main = "Ozone and Wind in new york city"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col="blue"))

with(airquality, plot(Wind,Ozone, main = "Ozone and Wind in new york city"), type = "n")
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))



# plot with regression line
with(airquality, plot(Wind,Ozone, main = "Ozone and Wind in new york city"), pch = 20)
model = lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)



# plot with multiple charts
par(mfrow = c(1, 2)) # set number of plot per row
with(airquality,{
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})


par(mfrow = c(1, 3)) # set number of plot per row
with(airquality,{
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
        plot(Temp, Ozone, main = "Ozone and Temperature")
        mtext("Ozone and weather in new york city", outer = TRUE)
})



# check point example
par(mfrow = c(1,1))
example(points)



x <- rnorm(100)
y <- x + rnorm(100)
plot(x, y, type = "n")    # make the plot but not use data
plot(x, y)
        







