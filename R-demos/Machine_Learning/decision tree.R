library(data.table)
library(C50)
library(rsample)
library(gmodels)
library(tidyverse)
library(gmodels)

setwd("C:\\Users\\1000257489\\Documents\\Angelina\\RLanguage\\test\\Decision Tree")

raw <- fread("Decision_Tree.csv", stringsAsFactors = TRUE)

data_split <- initial_split(raw, prop = 0.9)
train_set <- training(data_split)
test_set <- testing(data_split)

prop.table(table(train_set$default))
prop.table(table(test_set$default))

credit_model <- C5.0(train_set[,-21], train_set$default)
credit_model
summary(credit_model)

credit_pred <- predict(credit_model, test_set)

CrossTable(test_set$default, credit_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c("actual default", "predicted default"))

# Improve Model
#credit_boost10 <- C5.0(train_set[, -21], train_set$default, trails = 8)

error_cost <- matrix(c(0, 1, 4, 0), nrow = 2)
credit_cost <- C5.0(train_set[, -21], train_set$default, costs = error_cost)
credit_cost_pred <- predict(credit_cost, test_set)
CrossTable(test_set$default, credit_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c("actual default", "predicted default"))
## use rsample to split train & test set, and improved model, but no better performance shown

# use random dataset and reorder it to get train & test set
set.seed(12345)
credit_rand <- raw[order(runif(1000)), ]
# confirm they're same dataset but only different order
summary(raw$amount)
summary(credit_rand$amount)
head(raw$amount)
head(credit_rand$amount)

credit_train <- credit_rand[1:900,]
credit_test <- credit_rand[901:1000,]

prop.table(table(credit_train$default))
prop.table(table(credit_test$default))

credit_model1 <- C5.0(credit_train[-21], credit_train$default)
credit_pred1 <- predict(credit_model1, credit_test)
CrossTable(credit_test$default, credit_pred1,
           prop.t = FALSE, prop.chisq = FALSE, prop.r = TRUE,
           dnn = c("actual default", "predicted default"))

#Improve model
credit_boost <- C5.0(credit_train[-21], credit_train$default, trials = 10)
credit_pred2 <- predict(credit_model1, credit_test)
CrossTable(credit_test$default, credit_pred2,
           prop.t = FALSE, prop.chisq = FALSE, prop.r = TRUE,
           dnn = c("actual default", "predicted default"))
# no improvement

#use cost matrix
credit_cost1 <- C5.0(credit_train[, -21], credit_train$default, costs = error_cost)
credit_cost_pred1 <- predict(credit_cost1, credit_test)
CrossTable(credit_test$default, credit_pred2,
           prop.t = FALSE, prop.chisq = FALSE, prop.r = TRUE,
           dnn = c("actual default", "predicted default"))
# no improvement
######## need work on raw data, because raw data didn't processed ######