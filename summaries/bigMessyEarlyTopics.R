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


