# Shows color palettes, taken from a swirl() course
# reconstructed by dput() so hopefully it works as intended

showMe <- function (cv)
{
  myarg <- deparse(substitute(cv))
  z <- outer(1:20, 1:20, "+")
  obj <- list(x = 1:20, y = 1:20, z = z)
  image(obj, col = cv, main = myarg)
}