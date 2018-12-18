#Titanic生存预测实践分享
#下载并导入需要的包
library("ggplot2") #绘图包
library("ggthemes") #ggplot2的主题修改包
library("scales") #可视化的包
library("dplyr") #操作数据的包
library("mice") #插补数据的包
library("randomForest") #经典的分类算法包
#导入数据并将两个数据集合并，合并后可以对练习数据和测试数据进行同步处理。
train <- read.csv("D:/R/train.csv", stringsAsFactors = F)
test <- read.csv("D:/R/test.csv", stringsAsFactors = F)
full <-  bind_rows(train,test)
#观察下合并后数据的内部结构。str函数可以非常简洁的展示R对象的内部结构
str(full) 
#发现有12个变量，1309个观察值
#下面我们看看每个变量中缺失值的情况，缺失值比例太大的变量就不能用来作为预测的依据
#summary函数可以对数值型变量展示最小值、最大值、四分位数、均值和缺失值的数量
summary(full$Pclass)
summary(full$Age)
summary(full$SibSp)
summary(full$Parch)
summary(full$Fare)
#发现这几个数值型变量中，Age有263个缺失值，Fare有1个缺失值
#对于其余字符型变量，自己写个查看缺失值的函数，查看缺失值的数量
na_fun <- function(x){
  i <- 1
  na_x <- 0
  while (i <= nrow(full)) {
    if (x[i] == "") {
      na_x <- na_x + 1
    }
    i = i + 1
  }
  return(na_x)
}
#看看其余几个字符型变量的缺失值数量
na_fun(full$Name)
na_fun(full$Sex)
na_fun(full$Ticket)
na_fun(full$Cabin)
na_fun(full$Embarked)
#发现Name、Sex、Ticket缺失值为0，Cabin缺失值有1014个，Embarked缺失值有2个。Cabin缺失值太多，缺失值占整个观察值的78%，在预测时对该变量不进行参考
#删除Cabin变量
newfull <- select(full, -Cabin)
#接下来处理Age、Fare、Embarked三个变量的缺失值
#Age变量缺失数据表多，采用多重插补方法
mice_mod <- mice(newfull[, !names(newfull) %in% c("PassengerId", "Name", "Survived")], method = "rf")
mice_output <- complete(mice_mod)
newfull$Age <- mice_output$Age
#Fare、Embarked变量缺失数据较少采用简单（非随机）插补
#找到缺失值位置
which(is.na(newfull$Fare))
which(newfull$Embarke == "")
newfull$Fare[1044] <- as.numeric(median(newfull$Fare, na.rm = TRUE))
newfull$Embarked[c(62, 830)] <- "C"
#确认下有没有缺失值没有处理
complete.cases(newfull)
#可以看到前891行已经没有缺失值了，后面有缺失值是因为测试数据中Survivedz变量值缺失
#现在可以进行特征工程了，就是基于对每个变量的理解，对变量进行进一步开发
#首先，将Name变量转换成字符型变量，然后从Name变量中分离出头衔，形成新变量Title
newfull$Name <- as.character(newfull$Name)
newfull$Title <- sapply(newfull$Name, FUN = function(x){strsplit(x, split = "[,.]")[[1]][2]})
#[,.]是正则表达式表示截取由,.的部分，可能有好几段都含有,.[[1]]表示取第一段，[2]表示取第一段的第二部分。
#把Title前面的空格去掉
newfull$Title <- sub(" ", "", newfull$Title)
#将Title进行分组
officer <- c("Capt","Col", "Don", "Dr", "Major", "Rev")
royalty <- c("Dona","Lady","the Countess", "Sir", "Jonkheer")
newfull$Title[newfull$Title == "Mlle"] <- "Miss"
newfull$Title[newfull$Title == "Ms"] <- "Miss"
newfull$Title[newfull$Title == "Mme"] <- "Mrs"
newfull$Title[newfull$Title %in% royalty] <- "Royalty"
newfull$Title[newfull$Title %in% officer] <- "Officer"
#创建新变量家庭成员数
newfull$Fsize <- newfull$SibSp + newfull$Parch + 1
#对家庭成员规模进行分类
newfull$FsizeD[newfull$Fsize == 1] <- "Single"
newfull$FsizeD[newfull$Fsize > 1 & newfull$Fsize <= 5] <- "Small"
newfull$FsizeD[newfull$Fsize > 5] <- "Large"
#对年龄进行分组
newfull$Child[newfull$Age < 18] <- "Child"
newfull$Child[newfull$Age >= 18] <- "Adult"
#将变量名转换成因子
factor_vars <- c("PassengerId", "Pclass", "Sex", "Embarked", "Title", "FsizeD", "Child")
newfull[factor_vars] <- lapply(newfull[factor_vars], function(x) as.factor(x))
#分离数据集
train <- newfull[1:891,]
test <- newfull[892:1309,]
#建立随机森林模型，可以通过不断调整预测使用的变量，以及对变量不断的深入挖掘去预测
#re_model <- randomForest(factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + FsizeD + Title + Child, data = train)
re_model <- randomForest(factor(Survived) ~ Title + Sex + Fare + Pclass + FsizeD + Child + Embarked, data = train)
#展示模型的准确率
plot(re_model, ylim = c(0, 0.36))
legend("topright", colnames(re_model$err.rate), col = 1:3, fill = 1:3)
#对test数据进行预测。
prediction <- predict(re_model, test)
#把预测结果保存到数据框，列分别命名为PassengerId和Survived(prediction).
solution <- data.frame(PassengerID = test$PassengerId, Survived = prediction)
#把预测结果写入文件。
write.csv(solution, file = "D:/R/my_rf_mod_Solution10.csv", row.names = F)
