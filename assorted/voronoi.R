library(deldir)

x <- runif(800)
y <- runif(800)

# Calculate Voronoi tessellation and Delaunay triangulation
vtess <- deldir(x, y)
par(mar = rep(2, 4)) # may need adjustment
plot(x, y, type="n", asp=1)

# Voronoi tesselation
plot(vtess, wlines="tess", wpoints="none", number=FALSE, add=TRUE, lty=1, col = "red")

# Delaunay triangulation
plot(vtess, wlines="triang", wpoints="none", number=FALSE, add=TRUE, lty=1, col="blue")

# http://flowingdata.com/2016/04/12/voronoi-diagram-and-delaunay-triangulation-in-r/