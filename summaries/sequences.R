# seq, seq_along, rep

seq1 <- seq(5,10, length=30)  # we want 30 numbers between 5 and 10
seq2 <- seq(5, 10, by = 1.5)  # we want numbers between 5 and 10 in steps of 1.5

1:length(seq1)          # same as 1:30
seq(along_with = seq1)  # same as 1:30
seq_along(seq1)				  # same as 1:30

rep(0, times = 40)           # 0 0 0 ... forty of them
rep(c(0,1,2), times = 10)    # 0 1 2 0 1 2 ... repeats 10 times
rep(c(0,1,2), each = 10)     # 0 0 0 ... 1 1 1 ... 2 2 2 ... each 10 times
