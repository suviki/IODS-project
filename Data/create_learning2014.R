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

### ANALYSIS ###

 # Looking at learning 2014 dataset (it is already in after data wrangling and that is why I don't read it from the web):
read.table(learning2014)
learning <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)
dim(learning2014)
str (learning2014)
# Learning2014 dataset shows information about student, their attitudes and how they perform in tests.
# There are information about 166 students in the data and the variables are gender, age, attitude, deep, stra, surf and points.
# Gender and age are basic information about the student. Attitude shows students' attitude towards statistics (many questions in the backround).
# Variables deep, stra and surf are collected together from different questions and the data shows the average of the Likert-scale (1-5).
# Variable points shows the students' exam points.

## graphical overview of the data ##

# Graphical overwiev helps to understand the data. If we want to see the summaries of the variables, histogram is one way to see that.

hist_age <- hist(learning2014$Age)
hist_attitude <- hist(learning2014$Attitude)

# In learning2014 data most of the students are 20-15 years old. 
# The most common attitude points are 30-35.

# Plots are also a good way to explore the data. For example we can see the points and the attitude in the same plot:
install.packages("ggplot2")
library(ggplot2)
plot1 <- ggplot(learning2014, aes(x = Attitude, y = Points))
plot2 <- plot1 + geom_point()
plot2
plot3 <- plot2 + geom_smooth(method = "lm")
plot3

# -> It seems that if the students attitude is higher the points are little bit higher too. 

# good way to see data by all the variables, is to use pairs:
pairs(learning2014[-1])

install.packages("GGally")
library(GGally)
p <- ggpairs(learning2014, mapping = aes(), lower = list(combo = wrap("facethist", bins = 20)))
p



## Choosing three explanatory variables -> regression analysis between attitude and points ##

# simple regression analysis: attitude and points
keep_columns <- c("Age", "Attitude", "deep", "Points")
variables <- select(learning2014, one_of(keep_columns))

qplot(Attitude, Points, data = variables) + geom_smooth(method = "lm")

linear_model <- lm(Points ~ Attitude, data = variables)
summary(linear_model)

## There is statistical relationship between points and attitude because P-value is smaller than 0,05 (4.119e-09). 
## This means that if the attitude of the student is high, the student will more likely to have good points in test.

# multiple regression analysis
linear_model2 <- lm(Points ~ Attitude + Age + deep, data = variables)
summary(linear_model2)
# There is statistical relationship between points and attitude but not with points and age/deep because of the p-values.
# This means that the age for example does not affect so much to test points, it is the attitude what matters the most.

## Plots#

plot(linear_model)
plot(linar_model2)

# You can see the residuals in the plots 





