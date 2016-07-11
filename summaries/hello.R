# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

hello <- function() {
  print("Hello, world!")
}

# numbers are real (double) by default
typeof(2)
typeof(2L)


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


