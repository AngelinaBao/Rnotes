# Data Preprocessing
#library(data.table)

setwd("C:\\Users\\1000257489\\Documents\\Angelina\\RLanguage\\test\\Datascience\\Data_Preprocessing")
dataset <- read.csv("Data.csv")

# dealing with missing data
attach(dataset)
dataset$Age <- ifelse(is.na(Age), 
                      ave(Age, FUN = function(x) mean(x, na.rm = TRUE)), 
                      Age)
dataset$Salary <- ifelse(is.na(Salary), 
                         ave(Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                         Salary)

# defining categorical data as factor
dataset$Country <- factor(Country,
                          levels = c("France", "Spain", "Germany"),
                          labels = c(1, 2, 3))
dataset$Purchased <- factor(Purchased,
                            levels = c("Yes", "No"),
                            labels = c(0, 1))

#Splitting the dataset into train & test set
#install.packages("rsample")
library(rsample)
data_split <- initial_split(dataset, prop = 0.75)
train_set <- training(data_split)
test_set <- testing(data_split)

#another method to split train & test
library(caTools)
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio = 0.8)
train_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

#Feature scaling
train_set[, 2:3]<- scale(train_set[, 2:3])
test_set[, 2:3] <- scale(test_set[, 2:3])
