((111 >= 111) | !(TRUE)) & ((4+1) == 5)   # returns true

my_char <- c("My", "name", "is")
singleCharVector <- paste(my_char, collapse= " ")  # "My name is"
my_name <- c(my_char, "Chris")
fullSentence <- paste(my_name, collapse = " ") # "My name is Chris"

paste(1:3, c("X", "Y", "Z"), sep="")    # "1X" "2Y" "3Z"

# LETTERS is a predefined R var containing a character vector of all 26 letters
# since LETTERS is longer, the 1:4 numeric vector gets repeated
paste(LETTERS, 1:4, sep = "-")   # "A-1" "B-2" "C-3" "D-4" "E-1" "F-2" ... Note of course, 1:4 is coerced
