# Run matrixShapes(n)
#  ex: matrixShapes(12) will return a list where each element is a matrix of 12 elements,
#      and the list exhausts all possibilties of matrix shapes for 12 elements.
#      Excluding the n*1 cases.

matrixShapes <- function(n) {
  factors <- findFactors(n)
  m_set <- vector("list", length(factors))  # what we're returning

  for (i in seq_along(factors)) {  # 1 2 3 4 ..
    currentFactor <- factors[i]     # 2 3 5 ...
    grouping <- gl(currentFactor, n/currentFactor)  # set up the grouping
    splitting <- split(1:n, grouping)   # split according to grouping
    m_set[[i]] <- do.call(rbind, splitting)   # rowbind to a matrix
  }

  return(m_set)
}

findFactors <- function(x) {
  bottom <- 2   # start with 2, unless 2 doesn't divide
  while ( (x %% bottom) != 0) {
    bottom <- bottom + 1
  }

  if (bottom == x) {   # this should be handled better
    print("Oops, it's prime")
    break
  }

  top <- x / bottom
  factors <- vector("numeric")
  for (i in bottom:top) {
    factors <- if ((x %% i) != 0) { # if it's not a factor
      factors   # leave it alone
    } else {   # otherwise
      c(factors, i)  # append it, because it's a factor
    }
  }
  return(factors)
}
