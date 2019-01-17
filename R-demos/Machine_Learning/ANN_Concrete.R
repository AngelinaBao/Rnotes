#install.packages("neuralnet")
library(neuralnet)


setwd("C:/Users/1000257489/Documents/Angelina/RLanguage/test/ML/ANN")
list.files()
concrete <- read.csv("Concrete_Data.csv")
str(concrete)
hist(concrete$strength) # close to normal distribution

# values differs much each other, need scale
normalize <- function(x){
  return((x - min(x)) / (max(x) - min(x)))
}
concrete_norm  <- as.data.frame(lapply(concrete, normalize))
summary(concrete_norm$strength) #check scale result
summary(concrete$strength) # as comparison

# get train&test dataset, training model
concrete_train <- concrete_norm[1:773, ]
concrete_test <- concrete_norm[774:1030, ]
concrete_model <- neuralnet(strength ~ Cement + Slag + Fly.Ash + Water + Superplasticizer +
                              Coarse.Aggregate + Fine.Aggregate + Age, data = concrete_train)
plot(concrete_model) # error 5.666

# evaluate model performance
model_result <- compute(concrete_model, concrete_test[1:8])
# result of comupte() includes 2 lists: $neurons for storing neruals; $net.results for
# storing predictions
predict_strength <- model_result$net.result
cor(predict_strength, concrete_test$strength) # cor is about 0.72, pretty good

MAE <- function(x, y){
  mean(abs(x - y))
}
MAE(predict_strength, concrete_test$strength) 
# mean absolute error is about 0.085, and strength value range is 0~1, seems okay

# we use default hidden=1 in above model, we can add more hidden
# Improve model performance
concrete_model2 <- neuralnet(strength ~ Cement + Slag + Fly.Ash + Water + Superplasticizer +
                               Coarse.Aggregate + Fine.Aggregate + Age, data = concrete_train, 
                             hidden = 5)
plot(concrete_model2) # error 1.51
model_result1 <- compute(concrete_model2, concrete_test[1:8])
predict_strength2 <- model_result1$net.result
cor(predict_strength2, concrete_test$strength) # cor is 0.8, better than first model
MAE(predict_strength2, concrete_test$strength) # mean absolute error is 0.085, same as model 1


# Try more hidden
concrete_model3 <- neuralnet(strength ~ Cement + Slag + Fly.Ash + Water + Superplasticizer +
                               Coarse.Aggregate + Fine.Aggregate + Age, data = concrete_train, 
                             hidden = 10)
plot(concrete_model3) # error 1.51
model_result1 <- compute(concrete_model3, concrete_test[1:8])
predict_strength3 <- model_result1$net.result
cor(predict_strength3, concrete_test$strength) # cor is 0.8, same as hidden=5
MAE(predict_strength2, concrete_test$strength) # mean absolute error is 0.085, same as model 2
# hidden = 10 shows same performance with hidden = 5

# ANN is pretty good, and hidden=5 is enough for this example