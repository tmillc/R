library(deldir)
#library(c("sp", "maps", "maptools", "mapproj"))

x <- runif(800)
y <- runif(800)

#x <- rnorm(5, 0, 1)
#y <- rnorm(5, 0, 1.5)

#x <- floor(rnorm(300, 0, 1))
#y <- floor(rnorm(300,0,1.5))

#x <- rbinom(10, 30, 0.5)
#y <- rbinom(10, 30, 0.5)

# Calculate Voronoi tessellation and Delaunay triangulation
vtess <- deldir(x, y)
par(mar = rep(2, 4)) # may need adjustment
plot(x, y, type="n", asp=1)
#polygon(x, y, col = "wheat")
#polygon(4*(x+mean(x))/5, 4*(y+mean(y))/5, col = "tomato")
#polygon(sample(unique(x), 3), sample(unique(y), 3), col = "cyan4")
#points(x, y, pch=19, col="green", cex=0.5)

# plot the results of deldir(), specifying wlines as “tess” to to plot a Voronoi diagram
# and add to TRUE too add the diagram to the current plotting window.
plot(vtess, wlines="tess", wpoints="none", number=FALSE, add=TRUE, lty=1, col = "red")

# Delaunay triangulation
#plot(x, y, type="n", asp=1)
plot(vtess, wlines="triang", wpoints="none", number=FALSE, add=TRUE, lty=1, col="blue")
#points(x, y, pch=20, col="black", cex=0.5)

# see http://flowingdata.com/2016/04/12/voronoi-diagram-and-delaunay-triangulation-in-r/ for more