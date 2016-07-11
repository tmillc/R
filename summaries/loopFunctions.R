# https://nsaunders.wordpress.com/2010/08/20/a-brief-introduction-to-apply-in-r/
#  Good explanations


lapply
# function (X, FUN, ...)
# {
#   FUN <- match.fun(FUN)
#   if (!is.vector(X) || is.object(X))   # Tries to coerce to a list if it can
#     X <- as.list(X)
#   .Internal(lapply(X, FUN))   # Actual looping done in C
# }
# <bytecode: 0x20f3bc0>
#   <environment: namespace:base>

# Remember, lists can have any kind of object as its elements
x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)
# $a
# [1] 3
#
# $b
# [1] -0.0474927

# What goes in will try to be coerced as a list
# It will return a list

x <- 1:4
lapply(x, runif)  # runif(n) returns n random uniform
# [[1]]
# [1] 0.7108169   # generating 1 random uniforms
#
# [[2]]
# [1] 0.710346 0.474639   # 2 random uniforms
#
# [[3]]
# [1] 0.9688282 0.5138259 0.9005831
#
# [[4]]
# [1] 0.59789127 0.96521355 0.25745983 0.08854886

# Passing arguments to the runif function
lapply(x, runif, min = 0, max = 10)

x <- list(a = matrix(1:4, 2,2), b= matrix(1:6, 3,2))
# suppose we want the first col of each
# there's no function to extract the first col of a matrix
lapply(x, function(y) y[,1])  # anonymous function
  # $a
  # [1] 1 2
  #
  # $b
  # [1] 1 2 3

# sapply tries to simplify.
#  if result is a list where length(every elem)=1, it returns a vector
#  if result is a list where every elem is a vector of same length (>1), returns a matrix
#  if it can't figure it out, returns a list
x <- 1:4
lapply(x, function(y) c(y,y))
  # [[1]]
  # [1] 1 1
  #
  # [[2]]
  # [1] 2 2
  #
  # [[3]]
  # [1] 3 3
  #
  # [[4]]
  # [1] 4 4
sapply(x, function(y) c(y,y) )
  #      [,1] [,2] [,3] [,4]
  # [1,]    1    2    3    4
  # [2,]    1    2    3    4
sapply(x, function(y) {y-1} )
  # [1] 0 1 2 3
x <- list(a = 1:4, b = rnorm(5), c = rnorm(20,1), d = rnorm(6, mean = 10, sd = 2))
mean(x)
  # [1] NA
  # Warning message:
  #   In mean.default(x) : argument is not numeric or logical: returning NA
sapply(x, mean)
  # a         b         c         d
  # 2.5000000 0.5347705 1.0392819 9.7265847

# apply evalutes a function over the margins of an array
# most often used to apply a function to the rows/cols of a matrix
# can be used with general arrays, eg taking avg of an array of matrices
# not really faster than a loop, but works in one line

# Recall an array is a vector with dimensions attached to it.
str(apply)
  # function (X, MARGIN, FUN, ...)
# X is an array
# MARGIN is an int vector indicating which margins (think dimensions) we wish to preserve
# FUN is the function we're applying
# ... is for args to FUN

x <- array(1:24, c(4,3,2))  # has rows, cols, and depth.
  # , , 1
  #
  #      [,1] [,2] [,3]
  # [1,]    1    5    9
  # [2,]    2    6   10
  # [3,]    3    7   11
  # [4,]    4    8   12
  #
  # , , 2
  #
  #      [,1] [,2] [,3]
  # [1,]   13   17   21
  # [2,]   14   18   22
  # [3,]   15   19   23
  # [4,]   16   20   24
apply(x, 2, sum)   # applying sum to the columns
# 1+2+3+4+13+14+15+16 = 68, etc
  # [1]  68 100 132
apply(x,1,sum)  # applying sum to the rows, collapsing cols and depth
# 1+5+9+13+17+21 = 66
  # [1] 66 72 78 84
apply(x, 3, sum)  # applying sum to the depth, collapsing rows and cols
# 1+2+3+4+5+6+7+8+9+10+11+12 = 78
  # [1]  78 222
apply(x,c(1,2), sum)  # Preserving both rows and cols, collapsing depth
  #      [,1] [,2] [,3]  # This is summing each element "depthwise"
  # [1,]   14   22   30
  # [2,]   16   24   32
  # [3,]   18   26   34
  # [4,]   20   28   36


# For some matrix (2-array) operations, there are built in functions that are faster
x <- matrix(20:79, 6,10)
rowSums(x) == apply(x, 1, sum)
colSums(x) == apply(x, 2, sum)
rowMeans(x) == apply(x, 1, mean)
colMeans(x) == apply(x, 2, mean)

x <- matrix(rnorm(10000, mean = 10, sd = 2), 100, 100)
n <- 1:1e6
system.time(for (i in n) rowSums(x)) / length(n)     # 8e-5
system.time(for (i in n) apply(x,1,sum)) / length(n) # 8e-4

x <- matrix(rnorm(200), 20,10)  # 20x10 matrix
apply(x, 1, quantile, probs=c(0.25, 0.75))
#  returns a 2x20 matrix, where first row is 25%, second row is 75%
# and a column in our returned matrix for each row of our original

# The element-wise average of a bunch of 2x2 matrices
x <- array(rnorm(2*2*10), c(2,2,10))
x[, , 1]   # the first one
  #            [,1]       [,2]
  # [1,] -1.5607515 -0.3151304
  # [2,] -0.4433462  0.5002558
apply(x, c(1,2), mean)
rowMeans(x, dims = 2)  # can use this for bigger dim "matrices" by specifying dim


################ mapply

# Vectorizing with mapply
noise <- function(n, mean, sd) {
  rnorm(n, mean, sd)
}
noise(5,1,2) # [1]  2.4587963  2.1955811 -0.6924394  1.8729593  2.5720255
noise(1:5, 1:5, 2)  # [1] 2.190096 3.237450 4.949465 1.878323 4.236571



replicate(10, rnorm(10))  # repeats a function



############### tapply
# apply a function over a subset of a vector
tapply
# function (X, INDEX, FUN = NULL, ..., simplify = TRUE)

x <- c(rnorm(10), runif(10), rnorm(10, 1))  # length = 30
f <- gl(3, 10)  # generate 3 factor levels, 10 of each
tapply(x, f, mean)
  #           1           2           3
  # 0.001218476 0.507694203 1.002542181
tapply(x, f, mean, simplify = FALSE)  # returns a list
  # $`1`
  # [1] 0.001218476
  #
  # $`2`
  # [1] 0.5076942
  #
  # $`3`
  # [1] 1.00254
tapply(x, f, range)   # now 2 results for each subset: min and max
  # $`1`
  # [1] -1.384522  1.521096
  #
  # $`2`
  # [1] 0.1322962 0.9710479
  #
  # $`3`
  # [1] 0.06550416 2.37197059
# Example using UCI's flag data
table(flags$landmass)  # 6 landmasses
  #  1  2  3  4  5  6
  # 31 17 35 52 39 20
table(flags$animate)   # how many flags have animate (trees, human hand, etc) figures
  #   0   1
  # 155  39
tapply(flags$animate, flags$landmass, mean)  # proportion of animate flags by landmass
  #         1         2         3         4         5         6
  # 0.4193548 0.1764706 0.1142857 0.1346154 0.1538462 0.3000000
# landmass 1 is north america, contains 41% of those 39 flags with animate figures
#  Summary of population values (in millions) for countries with/without red on flag
tapply(flags$population, flags$red, summary)
  # $`0`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max.     # No red in flag
  # 0.00    0.00    3.00   27.63    9.00  684.00
  #
  # $`1`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max.     # Red in flag
  # 0.0     0.0     4.0    22.1    15.0  1008.0

#  A summary of population values for each of six landmasses (indexing by $landmass)
tapply(flags$population, flags$landmass, summary)


####### Split
# takes a vector and a factor and splits the vector into the number of groups identified in factor
# once the group is split apart, you can use lapply or sapply

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
split(x, f)

# Common to see lapply(split(..))
lapply(split(x,f), mean)  # this could be done with tapply

# But split can split more complicated objects
library(datasets)
head(airquality, n=3)
  # Ozone Solar.R Wind Temp Month Day
  # 1    41     190  7.4   67     5   1
  # 2    36     118  8.0   72     5   2
  # 3    12     149 12.6   74     5   3
# We want to split the dataset into monthly pieces and then get the mean by apply or colMeans
s <- split(airquality, airquality$Month)
# $Month is not a factor variable but we can use it as one
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
# ^- takes colMeans of these 3 vars for each monthly data frame
# returns a list of elems each of length 3, so we can use sapply
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))


# Splitting on more than one level
f1 <- gl(2,5)
f2 <- gl(5,2)
x <- rnorm(10)
length(interaction(f1,f2))  # returns another factor
str(split(x, list(f1,f2)), drop = TRUE)




##### vapply
# where sapply tries to guess the correct format, vapply allows you to explicitly set it

A <- list(c(1,1,1,2,3), c(3,4,5), c(2))
vapply(A, unique, numeric(1))  # try to simplify to 1-numeric
  # Error in vapply(A, unique, numeric(1)) : values must be length 1,
  # but FUN(X[[1]]) result is length 3
