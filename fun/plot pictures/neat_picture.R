require(grDevices) # for colours
x <- y <- seq(-4*pi, 4*pi, len = 27)
r <- sqrt(outer(x^2, y^2, "+"))
image(z = z <- cos(r^2)*exp(-r/6), col  = gray((0:32)/32),
      axes = FALSE)
image(z, axes = FALSE, main = "",
      xlab = "")#expression(cos(r^2) * e^{-r/6}))
contour(z, add = TRUE, drawlabels = FALSE)