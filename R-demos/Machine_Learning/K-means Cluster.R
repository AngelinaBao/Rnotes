setwd("C:/Users/1000257489/Documents/Angelina/RLanguage/test/ML/K-means Cluster")

#study dataset
teens <- read.csv("snsdata.csv")
str(teens)
table(teens$gender, useNA = "ifany") #gender has NAs
summary(teens$age) # age also has NAs
# for high school teens, age range should between 13 and 20
attach(teens)
teens$age <- ifelse(age >= 13 & age <20, age, NA)
summary(teens$age)

# deal with missing values
#gender
teens$female <- ifelse(gender == "F" & !is.na(gender), 1, 0)
teens$no_gender <- ifelse(is.na(gender), 1, 0)
table(gender, useNA = "ifany")
table(teens$female)
table(teens$no_gender)
#age
mean(age, na.rm = TRUE)
aggregate(age ~ gradyear, teens, mean) # group by gradyear and get age means
# we need ave() to merge the values to our raw data
ave_age <- ave(age, gradyear, FUN = function(x) mean(x, na.rm = TRUE))
teens$age <- ifelse(is.na(age), ave_age, age)
summary(teens$age)

# Training model
library(stats)
interests <- teens[5:40]
# normalize variables
interests_z <- as.data.frame(lapply(interests, scale)) #lapply returns a matrix
# devide teens into 5 clusters
teen_clusters <- kmeans(interests_z, 5)
summary(teen_clusters)
teen_clusters$size
teen_clusters$centers

# Improve model performance
#teen_clusters$cluster contains class of all 30000 teens, add this variable into raw data
teens$cluster <-  teen_clusters$cluster
teens[1:5, c("cluster", "gender", "age", "friends")]
aggregate(age ~ cluster, teens, mean)
aggregate(female ~ cluster, teens, mean) #class 1&4 have large prop female
aggregate(friends ~ cluster, teens, mean) # class 4 also has largest friends
