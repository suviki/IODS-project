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

