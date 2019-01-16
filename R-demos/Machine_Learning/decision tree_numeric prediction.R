# regression tree/decision tree
#install.packages("rpart")
#install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

setwd("C:/Users/1000257489/Documents/Angelina/RLanguage/test/ML/regression tree and model tree")
wine <- read.csv("winequality-white.csv")
str(wine)

# study wine quality distribution
hist(wine$quality)

wine_train <- wine[1:3673, ]
wine_test <- wine[3674:4898, ]

m_rpart <- rpart(quality ~., data = wine_train)
m_rpart
rpart.plot(m_rpart, digit = 4) # plot model

p_rpart <- predict(m_rpart, wine_test)

# evaluate model performance
summary(p_rpart)
summary(wine_test$quality)
cor(p_rpart, wine_test$quality) #correlation is 0.49, not very strong
# Mean absolute error
MAE <- function(actual, predicted){
  mean(abs(actual - predicted))
}
MAE(wine_test$quality, p_rpart) # means prediction - actual value is about 0.58, seems good

mean(wine_train$quality)
MAE(5.885, wine_test$quality) # it means even we use mean quality of train as predictions,
# we'll have only 0.585 error, seems close to our model prediction

# improve model performance_try other models
#try SVM
library(kernlab)
predict_classifier <- ksvm(quality ~ ., data = wine_train, kernel = "rbfdot")
wine_prediction <- predict(predict_classifier, wine_test)
summary(wine_prediction)
summary(wine_test$quality)
cor(wine_prediction, wine_test$quality)
MAE(wine_prediction, wine_test$quality) # error value is 0.525, better than dicision tree model
# 0.525 is better than model tree(0.546), which I didn't use because 'RWeka' package
# is based on JAVA, it means I need install JAVA in my PC

# Model comparision
cor(p_rpart, wine_test$quality) # cor is 0.49
cor(wine_prediction, wine_test$quality) # cor is 0.59
MAE(5.885, wine_test$quality) # error is 0.585
MAE(p_rpart, wine_test$quality) # error is 0.579, close to error using mean(train dataset)
MAE(wine_prediction, wine_test$quality) # error is 0.525, better than 2 above

# result: SVM fits better than dicision tree for this example

