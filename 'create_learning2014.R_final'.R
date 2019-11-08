#Hanna-Leena Kukkola 06.11.2019 New excercise linear regression
https://github.com/Hanna-Leena/IODS-project

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
#Looking at the dimensions of the data
dim (lrn14)
# 183 rows, 60 columns
str (lrn14)
# 183 observation and 60 variables for example age, gender, attitude.
#Other quick ways to browse through the data
View(lrn14)
colnames(lrn14)
head(lrn14)

#create an analysis dataset, but first combine the deep, stra, surf questions

# Access the dplyr library

library (dplyr)
install.packages('tidyverse')

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
#Then selecting the deep, stra, surf columns, calculating the mean value of the points and making a new column
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)
#Selecting the columns
keep_columns <- c("gender","Age","Attitude","deep","stra", "surf","Points")
lrn14 <- select(lrn14, one_of(keep_columns))
str(lrn14)
#Filtering to exclude the points 0
learning2014 <- filter(lrn14, Points>0)
#Checking that I got it correct (asekd 166 observations, 7 variables)
dim(learning2014)
str(learning2014)
colnames(learning2014)
glimpse(lrn14)
View(lrn14)

install.packages('readr')
library(readr)
#Write csv and testing that it will work
write.csv(learning2014, file="learning2014.csv", eol = "\r", na = "NA", row.names = FALSE)
testing <- read.csv("learning2014.csv", header = TRUE, sep= ",")
str(testing)
head(testing)
View(testing)
# Workind directory
getwd()


