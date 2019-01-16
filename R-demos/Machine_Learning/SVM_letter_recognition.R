#install.packages("kernlab")
library(kernlab)

setwd("C:\\Users\\1000257489\\Documents\\Angelina\\RLanguage\\test\\ML")
letters <- read.csv("letterdata.csv")
str(letters)
# dataset order is random
letters_train <- letters[1:16000, ]
letters_test <- letters[16001:20000, ]

letter_classifier <- ksvm(lettr ~ ., data = letters_train, kernel = "vanilladot")
letter_predictions <- predict(letter_classifier, letters_test)
table(letter_predictions, letters_test$lettr)
agreement <- letter_predictions == letters_test$lettr
table(agreement)
prop.table(table(agreement)) #accurate percent 83.93%

# improve model performance -- use rbf kernel fuction
letter_classifier_rbf <- ksvm(lettr ~ ., data = letters_train, kernel = "rbfdot", C = )
letter_predictions_rbf <- predict(letter_classifier_rbf, letters_test)
agreement_rbf <- letter_predictions_rbf == letters_test$lettr
table(agreement_rbf)
prop.table(table(agreement_rbf)) #accurate percent 93%

# try other kernel functions
letter_classifier_anov <- ksvm(lettr ~ ., data = letters_train, kernel = "anovadot")
letter_predictions_anov <- predict(letter_classifier_anov, letters_test)
table(letter_predictions_anov, letters_test$lettr)
agreement_anov <- letter_predictions_anov == letters_test$lettr
table(agreement_anov)
prop.table(table(agreement_anov)) #accurate percent 92.03%
