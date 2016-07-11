# week1, distilled into things that even remotely surprised me
as.numeric(1+1i)  # drops imaginary part
as.numeric(c("a", "b", "c"))  # can't coerce char -> num, so char -> NA
file.info()  # returns a data frame, so ie file.info("file")$size
unlink()  # deletes files and dirs

# http://stackoverflow.com/questions/18475202/paste-collapse-in-r
#   for 'sep' and 'collapse' in paste()

# filesystem independent path reference, nest dirs by recursive = TRUE
file.path("folder1", "folder2")
dir.create(file.path("testdir2", "tesdtdir3"), recursive = TRUE)
unlink("testdir2", recursive = TRUE)

seq(along.with = 1:5) == seq_along(1:5)
seq(as.Date("2000/1/1"), by = "month", length.out=12) # can seq Dates
seq(4,11, length=20) # can specify length of seq

rep(c(1,2), times = 10) # 1 2 1 2 ...
rep(c(1,2), each = 10) # 111..222...

# Make missing data, or generally a mix of data
y <- rnorm(1000); z <- rep(NA,1000)
messy_data <- sample(c(y,z), 100)
my_na <- is.na(messy_data) # finds where they are

# Use jitter to make a noisy sinewave
x <- seq(-6, 6, by=0.2)
plot(x, jitter(sin(x), factor = 1, amount = 0.2))

# matrices are vectors with a dimension attribute
v1 <- 1:6; dim(v1) <- c(2,3); class(v1)

x <- data.frame(id = 1:4, truth = c(T,T,F,T))
# can turn to a matrix, coercing values to all be the same type
data.matrix(x)

my_matrix <- matrix(1:20, 4,5)
patients <- c("Sean", "Bill", "Claude", "Kelly")
cbind(patients, my_matrix)       # coerces everything to char
data.frame(patients, my_matrix)  # patients is char, matrix is matrix

as.logical(-2:2)    # everything non-zero is True, T T F T T
as.numeric(TRUE)    # returns 1
15:11 # can sequence backwards

# Factors are ordered or unordered. Yes, no, maybe is unordered but
# child, parent, grandparent would probably be ordered.
charVec <- sample(c("yes","no","maybe"), replace = TRUE, 10, prob=c(0.3,0.3,0.3))
fac <- factor(charVec)  # "maybe" is the baseline, because alphabetical order
fac <- relevel(fac, ref = "yes")  # "yes" is baseline, followed by alphabetical
unclass(); str()  # give good info

# A NaN (inf-inf or 0/0) is a type of NA

B <- matrix(sample(0:100, 16), ncol=4)
# rownames, colnames do not assign to the matrix on their own
# also we are using do.NULL=FALSE to enumerate along the size with our prefix
rnames <- rownames(B, do.NULL=FALSE, prefix="wow")
cnames <- colnames(B, do.NULL=FALSE, prefix="var")
dimnames(B) <- list(rnames, cnames); print(B)


# Reading data
read.table() # read.csv calls this
dget(); dput()    # R objects
source(); dump()  # R source code
load(); save()    # R workspaces
readLines(); writeLines() # text file, character
unserialize(); serialize()  # binary files

# Assigning colClasses can speed up reading of big datasets
#
# Just look at the first 100 to set classes
initial <- read.table("dataset.txt", nrows = 100)
# Set class on the initial 100
classes <- sapply(initial, class)
# explicitly set colClasses on entire dataset
tabAll <- read.table("dataset.txt", colClasses = classes)

#  Memory needed to load a dataset
# numRow * numCol * (bytes per type, ie 8 bytes for numeric)
# Need about 2x this to load into R

