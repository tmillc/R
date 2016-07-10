# "Waterfall" plot -- taken from r-bloggers or somewhere

library(rgl)

# Function to plot
f <- function(x, y) sin(10 * x * y) * cos(4 * y^3) + x

nx <- 30
ny <- 100
x <- seq(0, 1, length = nx)
y <- seq(0, 1, length = ny)
z <- outer(x, y, FUN = f)

# Plot function and add lines manually
surface3d(x, y, z, alpha = 0.4)
axes3d()
for (i in 1:nx) lines3d(x[i], y, z[i, ], col = 'white', lwd = 2)



##### NOTE! RGL device close:

rgl.close()
plot3d(1:4,1:4,1:4)
rgl.open()
plot3d(1:4,1:4,1:4)
open3d()
plot3d(1:4,1:4,1:4)
