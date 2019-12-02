#Hanna-Leena Kukkola 22.11.2019 Week 6 Exercise
#https://github.com/Hanna-Leena/IODS-project

#First load the data sets (BPRS and RATS)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt")

#Write the wrangled data sets to files in your IODS-project data-folder
library(readr)
write.csv(BPRS, file = "BPRS.csv", eol = "\r", na = "NA", row.names = FALSE)
write.csv(RATS, file = "RATS.csv", eol = "\r", na = "NA", row.names = FALSE)

#Take a look at the data sets: check their variable names, view the data contents and structures, and create some brief summaries of the variables

colnames(BPRS)
names(BPRS)
#With these two commands you can look at the variable names. Names are from V1 to V11.

head(BPRS)
#With this command you can see the variables V1 to V11 and 8 treatment weeks.
dim(BPRS)
#The BPRS dataset has 41 observations ana 11 variables.
str(BPRS)
#The structure of the BPRS-dataset. You have 11 factor variables.
summary(BPRS)
#This way you can see the summary of the BPRS dataset.

colnames(RATS)
names(RATS)
#With these commands you can look at the variable names of the RATS-datset.

head(RATS)
#You can see with this command that the RATS-dataset has ID:s, Group-numbers, and variables from WD1 etc.

dim(RATS)
#With this command we can look at that the RATS-dataset has 16 observations and 13 variables.

str(RATS)
#With this command you can look at the structure of this dataset.

summary(RATS)
#This way you can see the summary of the RATS-dataset.

#Next step: Convert the categorical variables of both data sets to factors.
library(dplyr)
library(tidyr)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

#Next step: Convert the data sets to long form. 
#Add a week variable to BPRS and a Time variable to RATS.

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))

#Now, take a serious look at the new data sets and compare them with their wide form versions.
#Check the variable names, view the data contents and structures, and create some brief summaries of the variables.

dim(BPRSL)
#Now the BPRSL dataset has 360 observations and 4 variables.
colnames(BPRSL)
#The variables are named: "treatment", "subject", "weeks", and "bprs".
str(BPRSL)
summary(BPRSL)
glimpse(BPRSL)

dim(RATSL)
#Now the RATSL data has 176 observations and 5 variables.

colnames(RATSL)
# The variables are named: "ID", "Group", "WD", "Weight", "Time".

str(RATSL)
summary(RATSL)
glimpse(RATSL)