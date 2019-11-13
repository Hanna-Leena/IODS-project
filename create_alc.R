#Hanna-Leena Kukkola 07.11.2019 New excercise logistic regression
#https://github.com/Hanna-Leena/IODS-project


url<- "https://archive.ics.uci.edu/ml/machine-learning-databases/00320/"

#read the math class questionaire data into memory
math <- read.csv("student-mat.csv", sep = ";" , header = TRUE)

#read the por questionaire data into memory

por <- read.csv("student-por.csv", sep = ";" , header = TRUE)

str(math)
dim(math)
colnames(math)
#has 395 objects and 33 variables

str(por)
dim(por)
colnames(por)
#has 649 objects and 33 variables

#combining the two datasets

library(dplyr)

#use common columns as identifiers

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet")

math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

str(math_por)
#Has 382 objects and 53 variables

dim(math_por)
#The same result as str

#Combine the duplicated answers in joined data
colnames(math_por)
#create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))
#columns that were not used for jouning the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
notjoined_columns

#for every column name not used for joining
for (column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)){
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
  
}

glimpse(alc)

library(dplyr)
library(ggplot2)

#define a new column alc_use by combining weekday and weekend use

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#define a new column high_use by using alc_use

alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

#Write csv
library(readr)
write.csv(alc, file = "alc2014.csv", eol = "\r", na = "NA", row.names = FALSE)
