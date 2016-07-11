## @knitr base_loads
x<-1:100
y<-x+rnorm(100)

## @knitr base_plot
plot(x,y)

## @knitr base_box
boxplot(x)

## @knitr base_hist
hist(x)

## @knitr lat_loads
library(lattice)
library(datasets)

## @knitr lat_xyplot
xyplot(Ozone ~ Wind, data = airquality, pch = 12)
xyplot(Ozone ~ Wind | as.factor(Month), data = airquality, layout = c(5,1))

## @knitr lat_bw
bwplot(Ozone ~ Wind, data= airquality)

## @knitr ggp_loads
library(ggplot2)

## @knitr ggp_qplot
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, facets = drv ~ .) + geom_smooth(method="lm")
qplot(y=hwy, data = mpg, color=drv)
qplot(drv, hwy, data = mpg, geom = "boxplot", color=manufacturer)
qplot(hwy, data = mpg, fill = drv, geom = "density")

## @knitr ggp_geom_point
g <- ggplot(mpg, aes(cyl, cty))
g + geom_point()