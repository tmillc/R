# not included: lattice, ggplot2, ggvis

data(cars)  # from 1920s, speed(mph) and stopping distance (ft)
plot(cars)  # will guess that you want names(cars) for plot labels
plot(x = cars$speed, y = cars$dist) # will set labels as cars$speed, cars$dist
plot(x = cars$speed, y = cars$dist, xlab = "Speed")
plot(x = cars$speed, y = cars$dist, xlab = "Speed", ylab = "Stopping Distance")
plot(cars, main = "Plot Title", sub = "Subtitle")
plot(cars, xlim=c(10,15), col = 2, pch = 2) # red triangles, x between 10 and 15

data(mtcars)
# formula interface  y ~ x, x on x-axis, y on y-axis
boxplot(formula = mpg ~ cyl, data = mtcars)

# histograms are nice for single variables
hist(mtcars$mpg)
