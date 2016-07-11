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
