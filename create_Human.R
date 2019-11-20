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


hd <- hd %>% as_data_frame %>% rename(Rank = HDI.Rank, Hu_Dev_Ind = Human.Development.Index..HDI., Exp_Ya_Edu = Expected.Years.of.Education, Gross_Na_Inc = Gross.National.Income..GNI..per.Capita, Country = Country, Lif_Exp_Birth = Life.Expectancy.at.Birth, Mean_Ya_Edu = Mean.Years.of.Education, GNI = GNI.per.Capita.Rank.Minus.HDI.Rank)
gii <- gii %>% as_data_frame %>% rename(GII = GII.Rank, Country = Country, Gen_In_Ind = Gender.Inequality.Index..GII., Ma_Mo_Ra = Maternal.Mortality.Ratio, Ado_Bi_Ra = Adolescent.Birth.Rate, Per_Rep_Par = Percent.Representation.in.Parliament, Pop_Sec_Edu_Fem = Population.with.Secondary.Education..Female., Pop_Sec_Edu_Ma = Population.with.Secondary.Education..Male., Lab_Fo_Par_Ra_Fem = Labour.Force.Participation.Rate..Female., Lab_Fo_Par_Ra_Ma = Labour.Force.Participation.Rate..Male.)

#Mutate the “Gender inequality” data and create two new variables
colnames(hd)
colnames(gii)

library(tidyverse)

gii <- gii %>% mutate(edu2F_edu2M = Pop_Sec_Edu_Fem/Pop_Sec_Edu_Ma)
gii <- gii %>% mutate(labF_labM = Lab_Fo_Par_Ra_Fem/Lab_Fo_Par_Ra_Ma)

str(gii)

# Join together the two datasets by using the variable Country as the identifier

hd_gii <- inner_join(hd, gii, by = "Country")

str(hd_gii)
dim(hd_gii)
#Now we see that we have the correct amount of observations and variables, 195 observations and 19 variables.

#Write csv
library(readr)
write.csv(hd_gii, file = "human.csv", eol = "\r", na = "NA", row.names = FALSE)





