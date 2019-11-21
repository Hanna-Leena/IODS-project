#Hanna-Leena Kukkola 20.11.2019 Week 4 and 5 data wrangling
#https://github.com/Hanna-Leena/IODS-project

#First reading the data "Human development" and "Gender inequality"

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Exploring the datasets as asked, by looking at the structres and dimensions of the data
str(hd)
dim(hd)
#The "hd" has 195 observations of 8 variables
str(gii)
dim(gii)
#The "gii" has 195 observations of 10 variables

#Creating summaries of the variables
summary(hd)
#The "hd" has 8 variables: HDI.rank, Country, Human.Development.Index..HDI., Life.Expectancy.at.Birth, Ecpected.Years.of.Education, Mean.Years.of.Education, Gross.National.Income..GNI..per.Capita, GNI.per.Capita.Rank.Minus.HDI.Rank

summary(gii)
#The "gii" has 10 variables: GII.Rank, Country, Gender.Inequality.Index..GII., Maternal.Mortality.Ratio, Adolescent.Birth.Rate, Percent.Representation.in.Parliament, Population.with.Secondary.Education..Female, Population.with.Secondary.Education..Male, Labour.Force.Participation.Rate..Female, Labour.Force.Participation.Rate..Male.

#Look at the meta files and rename the variables with shorter descriptive names
library(stringr)
names(hd)
names(gii)
library(tidyverse)
colnames(hd)
colnames(gii)


hd <- hd %>% as_data_frame %>% rename(HDI.Rank = HDI.Rank, HDI = Human.Development.Index..HDI., Edu.Exp = Expected.Years.of.Education, GNI = Gross.National.Income..GNI..per.Capita, Country = Country, Life.Exp = Life.Expectancy.at.Birth, Edu.Mean = Mean.Years.of.Education, GNI.Minus.Rank = GNI.per.Capita.Rank.Minus.HDI.Rank)
gii <- gii %>% as_data_frame %>% rename(GII.Rank = GII.Rank, Country = Country, GII = Gender.Inequality.Index..GII., Mat.Mor = Maternal.Mortality.Ratio, Ado.Birth = Adolescent.Birth.Rate, Parli.F = Percent.Representation.in.Parliament, Edu2.F = Population.with.Secondary.Education..Female., Edu2.M = Population.with.Secondary.Education..Male., Labo.F = Labour.Force.Participation.Rate..Female., Labo.M = Labour.Force.Participation.Rate..Male.)

#Mutate the “Gender inequality” data and create two new variables
colnames(hd)
colnames(gii)

library(tidyverse)

gii <- gii %>% mutate(edu2F_edu2M = Edu2.F/Edu2.M)
gii <- gii %>% mutate(labF_labM = Labo.F/Labo.M)

str(gii)

# Join together the two datasets by using the variable Country as the identifier

hd_gii <- inner_join(hd, gii, by = "Country")

str(hd_gii)
dim(hd_gii)
#Now we see that we have the correct amount of observations and variables, 195 observations and 19 variables.

#Write csv
library(readr)
write.csv(hd_gii, file = "human.csv", eol = "\r", na = "NA", row.names = FALSE)

#Week 5 data wrangling begins

# Load the human data and explore the structures and dimensions of it.
human <- read.csv("human.csv", header = TRUE)
dim(human)
str(human)
#This data "human" has 195 observations of 19 variables. It deals with key aspects of human development such as education, life expectancy at birth, mean years of education. There are different countries involved.

# Mutate the data: transform the Gross National Income (GNI) variable to numeric
library(stringr)
str(human$GNI)
str_replace(human$GNI, pattern = ",", replace = "") %>% as.numeric

# Exclude unneeded variables
library(dplyr)
keep <- c("Country", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F", "edu2F_edu2M", "labF_labM")
human <- dplyr::select(human, one_of(keep))

#Remove all rows with missing values
complete.cases(human)
human_ <- filter(human, complete.cases(human))
dim(human_)

#Remove the observations which relate to regions instead of countries
head(human_)
tail(human_, 10)
#The last 7 observations are related to regions, so let's choose all the others except the 7 last
last <- nrow(human_) - 7
human2 <- human_[1:last,]

human2
tail(human2)

#Define the row names of the data by the country names and remove the country name column from the data.
library(tibble)
rownames(human2) <- human2$Country
human2 <- as.data.frame(human2)
library(dplyr)
human3 <- dplyr::select(human2, -Country)
human3

#The data should have now 155 observations and 8 variables
dim(human3)

#Write csv
library(readr)
write.csv(human, file = "create_Human.csv", eol = "\r", na = "NA", row.names = FALSE)
