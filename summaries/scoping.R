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
