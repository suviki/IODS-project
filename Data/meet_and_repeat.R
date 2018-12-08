### 6. ANALYSIS OF LONGITUDINAL DATA ###

## DATA WRANGLING ##

## 1. Load and look at the datasets

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T)

names(BPRS)
names(RATS)

str(BPRS)
str(RATS)

summary(BPRS)
summary(RATS)

## 2. Convert variables

library(dplyr)
library(tidyr)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

## 3. Convert datasets to long form

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <-  RATS %>% gather(key = WDs, value = rats, -ID, -Group)
RATSL <-  RATSL %>% mutate(WD = as.integer(substr(WDs,3,3)))

## 4. Compare datasets

names(BPRS)
names(BPRSL)

names(RATS)
names(RATSL)

# The number of variables has decreased in both datasets due to converting to long form

dim(BPRS)
dim(BPRSL)

dim(RATS)
dim(RATSL)

# The number of obs has increased in both datasets due to converting to long form

str(BPRS)
str(BPRSL)

str(RATS)
str(RATSL)

# The data frames are differend compairing the two forms. In the long form there is more obs
#because the 

summary(BPRS$treatment)
summary(BPRSL$treatment)

summary(BPRS$subject)
summary(BPRSL$subject)


# The variable treatment has 40 obs (20+20) in a wide form dataset and in the long form 360 (180+180).
# The variable subject is the wide form data frame only 2 times in every subject but in the long form dataframe 18 times.

summary(RATS$ID)
summary(RATSL$ID)

summary(RATS$Group)
summary(RATSL$Group)

# In the long form datasets the dataframe is different than in wide form - it is bigger.
# This is because in the long form data response variable are recorded on several different occasions over same period of time.

write.csv(BPRSL, "/Users/suvi/Documents/GitHub/IODS-project/Data/bprsl.csv", row.names=FALSE)
write.csv(RATSL, "/Users/suvi/Documents/GitHub/IODS-project/Data/ratsl.csv", row.names=FALSE)



