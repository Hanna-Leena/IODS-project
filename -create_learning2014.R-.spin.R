#Hanna-Leena Kukkola 06.11.2019 New excercise linear regression
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
#Looking at the dimensions of the data
dim (lrn14)
# 183 rows, 60 columns
str (lrn14)
# 183 obs and 60 variables

#create an analysis dataset

# Access the dplyr library

library (dplyr)
lrn14 <- c("gender", "age", "attitude", "deep", "stra", "surf", "points")

analysis_dataset <- c("gender","age","attitude","deep","stra","surf","points")


getwd()

