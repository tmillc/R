
library(deldir)
library(animation)
library(plotrix)

ani.options(interval=.05)
n <- 10   # frames of animation

saveGIF({
  for (i in 1:n) {

    # random uniform variables
    x <- runif(800)
    y <- runif(800)

    # Calculate tessellation and triangulation
    vtess <- deldir(x, y)
    par(mar = rep(2, 4)) # margin sizes
    plot(x, y, type="n", asp=1)  # new plot

    # voronoi tessellation
    plot(vtess, wlines="tess", wpoints="none", number=FALSE, add=TRUE, lty=1, col = "red")
    # delaunay triangulation
    plot(vtess, wlines="triang", wpoints="none", number=FALSE, add=TRUE, lty=1, col="blue")
  }
})