# An attempt to create an image of geologic layers

library(ggplot2)
l1 <- rnorm(100, mean = 100, sd = 10)
l2 <- rnorm(100, mean = 200, sd = 80)
l3 <- rnorm(100, mean = 300, sd = 90)
l4 <- rnorm(100, mean = 400, sd = 120)
levs <- c(l1, l2, l3, l4)
layers <- as.ordered(c(rep("L1", 100), rep("L2", 100), rep("L3", 100), rep("L4", 100)))
ll <- c(rep(1, 100), rep(2, 100), rep(3, 100), rep(4, 100))
data <- data.frame(elev = levs, zone = layers)
g <- ggplot(data, aes(x=elev))
g + geom_histogram(aes(fill=layers)) + coord_cartesian(ylim=c(0,1000))

data <- data.frame(vals = rnorm(100))
cutpoints <- quantile(data$vals, seq(0,1, length=5), na.rm = TRUE)
data$fac <- cut(data$vals, cutpoints)
levels(data$fac)
data
