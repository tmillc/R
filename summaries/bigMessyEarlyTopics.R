quick and dirty histogram: table()

# Dates are represented by the Date class
# Dates stored internally as days since 1/1/1970
# Times are represented by the POSIXct or the POSIXlt class
# Times stored internally as seconds since 1/1/1970

x <- as.Date("1970-01-02")
unclass(x)    # returns 1, for 1 day after 1970-01-01
weekdays(x)   # "Friday"
months(x)     # "January"
quarters(x)   # "Q1"
# POSIXct is just a big integer under the hood. Useful for storing times in something like a data frame
# POSIXlt is a list underneath, and it stores additional info like day of week, day of year, month, day of month

y <- Sys.time()
unclass(y)      # 1445011224, POSIXct
p <- as.POSIXlt(y)
unclass(p)      # $yday 288, $zone "CDT", ...
p$month         # 9

# strptime
datestring <- c("January 12, 2012 10:40", "November 8, 2020 8:15")
convertedDate <- strptime(datestring, "%B %d, %Y %H:%M")
class(convertedDate)   # "POSIXlt" "POSIXlt"

# y-x   # Warning: Incompatible methods ("-.POSIXxt", "-.Date") for "-"
x <- as.POSIXlt(x)
y-x    # Time difference of 16724.18 days

# Keeps track of tricky things like timezones and leap years
as.Date("2012-03-01") - as.Date("2012-02-28")   # this was a leap year, Time difference of 2 days
as.POSIXct("2014-03-18 06:00:00") - as.POSIXct("2014-03-18 06:00:00", tz = "GMT")  # Time diff 5 hours
as.POSIXct("2014-03-18 06:00:00", tz = "GMT") - as.POSIXct("2014-03-18 06:00:00")  # Time diff -5 hours


vect1 <- c(a=1, b=2, c=3)
vect2 <- c(1,2,3)
names(vect2) <- c("a", "b", "c")  # now vect1 and vect2 are the same
identical(vect1, vect2)


##### hello.R

x1<-c(TRUE, FALSE)  # c() is concatenate
x2<-6:10

x3<-c(x1,x2)
print(x3)
typeof(x3)
x4<-c(x1,"hi")
print(x4)
typeof(x4)
is.vector(x4, mode = "logical")
# 0 is true, non-zero is false
print(as.logical(0:4))

# Empty vector
print(vector("numeric", length = 10))

## check help("class") and help("mode") and help("typeof")

l1<- list(3.2, "cat", TRUE, 3-2i)
print(l1)

# Matrix
m1<-matrix(nrow = 3, ncol = 2)
# dim(m1) returns a vector, attributes(m1) shows we have a $dim attribute
dim(m1)
attributes(m1)

# Matrix gets filled column wise
print(matrix(1:6, nrow=2, ncol=3))

# Can assign a dimension to a sequence
x5<-1:10
dim(x5) <- c(2,5)
print(x5)

x<-1:3
y<-10:12
print(cbind(x,y))
print(rbind(x,y))

# Factors represent (ordered or unordered) categorical data
# They are treated specially by modeling functions like lm(), glm()
f1<-factor(c("yes", "no", "yes", "yes", "yes", "no", "yes"))
print(f1)

# calling table() gives us a frequency count for each level
table(f1)

# Underlying is an integer representation
unclass(f1)

# "no" is our baseline level, because by default it is assigned alphabetically
f1<-factor(c("yes", "no", "yes", "yes", "yes", "no", "yes"),
           levels = c("yes", "no"))
unclass(f1)

# NaN is for undefined math operations, NA is for everything else
# a NaN is also a NA, but the converse is not true
# NA values have a class (integer NA, character NA,...)

# testing is.na() and is.nan()
x<-c(1, 43, 5, NA, 3, 2, NaN, 1, 1)
is.na(x)
is.nan(x)

# Data Frames are used to store tabular data
# A special type of list, where each element of list has same length. Each element can be thought of as a column
# and the length of each element is the number of rows
# Where matrices need every element to be of the same class, like lists, Data Frames can store different classes
# Can be created by calling read.table() or read.csv()
# have special attributes, including row.names
# Can be converted to a matrix by calling data.matrix() -- will coerce to same class

## How to use row.names ?
frame1 <- data.frame(apples = 1:4, maples = c(T,F,F,T))
print(frame1)

# All R objects can have names
x<-1:4
names(x) <- c("a", "b", "c", "d")

# Using our list from before, we add names to a list
names(l1) <- c("number", "string", "boolean", "complex")
print(l1)

# We can also add the names this way
l2 <- list(a=2, b=4, c=8, d=16)
print(l2)

# Matrix names
m2 <- matrix(1:4, nrow=2, ncol=2)
dimnames(m2) <- list(c("r1", "r2"), c("c1", "c2"))
print(m2)

# sapply is a wrapper to lapply, they apply a function over a list or vector
x <- 1:4
doubleMe <- function(n) { n*2 }
y <- sapply(x, doubleMe)
print(y)


# elem-wise vs mat mult/division
m3 <- matrix(1:4, 2,2)
m4 <- matrix(rep(10,4), 2,2)
print(m3 * m4)
print(m3 %*% m4)

# can add vectors of multiple-lengths
x<-rep(1,8)
y<-2
x+y   # 3 3 3 3 3 3 3 3
y<-c(2,3)
x+y   # 3 4 3 4 3 4 3 4


### Vectorize Ex
f <- function(x=1:3, y) c(x,y)
f(y=8)    # 1 2 3 8
f(y="hi") # "1"  "2"  "3"  "hi"

vf <- Vectorize(f, SIMPLIFY = FALSE)
vf(1:3, 1:3)
# [[1]]
# [1] 1 1
#
# [[2]]
# [1] 2 2
#
# [[3]]
# [1] 3 3

vf(1:3, 1:6)
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
# [1] 1 4
#
# [[5]]
# [1] 2 5
#
# [[6]]
# [1] 3 6

vf <- Vectorize(f, SIMPLIFY = TRUE)
vf(1:3, 1:3)
#      [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    1    2    3
vf(1:3, 1:6)
#      [,1] [,2] [,3] [,4] [,5] [,6]
# [1,]    1    2    3    1    2    3
# [2,]    1    2    3    4    5    6
vf(1:3, "hi")
#     [,1] [,2] [,3]
# [1,] "1"  "2"  "3"
# [2,] "hi" "hi" "hi"

##### SEQUENCES
# seq, seq_along, rep

seq1 <- seq(5,10, length=30)  # we want 30 numbers between 5 and 10
seq2 <- seq(5, 10, by = 1.5)  # we want numbers between 5 and 10 in steps of 1.5

1:length(seq1)          # same as 1:30
seq(along_with = seq1)  # same as 1:30
seq_along(seq1)				  # same as 1:30

rep(0, times = 40)           # 0 0 0 ... forty of them
rep(c(0,1,2), times = 10)    # 0 1 2 0 1 2 ... repeats 10 times
rep(c(0,1,2), each = 10)     # 0 0 0 ... 1 1 1 ... 2 2 2 ... each 10 times

#### SUBSETTING
# [ ]  returns an object of the same class as original. Can be used to select more than one element
# [[]] doesn't necessarily return objects of same class as original. Used to select elems of a list or data frame.
# 			can only be used to extract a single elem
# $    used to extract elems of a list or data frame by name. Semantics similar to [[]]

x <- c("a", "b", "b", "d", "c", "a", "c")
print(x[1:4])

# logical index
print(x[x > "a"])
u <- x > "a"
print(x[u])

y <- list(sequ = 1:4, ok = 0.4, wonderful = c(1,5,4), a=1, b=2)
class(y[1])
class(y[[1]])
y$ok
y["ok"]
y[["ok"]]
## LOOK MORE AT THE SPECIFICS OF [] and [[]]

y[c(1,3)]

# [[ ]] can be used for computed indices, whereas $ can't
name <- "sequ"
y[[name]]   # y$name errors

# [[ ]] can extract nested elems
y[[c(1,2)]]   # equivalent to y[[1]][[2]]

# matrix indexing
mat <- matrix(1:6, 2,3)  # a 2x3 with 1 through 6, remember it fills cols from UL
mat[1,2]   # gives 3
mat[1,]    # first row, 1 3 5
mat[,1]    # first col, 1 2

# Recall [] returns an object of the same class however:
# By default, retrieving a single elem of a matrix returns a vector of length 1, rather than a 1x1 matrix
# And similarly retrieving a row/col returns a vector
# This can be changed by setting drop = FALSE
mat[1,2, drop = FALSE]   # 1x1 matrix
mat[1, , drop = FALSE]   # 1x3 matrix


# Partial Matching
# allowed with $ and [[ ]], only really helpful on the commandline
y$wo  											# matches the name wonderful
y[["wo"]]  									# NULL
y[["wo", exact = FALSE]]		# matches the name wnoderful

# Helpful example of removing NA values
x<-c(1, 3, NA, 4, 4, 3, NA)
badx <- is.na(x)
x[!badx]

y<-c("a", "b", NA, "c", "d", "e", NA)
good <- complete.cases(x,y)    # returns a logical vector indicating which cases have no missing values
# Note if ie x was all NA, then good would be all FALSE
x[good]
y[good]

data <- read.csv("someData.csv", colClasses = c("numeric", "numeric", "logical"))
print(data)
good <- complete.cases(data)
print(data[good, ])


####### LOOP FUNCTIONS
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



####### SCOPING
# lm() is already defined in the stats package
lm <- function(x) { x*x }

# R needs to bind a value to the symbol "lm"
# It starts with the Global environment, and then searches the namespaces of each of the packages in the search list
search()  # returns the search list
# The search list is ordered, beginning with .GlobalEnv  and always ending with the base package.

# when User loads a library, it gets put in position 2, shifting every other package down.

# NOTE: R has separate namespaces for functions and objects, so it's possible to have both an object and func'n "c"

# Scoping Rules determine how a value is associated with a free variable in a function
# There are 2 types of variables at play in a function: those passed as arguments, and "free variables"

# Lexical (or static) scoping. An alternative to dynamic scoping.
# Related to the scoping rules is how R uses the search list to bind a value to a symbol
# lexical scoping is nice for statistical computation (why?)

f <- function(x,y) {
  x^2 + y / z
}
# Here, z is a "free variable"
# The scoping rules of a language determine how values are assigned to free variables
# Free variables are not formal arguments, and they are not local variables (assigned inside the function body)

# Lexical scoping in R means:
######################################################################################################
# The values of free variables are searched for in the environment in which the function was defined #
######################################################################################################

# An environment is a collection of (symbol, value) pairs. ie x is a symbol, 3.14 might be its value.
# Every environment has a parent, environments can have multiple "children"

# The only environment without a parent is the empty environment

# A function + an environment = a "closure", or "function closure"

# Searching for the value of a free variable:
# If the value of a symbol isn't found in environment where func'n was defined,
#   then the search continues in the parent environment

# Search continues down the search list until we hit the "top level" environment;
#   this is usually the global environment, or the namespace of a package

# If still no value for symbol is found, search continues until we hit the "empty environment", then error


# Expected behavior: A func'n is defined in the global environment, so value of free variable is found in the
#    user's workspace
# But we can define functions inside of other functions. So the environment in which it was defined is the body
#    of that outer function.

# This typically arises with "constructor" functions: functions which construct other functions.

make.power <- function(n) {
  pow <- function(x) {
    x^n
  }
  pow
}
# make.power returns "the function pow"
# inside definition of pow, n is a free variable. R tries to find a value to match the symbol n, in the environment
#    where pow is defined, in make.power
square <- make.power(2)
cube <- make.power(3)

ls(environment(cube))         # "n"  "pow"
ls(environment(make.power))   # "lm" "f" "cube" "square" ...  (workspace)

get("n", environment(square)) # usage: get(x, pos = -1, envir = as.environment(pos), mode = "any", inherits=TRUE)
# returns 2

#### Lexical vs Dynamic Scoping
y <- 10

f <- function(x) {
  y <- 2
  y^2 + g(x)
}

g <- function(x) {
  x*y
}

f(3) # = ?
# Lexical: val of y in funcn g is a free variable
# it is looked up in the environment in which the function was defined, in this case global, so y is 10
#  f(3) returns 4 + 3*10 = 34

# Dynamic: val of y is looked up in the environment from which the function was called (the calling environment)
#   in R, the calling environment is called the "parent frame"
#  f(3) returns 4 + 3*2 = 10


# When a function is defined in the global environment, and subsequently called from the global environment,
#  then the defining and calling environments are the same, appearing like dynamic scoping

# Consequences:
# all objects must be stored in memory -- challenging with increasingly large datasets/objects
# all functions carry a pointer to their defining environments, wherever that is


# Try reasoning about this:
f <- function(x) {
  g <- function(y) {
    y-z
  }
  z <- 5
  x + g(x)
}

###### LOGIC AND PASTING
((111 >= 111) | !(TRUE)) & ((4+1) == 5)   # returns true

my_char <- c("My", "name", "is")
singleCharVector <- paste(my_char, collapse= " ")  # "My name is"
my_name <- c(my_char, "Chris")
fullSentence <- paste(my_name, collapse = " ") # "My name is Chris"

paste(1:3, c("X", "Y", "Z"), sep="")    # "1X" "2Y" "3Z"

# LETTERS is a predefined R var containing a character vector of all 26 letters
# since LETTERS is longer, the 1:4 numeric vector gets repeated
paste(LETTERS, 1:4, sep = "-")   # "A-1" "B-2" "C-3" "D-4" "E-1" "F-2" ... Note of course, 1:4 is coerced

#### LOOKING AT DATA (USES PLANTS.R)
plants <- dget("plants.R")
class(plants)
ncol(plants)
nrow(plants)
object.size(plants)  # how much memory occupying
names(plants)  # char vector of column names
summary(plants)  # gives a summary for each variable
#  min/Q1/med/mean/Q3/max for numeric, totals for categorical vars (factor variables)

# one variable from that output:
# Active_Growth_Period
# Spring and Summer   : 447
# Spring              : 144
# Spring, Summer, Fall:  95
# Summer              :  92
# Summer and Fall     :  24
# (Other)             :  30
# NA's                :4334

table(plants$Active_Growth_Period)
# Fall, Winter and Spring                  Spring
#                      15                     144
#         Spring and Fall       Spring and Summer
#                      10                     447
#    Spring, Summer, Fall                  Summer
#                      95                      92
#         Summer and Fall              Year Round
#                      24                       5

str(plants)  # combines many of the summarizing features


###### RANDOM NUMBERS
rnorm() # generate random normal variables with given mean/sd
dnorm() # eval normal prob density (with given mean/sd) at a point or vector of points
pnorm() # eval cumulative distribution function for a normal distribution
rpois() # generate random Poisson variables with a given rate

# every distribution usually has functions:
# r - random num generation
# d - density
# p - cumulative
# q - quantile,   "inverse cumulative"

# gamma, poisson, ...

# dnorm, pnorm, qnorm have log option
# pnomr, qnorm have lower.tail = T/F for evaluating the lower tail (true by default ,
#   otherwise evaluates the upper tail)

x <- rnorm(20,10,2)
summary(x)
sd(x)
r

# setting the seed ensures reproducibility
set.seed(1)
rpois(10, 1)
rpois(10, 5)
rpois(2,2)

# cumulative
ppois(2,2)  # Pr(x <= 2)
# [1] 0.6766764
ppois(4,2)  # Pr(x <= 4),  prob that poisson distr w/ rate 2 is less than 4
ppois(6,2)  # Pr(x <= 6)

# 100 groups of random numbers, each with 5 poisson values, mean 10
my_pois <- replicate(100, rpois(5,10)) # a matrix, each col is 5 generated pois values
cm <- colMeans(my_pois)
hist(cm)  # col means are almost normally distributed! Central Limit Theorem


#  Generating random numbers from a linear model
# y = beta_0 + beta_1*x + epsilon
#   where epsilon ~ Normal(0, 2^2). Assume x ~ Normal(0, 1^2), beta_0= 0.5, beta_1 = 2

# We have a single predictor x, random noise
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2*x + e
summary(y)
plot(x,y)

#  What if x is binary?   (binomial distribution)
#  Now our x's are either 0 or 1, but we still see a linear trend from x=0 to x=1.
set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2*x + e
summary(y)
plot(x,y)

#  Generalized linear model
#  Y ~ Poisson(mu)
#  log(mu) = beta_0 + beta_1*x
# Assume beta_0 = 0.5, beta_1 = 0.3
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3*x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x,y)


###  Sample
# draws a random sample from an object
# can get any distribution you want by specifying a vector of objects and sample from it

# sample from 1:10
sample(1:10, 4)  # 4 from 1:10 without replacement
sample(letters, 5)
sample(1:10)   # without specifying how many, gives a permutation (defaults to length)
sample(1:10, replace = TRUE)
sample(c(0,1), 100, prob = c(0.3, 0.7)) # unfair coin
rbinom(n = 1, size = 100, prob = 0.7) # same as above, but returns number of success
rbinom(n = 100, size = 1, prob = 0.7) # returns a vector of successes and failures

### standard distributions are in R: normal, poisson, exp, gamma, binom, chi-squared...

#### PROFILING
# system.time()
#  if error occurs, gives time until error occured
#  returns object of class proc_time
#  "user time": time charged to the CPU(s) for this expression
#  "elapsed time":  "wall-clock" time

# elapsed > user: CPU spends time waiting around, ex: fetching from the web
# elapsed < user: if machine has multiple cores/processors

hilbert <- function(n) {
  i <- 1:n
  1 / outer(i-1, i, "+")
}
x <- hilbert(1000)
system.time(svd(x))   # single-value decomp, svd() takes advantage of multiple cores
# user  system elapsed
# 3.464   1.340   1.717

system.time({  # wrapping longer expressions with {}
  # stuff
  # stuff
})

# The problem with system.time() is it requires you to know where the bottleneck is

Rprof() # queries the call stack at regular (default 0.02s) intervals
# shows how long you're in each call
# output generally not too readable
summaryRprof()   # summarizes the Rprof output

### Do not use system.time() and Rprof() together!!!

# Two ways of normalizing the data from summaryRprof
# by.total - divides time spent in each function by total time
#   kind of, how much many times each function appears in the callstack
#    ie, 100% of time is spent in the top-level function
#    but if that top-level is just calling helper functions, that's not useful
# by.self - does the same but first subtracts out time spent in functions above in the stack
#   if all the work is done by helpers, the top-level will be small

Rprof(tmp <- tempfile())
svd(x)
Rprof()
summaryRprof(tmp)
unlink(tmp)

############## RW 1
# Reading data
#
# read.table, read.csv 	-- for tabular data  (inverse write.table)
# readLines 						-- used for reading text fiels, returns characters (inverse writeLines)
# source 								-- reads in R code (inverse of dump)
# dget 									-- reads in R code (inverse of dput)
# load									-- loads in workspaces  (inverse save)
# unserialize						-- reading single R object binaries (inverse serialize)

data <- read.table("theData.txt",
                   header = TRUE,
                   row.names = c("a","b", "c", "d", "e", "f", "g"))

# For very large datasets, to make R run faster, could specify: nrows (allocating mem), type of var in each col
# read.csv is identical but the default separator is comma

# Make a rough calculation of the memory required to store the dataset. If dataset is larger than RAM, then ????
# If no comments, then set comment character to ""

# Using colClasses can speed up read.table a lot !!!

# Quick and dirty way of specifying the column types:
initial <- read.table("theData.txt", nrows = 7)
# sapply is a user-friendly wrapper of lapply, see also vapply and replicate
classes <- sapply(initial, class)
tabAll <- read.table("theData.txt", header = TRUE, colClasses = classes)

# Use unix tool 'wc' to find number of lines
# If all columns are numeric, can specify colClasses = "numeric"


# Note on memory usage calculation
# Consider 1,500,000 rows and 120 cols
# 1,500,000 * 120 * 8 bytes/numeric
# = 1440000000 bytes
# = 1440000000 / 2^20 MB = 1,373.29 MB
# = 1.34 GB
# And as a rule of thumb, want 2x this amount for overhead in reading and holding the data in memory

############ RW 2
# dump and dput result in a textual format
# Unlike writing a table, "dput" and "dump" preserve the metadata
# textual formats good for version control

y<-data.frame(a=1, b="a")
dput(y)  # can output to console
dput(y, file = "y.R")

y2 <- dget("y.R")

# dump works with multiple objects
x1 <- 1:4
x2 <- "hi"
dump(c("x1", "x2"), file = "twoObjects.R")

# Can form connections via file, gzfile, bzfile  (done behind the scenes by table.read for instance)
# url, opens connection to url

#> str(file)
# function (description = "", open = "", blocking = TRUE, encoding = getOption("encoding"), raw = FALSE)
# description is name of file
# open is 'r'ead only, 'w'rite only, 'a'ppending, and 'rb', 'wb', 'ab' for binaries

# This is the same as data <- read.table("theData.txt")
con1 <- file("theData.txt", "r")
data <- read.table(con1)
close(con1)

con2 <- gzfile("text.txt.gz")
firstTenLines <- readLines(con, 10)
close(con2)

con3 <- url("http://www.google.com/", "r")
goog <- readLines(con3)
close(con3)

# Example of downloading and unzipping a file from within R
dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")



############# DEBUGGING
# traceback() - run this after error'ing on a function, prints the callstack
#   does nothing if run after no error, does nothing if another function is ran after error
# debug - flags a function for debug mode
# browser - suspends execution of a function, putting the function in debug mode
# trace - insert debugging code into a function in specific places
# recover - modify error behavior so you can browse call stack

#  Three main indications of problems: message, warning, error.
#  Only error will actually halt execution

options()$error
# (function ()
# {
#   .rs.recordTraceback(TRUE)
# })()

options(error = recover)
options()$error
# (function ()
# {
#   if (.isMethodsDispatchOn()) {
#     tState <- tracingState(FALSE)
#     on.exit(tracingState(tState))
#   }
#   calls <- sys.calls()
#  .
#  .
#  .

read.csv("nope")
#  now it puts us in a menu

################ EXAMPLES OF MESSY DATA
### Messy in two ways:
### Single var (class) in multiple columns
### a col (test) whose entries should each be a col

students3 %>%
  #       name    test class1 class2 class3 class4 class5
  #   1  Sally midterm      A   <NA>      B   <NA>   <NA>
  #   2  Sally   final      C   <NA>      C   <NA>   <NA>
  #   3   Jeff midterm   <NA>      D   <NA>      A   <NA>
  #   4   Jeff   final   <NA>      E   <NA>      C   <NA>

  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  #     name    test  class grade
  # 1  Sally midterm class1     A
  # 2  Sally   final class1     C
  # 9  Brian midterm class1     B
  # 10 Brian   final class1     B
  # 13  Jeff midterm class2     D

  spread(test, grade) %>%
  #     name  class final midterm
  # 1  Brian class1     B       B
  # 2  Brian class5     C       A
  # 3   Jeff class2     E       D
  # 4   Jeff class4     C       A
  # 5  Karen class3     C       C

  mutate(class = extract_numeric(class)) %>%
  #     name class final midterm
  # 1  Brian     1     B       B
  # 2  Brian     5     C       A
  # 3   Jeff     2     E       D
  # 4   Jeff     4     C       A
  # 5  Karen     3     C       C
  print

### Multiple observations in single table

students4 %>% # Notice id, name repeated
  #     id  name sex class midterm final
  # 1  168 Brian   F     1       B     B
  # 2  168 Brian   F     5       A     C
  # 3  588 Sally   M     1       A     C
  # 4  588 Sally   M     3       B     C
  # 5  710  Jeff   M     2       D     E

  # student info, with id
  select(id, name, sex) %>%
  #     id  name sex
  # 1  168 Brian   F
  # 2  168 Brian   F
  # 3  588 Sally   M
  # 4  588 Sally   M
  # 5  710  Jeff   M
  # 6  710  Jeff   M

  unique() %>%      # take out duplicates
  #    id  name sex
  # 1 168 Brian   F
  # 3 588 Sally   M
  # 5 710  Jeff   M

  # gradebook, with id
  select(id, class, midterm, final) %>%
  #     id class midterm final
  # 1  168     1       B     B
  # 2  168     5       A     C
  # 3  588     1       A     C
  # 4  588     3       B     C

  ### Single observation in multiple tables
  passed
#    name class final
# 1 Brian     1     B
# 2 Roger     2     A
# 3 Roger     5     A
# 4 Karen     4     A

failed
#    name class final
# 1 Brian     5     C
# 2 Sally     1     C
# 3 Sally     3     C
# 4  Jeff     2     E
# 5  Jeff     4     C
# 6 Karen     3     C

passed <- mutate(passed, status = "passed")
failed <- mutate(failed, status = "failed")
bind_rows(passed, failed)
#     name class final status
#    (chr) (int) (chr)  (chr)
# 1  Brian     1     B passed
# 2  Roger     2     A passed
# 3  Roger     5     A passed
# 4  Karen     4     A passed
# 5  Brian     5     C failed
# 6  Sally     1     C failed
# 7  Sally     3     C failed
# 8   Jeff     2     E failed
# 9   Jeff     4     C failed
# 10 Karen     3     C failed

############ BASE GRAPHICS
# not included: lattice, ggplot2, ggvis

data(cars)  # from 1920s, speed(mph) and stopping distance (ft)
plot(cars)  # will guess that you want names(cars) for plot labels
plot(x = cars$speed, y = cars$dist) # will set labels as cars$speed, cars$dist
plot(x = cars$speed, y = cars$dist, xlab = "Speed")
plot(x = cars$speed, y = cars$dist, xlab = "Speed", ylab = "Stopping Distance")
plot(cars, main = "Plot Title", sub = "Subtitle")
plot(cars, xlim=c(10,15), col = 2, pch = 2) # red triangles, x between 10 and 15

data(mtcars)
# formula interface  y ~ x, x on x-axis, y on y-axis
boxplot(formula = mpg ~ cyl, data = mtcars)

# histograms are nice for single variables
hist(mtcars$mpg)


