# Suvi Kivi 11.11.2018. This file includes a dataset.

### DATA WRANGLING ###

## Part 2 ##

#taking dataset in
lrn2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#dimension of the data
dim (lrn2014)
# there is 183 obs and 60 variables in the dataset

#structure of the data
str(lrn2014)
# there is 59 integer variables and only one factor variable (gender)

## Part 3 ##

#analysis dataset

# Access the dplyr library
install.packages("dplyr")
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn2014, one_of(deep_questions))
lrn2014$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn2014, one_of(surface_questions))
lrn2014$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn2014, one_of(strategic_questions))
lrn2014$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn2014, one_of(keep_columns))

# select rows where points is greater than zero
learning2014 <- filter(learning2014, Points > 0)

## Part 4 ##

# working directory
setwd("/Users/suvi/Documents/GitHub/IODS-project")

#write csv
?write.csv
write.csv(learning2014, "/Users/suvi/Documents/GitHub/IODS-project/Data/learning2014.csv")

#read csv
?read.csv

#structure of the csv
str("/Users/suvi/Documents/GitHub/IODS-project/Data/learning2014.csv")
head("/Users/suvi/Documents/GitHub/IODS-project/Data/learning2014.csv")







