make.power <- function(n) { # a function of n
  pow <- function(x) {
    x^n
  }
  pow  # calling a function of x
}

cube <- make.power(3)
square <- make.power(2)
cube(3)           # 27
square(3)         # 9
make.power(2)(3)  # 9

(function(n) (function(x) x^n))(2)(3) # 9

