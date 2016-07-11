# else condition is optional in if
if(3>2) {
	y <- "yep"
} else {
	y <- "uh oh"
}

# Alternatively
y <- if(3 > 2) {
	"yep"
} else {
	"uh oh"
}

for (i in 1:10) {
	print(i)
}

# Different "for" syntax, the following four have the same behavior
x <- c("a", "b", "c", "d")

for (i in 1:4) {
	print(x[i])
}

for (i in seq_along(x)) {
	print(x[i])
}

for (letter in x) {
	print(letter)
}

for (i in 1:4) print(x[i])


## Look at seq_along
## Look at seq_len

x<-matrix(1:6, 2, 3)

for (i in seq_len(nrow(x))) {
	for (j in seq_len(ncol(x))) {
		print(x[i,j])
	}
}

# while
count <- 0
while(count<10) {
	print(count)
	count <- count + 1
}

## Look at rbinom
z<-5
while(z>=3 && z<=10) {
	print(z)
	coin <- rbinom(1,1,0.5)

	if(coin == 1) {    # random walk
		z <- z+1
	} else {
		z <- z-1
	}
}


# Repeat
x0 <- 1
tol <- 1e-8

# Note! Not guarenteed to halt. Better to set hard limit on number of iterations, and report con-/di-vergence.
repeat {
	x1 <- 1 # computeSomeEstimate()

	if (abs(x1-x0) < tol) {
		break
	} else {
		x0 <- x1
	}
}

# Next, return
for(i in 1:100) {
	if(i <= 20) {
		next 				# skip the first 20 iterations
	}
	# Do something with the next 80 iterations
}

