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
