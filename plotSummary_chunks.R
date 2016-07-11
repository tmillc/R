## @knitr base1

x<-1:100; y<-x+rnorm(100)
plot(x,y)

## @knitr lat_xyplot

library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality, pch = 12) # options from base, see ?par and ?points
xyplot(Ozone ~ Wind | as.factor(Month), data = airquality, layout = c(5,1))

## @knitr ggp_qplot

library(ggplot2)
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, facets = drv ~ .) + geom_smooth(method="lm")
qplot(y=hwy, data = mpg, color=drv)
qplot(drv, hwy, data = mpg, geom = "boxplot", color=manufacturer)
qplot(hwy, data = mpg, fill = drv, geom = "density")