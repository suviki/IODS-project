## EXERCISE FOR WEEK 4 ##

# 2.Read the datasets in 

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# 3. Explore the datasets

str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# 4. Rename variables

colnames(gii)[colnames(gii) == "Gender.Inequality.Index..GII."] <- "GII"
colnames(gii)[colnames(gii) == "Maternal.Mortality.Ratio"] <- "MMRatio"
colnames(gii)[colnames(gii) == "Adolescent.Birth.Rate"] <- "ABirthR"
colnames(gii)[colnames(gii) == "Percent.Representation.in.Parliament"] <- "RepPar"
colnames(gii)[colnames(gii) == "Population.with.Secondary.Education..Female."] <- "Edu2F"
colnames(gii)[colnames(gii) == "Population.with.Secondary.Education..Male."] <- "Edu2M"
colnames(gii)[colnames(gii) == "Labour.Force.Participation.Rate..Female."] <- "LabF"
colnames(gii)[colnames(gii) == "Labour.Force.Participation.Rate..Male."] <- "LabM"

colnames(hd)[colnames(hd) == "Human.Development.Index..HDI."] <- "HDI"
colnames(hd)[colnames(hd) == "Life.Expectancy.at.Birth"] <- "LifeExp"
colnames(hd)[colnames(hd) == "Expected.Years.of.Education"] <- "EduExp"
colnames(hd)[colnames(hd) == "Mean.Years.of.Education"] <- "EduMean"
colnames(hd)[colnames(hd) == "Gross.National.Income..GNI..per.Capita"] <- "GNI"
colnames(hd)[colnames(hd) == "GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNIHDI"

# 5. Create two new variables

attach(gii)
gii$EduRatio <- (Edu2F/Edu2M)
gii$Labratio <- (LabF/LabM)

# 6. Join two datasets together

human <- merge(gii, hd, by="Country")

# There is 195 obs and 19 variables in the human data.

write.csv(human, "/Users/suvi/Documents/GitHub/IODS-project/Data/human.csv")


#########################################

## EXERCISE FOR WEEK 5 ##

str(human)
dim(human)
summary(human)

# 1. Transform data to numeric

library(stringr)
str(human$GNI)
human$GNI <- str_replace(human$GNI, pattern=",", replace="") %>% as.numeric
str(human$GNI)

# 2. Exclude unneeded variables

keep <- c("Country", "EduRatio", "Labratio", "EduExp", "LifeExp", "GNI", "MMRatio", "ABirthR", "RepPar")
human <- select(human, one_of(keep))

# 3. Remove missing values

complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human2 <- filter(human, complete.cases(human))

# 4. Remove observations which relate to regions

str(human2$Country)
#I'll remove observations Arab states (row 4), East Asia and the Pacific (row 44), Europe and Central Asia (row 50), 
# Latin America and the Caribbean (row 81), South Asia (row 132), Sub-Saharan Africa (row 135), World (159)

human3 <- (human2[-c(4, 44, 50, 81, 132, 135, 159),])


# 5. Define row names and remove the country name column

rownames(human3) <- human3$Country
keep2 <- c("EduRatio", "Labratio", "EduExp", "LifeExp", "GNI", "MMRatio", "ABirthR", "RepPar")
human3 <- select(human3, one_of(keep2))

# Data now includes 155 obs and 8 variables.

write.csv(human3, "/Users/suvi/Documents/GitHub/IODS-project/Data/human3.csv", row.names = TRUE)




