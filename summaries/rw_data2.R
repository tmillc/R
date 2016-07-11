# dump and dput result in a textual format
# Unlike writing a table, "dput" and "dump" preserve the metadata
# textual formats good for version control

y<-data.frame(a=1, b="a")
dput(y)  # can output to console
dput(y, file = "y.R")

y2 <- dget("y.R")

# dump works with multiple objects
x1 <- 1:4
x2 <- "hi"
dump(c("x1", "x2"), file = "twoObjects.R")

# Can form connections via file, gzfile, bzfile  (done behind the scenes by table.read for instance)
# url, opens connection to url

#> str(file)
# function (description = "", open = "", blocking = TRUE, encoding = getOption("encoding"), raw = FALSE)
# description is name of file
# open is 'r'ead only, 'w'rite only, 'a'ppending, and 'rb', 'wb', 'ab' for binaries

# This is the same as data <- read.table("theData.txt")
con1 <- file("theData.txt", "r")
data <- read.table(con1)
close(con1)

con2 <- gzfile("text.txt.gz")
firstTenLines <- readLines(con, 10)
close(con2)

con3 <- url("http://www.google.com/", "r")
goog <- readLines(con3)
close(con3)

# Example of downloading and unzipping a file from within R
dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")
