### Messy in two ways:
### Single var (class) in multiple columns
### a col (test) whose entries should each be a col

students3 %>%
  #       name    test class1 class2 class3 class4 class5
  #   1  Sally midterm      A   <NA>      B   <NA>   <NA>
  #   2  Sally   final      C   <NA>      C   <NA>   <NA>
  #   3   Jeff midterm   <NA>      D   <NA>      A   <NA>
  #   4   Jeff   final   <NA>      E   <NA>      C   <NA>

  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  #     name    test  class grade
  # 1  Sally midterm class1     A
  # 2  Sally   final class1     C
  # 9  Brian midterm class1     B
  # 10 Brian   final class1     B
  # 13  Jeff midterm class2     D

  spread(test, grade) %>%
  #     name  class final midterm
  # 1  Brian class1     B       B
  # 2  Brian class5     C       A
  # 3   Jeff class2     E       D
  # 4   Jeff class4     C       A
  # 5  Karen class3     C       C

  mutate(class = extract_numeric(class)) %>%
  #     name class final midterm
  # 1  Brian     1     B       B
  # 2  Brian     5     C       A
  # 3   Jeff     2     E       D
  # 4   Jeff     4     C       A
  # 5  Karen     3     C       C
    print

### Multiple observations in single table

students4 %>% # Notice id, name repeated
  #     id  name sex class midterm final
  # 1  168 Brian   F     1       B     B
  # 2  168 Brian   F     5       A     C
  # 3  588 Sally   M     1       A     C
  # 4  588 Sally   M     3       B     C
  # 5  710  Jeff   M     2       D     E

  # student info, with id
  select(id, name, sex) %>%
  #     id  name sex
  # 1  168 Brian   F
  # 2  168 Brian   F
  # 3  588 Sally   M
  # 4  588 Sally   M
  # 5  710  Jeff   M
  # 6  710  Jeff   M

  unique() %>%      # take out duplicates
  #    id  name sex
  # 1 168 Brian   F
  # 3 588 Sally   M
  # 5 710  Jeff   M

  # gradebook, with id
  select(id, class, midterm, final) %>%
  #     id class midterm final
  # 1  168     1       B     B
  # 2  168     5       A     C
  # 3  588     1       A     C
  # 4  588     3       B     C

### Single observation in multiple tables
passed
  #    name class final
  # 1 Brian     1     B
  # 2 Roger     2     A
  # 3 Roger     5     A
  # 4 Karen     4     A

failed
  #    name class final
  # 1 Brian     5     C
  # 2 Sally     1     C
  # 3 Sally     3     C
  # 4  Jeff     2     E
  # 5  Jeff     4     C
  # 6 Karen     3     C

passed <- mutate(passed, status = "passed")
failed <- mutate(failed, status = "failed")
bind_rows(passed, failed)
  #     name class final status
  #    (chr) (int) (chr)  (chr)
  # 1  Brian     1     B passed
  # 2  Roger     2     A passed
  # 3  Roger     5     A passed
  # 4  Karen     4     A passed
  # 5  Brian     5     C failed
  # 6  Sally     1     C failed
  # 7  Sally     3     C failed
  # 8   Jeff     2     E failed
  # 9   Jeff     4     C failed
  # 10 Karen     3     C failed