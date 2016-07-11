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

