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
