# Suvi Kivi 12.11.2018. This chapter is about logistic regression. Data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance.

# 3. Read the files in

mat <- read.csv2 ("/Users/suvi/Documents/GitHub/IODS-project/Data/student-mat.csv", header=TRUE, sep=';')
por <- read.csv2 ("/Users/suvi/Documents/GitHub/IODS-project/Data/student-por.csv", header=TRUE, sep=';')

# 4. Join the datasets

library(dplyr)

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob","reason", "nursery", "internet")

mat_por <- inner_join(mat, por, by = join_by)

str(mat_por)
dim(mat_por)

# 5. The if-else structure

alc <- select(mat_por, one_of(join_by))

notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

for(column_name in notjoined_columns) {
  two_columns <- select(mat_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]

  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- first_column
  }
}

# 6. New columns

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

___
ifelse (alc$high_use > 2) "FALSE"
alc$high_use <- function(use) {
  ifelse (use > 2, "TRUE", ifelse (use < 2, "FALSE"))
}
alc$high_use <- (alc_use(a)) {
  if (any(a>2))
alc <- mutate(alc, high_use = (Dalc + Walc) / 2)
alc$high_use <- if (any < 2) then "FALSE"
if (alc$high_use > 2) print ("TRUE") else print ("FALSE")
____

# 7. Glimpse & CSV

glimpse(alc)

write.csv(alc, "/Users/suvi/Documents/GitHub/IODS-project/Data/alc.csv")





