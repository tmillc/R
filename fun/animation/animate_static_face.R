
#library(deldir)
#library(animation)
#library(plotrix)

ani.options(interval=.05)

saveGIF({
  for (i in 1:10) {
    x <- runif(800)
    y <- runif(800)

    vtess <- deldir(x, y)
    par(mar = rep(2, 4)) # may need adjustment
    plot(x, y, type="n", asp=1)
    #polygon(x, y, col = "wheat")
    #polygon(4*(x+mean(x))/5, 4*(y+mean(y))/5, col = "tomato")
    #polygon(sample(unique(x), 3), sample(unique(y), 3), col = "cyan4")
    #points(x, y, pch=19, col="green", cex=0.5)
    plot(vtess, wlines="tess", wpoints="none", number=FALSE, add=TRUE, lty=1, col = "red")
    plot(vtess, wlines="triang", wpoints="none", number=FALSE, add=TRUE, lty=1, col="blue")
    rect(0.2, 0.2, 0.8, 0.8, density = NA, col = "cadetblue3", border = "bisque4")

    #segments(0.5-0.2-rnorm(1,0,0.01), 0.35, 0.5 + 0.2+rnorm(1,0,0.01), 0.35, col='blue4')
    segments(0.5-0.2-rnorm(1,0,0.01), 0.4, 0.5, 0.35, col='blue4')
    segments(0.5, 0.35, 0.5+0.2+rnorm(1,0,0.01), 0.4, col='blue4')
    #points(x, y, pch=20, col="black", cex=0.5)
    cyans <- c("cyan1", "cyan2", "cyan3", "cyan4", "darkcyan",
               "cyan4", "cyan3", "cyan2", "cyan1", "cyan")
    skyblues <- c("deepskyblue1", "deepskyblue2", "deepskyblue3", "deepskyblue4",
                  "dodgerblue4", "deepskyblue4", "deepskyblue3", "deepskyblue2",
                  "deepskyblue1", "deepskyblue")
    # random colors() for freak-out emergency mode
    # settle on color for ultimate calm, cycle through color "area" for some calm
    draw.circle(0.38, 0.6, 0.1, border="cornsilk1", col=sample(colors(), 1))
    draw.circle(1-0.38, 0.6, 0.1, border="cornsilk1", col=sample(colors(), 1))

    draw.circle(0.38, 0.5, 0.1,
                border="cadetblue3", col="cadetblue3")
    draw.circle(1-0.38, 0.5, 0.1,
                border="cadetblue3", col="cadetblue3")
  }
})