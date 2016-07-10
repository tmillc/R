source('perlin.R')
x1 <- abs(rnorm(10, 0.8, 0.2))
y1 <- abs(rnorm(10, 0.3, 0.2))

x2 <- abs(rnorm(10, 0.4, 0.1))
y2 <- abs(rnorm(10, 0.4, 0.5))
snow_x <- abs(rnorm(4, 0.4, 0.1))
snow_y <- abs(rnorm(4, 0.4, 0.5))

rain_x <- abs(rnorm(4, 0.8, 0.1))
rain_y <- abs(rnorm(4, 0.8, 0.1))

#points(x1,y1, pch=22, col="green", bg="springgreen4", cex=c(1,1,1.2,1.3,2,2,2,3,1.5,4))
#points(x2,y2, pch=24, col="blue", bg="steelblue4", cex=c(1,1,1.2,1.3,2,2,2,3,1.5,4))
points(snow_x,snow_y, pch=8, col="steelblue3", cex=c(2,4,4,3))
points(rain_x,rain_y, pch=-0x2602L, col="blue", cex=c(2,4,4,3))
