# Question on /r/rstats
# Hello, I'm looking to do some basic simulation in R to examine the nature of
# p-values. My goal is to see whether large sample sizes trend towards small p-values.
# My thought is to generate random vectors of 1,000,000 data points, regress them on
# each other, and then plot the distribution of p-values and look for skew.

x1 = runif(1000000, 0, 1000)
x2 = runif(1000000, 0, 1000)
model1 = lm(x2~x1)
#code to pull out p-value
lmp <- function (modelobject) {
  if (class(modelobject) != "lm") stop("Not an object of class 'lm' ")
  f <- summary(modelobject)$fstatistic
  p <- pf(f[1],f[2],f[3],lower.tail=F)
  attributes(p) <- NULL
  return(p)
}
lmp(model1)
#0.3874139


### Response
# Someone mentioned above that you need to have correlated variables.
# To do that, you just need something like this:
x1 = rnorm(1000000, 0, 1000)
x2 = .0001*x1 + rnorm(1000000, 0, 1000)
# Where ".0001" can be anything you want -- it's essentially your unstandardized
# regression coefficient. I picked a small effect size, but you could play around
# with it. (I'm also recommending rnorm instead of runif, as that will give you
# normally distributed variables.)
# Beyond that, I'd recommend using a loop (or lapply) to run a set of simulations
# with various sample sizes. Try something like this:

#code to pull out p-value
lmp <- function (modelobject) {
    if (class(modelobject) != "lm") stop("Not an object of class 'lm' ")
    f <- summary(modelobject)$fstatistic
    p <- pf(f[1],f[2],f[3],lower.tail=F)
    attributes(p) <- NULL
    return(p)
}

n.sims <- 1000
sizes <- c(10, 100, 1000, 10000, 100000)
result <- numeric(n.sims * length(sizes))  # store your results here
for (s in 1:length(sizes)) {
    for (i in 1:n.sims) {
        x1 = runif(sizes[s], 0, 1000)
        x2 = runif(sizes[s], 0, 1000)
        model1 = lm(x2~x1)
        result[(s-1)*n.sims + i] <- lmp(model1)
    }
}
# That will run 1000 simulations for each of the sizes listed in sizes, and then
# store them all in the result variable. That can probably optimized more, but it
# should at least get you started.


### More discussion
# You've simulated many replicates of two random variables (x1 & x2) from the same
# distribution. Then regressed one on the other. Because of the way you set things up,
# x1 and x2 are independent and therefore uncorrelated. Consequently, the F-test fails
# to reject the null. Your simulation confirmed theory and at the same time established
# that R is able to generate independently distributed uniform variables.
# You will not be able to gain any insight regarding "the nature of p-values" (if there
# even is such a thing) by using one test.
# If you want to examine when the method (the test) performs poorly, perhaps you'd consider
# decreasing the sample1 size, changing the distributions2 for x1 and x2, greatly increase
# the number of replications and then look for significant results.
#
# Need to simulate correlated random variables
# use mvrnorm() from MASS package