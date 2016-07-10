# Things to look at closer sometime

# do.call, environment
# library(microbenchmark)
# library(pwr)
# so many bookmarks
# pairs
# viewinfo
# invisible
# myedit
# multi-threading BLAS (basic linear algebra subprograms) libraries:
#  vecLib/Accelerate, ATLAS, ACML (for AMD), MKL (for Intel)
# parallel processesing via library(parallel)
# graphics: ggplot2, ggvis, lattice
# format
# subset
vignette("nse")      # non-standard evaluation
vignette("lazyeval") # NSE/etc

data(mtcars)

# which
mtcars[which(mtcars$mpg > 20), ]

# with
tapply(mtcars$mpg, mtcars$cyl, mean)  # equiv
with(mtcars, tapply(mpg, cyl, mean))  # equiv



objectmaker <- function(amount, symbol, value) {
  lhs <- value
  rhs <- paste(symbol, 1:amount, "<-", lhs, sep="")
  eval(parse(text=rhs))

  # These objects only exist in this scope so they're gone when the function ends
  ls()
  # eval(parse(text=paste(symbol, 1, sep="")))
}

# > objectmaker(3, "ok", 6:8)
# [1] "amount" "lhs"    "ok1"    "ok2"    "ok3"    "rhs"    "symbol" "value"