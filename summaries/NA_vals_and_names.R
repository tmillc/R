y <- rnorm(1000)   # vector containing 1000 draws from a standard normal distr
z <- rep(NA, 1000) # vector with 1000 NAs
my_data <- sample(c(y,z), 100)   # select 100 elems at random from these 2000 vals
my_na <- is.na(my_data)

# note my_data == NA  returns a vector of length length(my_data), filled with NA

# Since R represents TRUE as 1 and FALSE as 0, we can sum the TRUE and FALSE to get the total TRUEs
totalNAs <- sum(my_na)

my_data[!is.na(my_data) & my_data > 0]   # should return non-NA positive values in my_data

my_data[c(-2,-10)]    # gives us all elems except the 2nd and 10th
my_data[-c(2, 10)]    # equivalent

vect1 <- c(a=1, b=2, c=3)
vect2 <- c(1,2,3)
names(vect2) <- c("a", "b", "c")  # now vect1 and vect2 are the same
identical(vect1, vect2)
