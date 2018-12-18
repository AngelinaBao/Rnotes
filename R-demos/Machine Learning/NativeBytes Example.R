library(data.table)

setwd("C:\\Users\\1000257489\\Documents\\Angelina\\RLanguage\\test\\SMS Program")
sms_raw <- fread("sms_spam.csv")

# Type is a class variable, so it's better to change it into factor
sms_raw$Type <- factor(sms_raw$Type)

# Data Prepration -- deal with text data
library(tm)
# Corpus() creates a R object to restore text document; VectorSource() directors Corpus() to use vector sms_raw$text
sms_corpus <- Corpus(VectorSource(sms_raw$Text))
#print(sms_corpus)
#inspect(sms_corpus) #review the content
inspect(sms_corpus[1:3])

# tm_map()

# change all letters to lower case and delete all numbers
corpus_clean <- tm_map(sms_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)

# delete stop word
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
# delete punctuation
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, stripWhitespace)

inspect(sms_corpus[1:3])
inspect(corpus_clean[1:3])

#create sparse matrix
sms_dtm <- DocumentTermMatrix(corpus_clean)

## prepare train & test dataset
#75% as train dataset and 25% as test one
sms_raw_train <- sms_raw[1:4179,]
sms_raw_test <- sms_raw[4180:5572,]

# document-words matrix
sms_dtm_train <- sms_dtm[1:4179,]
sms_dtm_test <- sms_dtm[4180:5572,]

#Corpus
sms_corpus_train <- corpus_clean[1:4179]
sms_corpus_test <- corpus_clean[4180:5572]

prop.table(table(sms_raw_train$Type))
prop.table(table(sms_raw_test$Type))

# Visualization text data -- Word clouds
library(wordcloud)
wordcloud(sms_corpus_train, min.freq = 40, random.order = FALSE)

# split spam & ham massages
spam <- sms_raw_train[Type == "spam"]
ham <- sms_raw_train[Type == "ham"]

wordcloud(spam$Text, max.words = 40, scale = c(3, 0.5))
wordcloud(ham$Text, max.words = 40, scale = c(3, 0.5))


# delete words occurred less than 5 times
sms_dict <- findFreqTerms(sms_dtm_train, 5)

sms_train <- DocumentTermMatrix(sms_corpus_train, list(dictionary = sms_dict))
sms_test <- DocumentTermMatrix(sms_corpus_test, list(dictionary = sms_dict))

convert_counts <- function(x){
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
  return(x)
}
sms_train <- apply(sms_train, MARGIN = 2, convert_counts)
sms_test <- apply(sms_test, MARGIN = 2, convert_counts)


## Modeling
install.packages("e1071")
library(e1071)
sms_classifier <- naiveBayes(sms_train, sms_raw_train$Type)

# evaluate performance of Model
sms_test_pred <- predict(sms_classifier, sms_test)

#Check the prediction & real values
library(gmodels)
CrossTable(sms_test_pred, sms_raw_test$Type,
           prop.chisq = FALSE, prop.r = FALSE, prop.t = FALSE,
           dnn = c('predicted', 'actual'))

# Improve Model performance
sms_classifier2 <- naiveBayes(sms_train, sms_raw_train$Type, laplace = 0.01)
sms_test_pred2 <- predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, sms_raw_test$Type,
           prop.chisq = FALSE, prop.r = FALSE, prop.t = FALSE,
           dnn = c("predicted", "actual"))
