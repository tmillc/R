data(cars)
str(cars)
plot(cars$speed ~ cars$dist)
pts <- lowess(cars$dist, cars$speed, f = 0.4)  # or cars$speed ~ cars$dist.
# f is smoothing, default=0.66
# the x values of pts are the x values of cars
lines(pts)
plot(pts)

x <- rnorm(100); y <- rnorm(100) + x

plot(x,y)
pts1 <- lowess(x, y, f = 0.1)
pts2 <- lowess(x,y, f = 0.8)
lines(pts1, col="blue")
lines(pts2, col="red")
?legend
title(main = "ZELDA", xlab = " ", ylab = " ")
legend("right", title = "Legend", legend = c("x", "y"))
plot.new()

A <- data.frame(x,y)
g <- ggplot(A, aes(x, y))
print(g + geom_point(aes(color=cat)) + geom_smooth(aes(color=cat)))
pts1 <- as.data.frame(lowess(A$x, A$y, f = 2/3))
pt2 <- lowess(A$x, A$y, f = 1/2)

